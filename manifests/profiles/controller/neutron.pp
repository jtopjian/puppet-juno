class juno::profiles::controller::neutron {

  anchor { 'juno::profiles::controller::neutron::begin': }
  anchor { 'juno::profiles::controller::neutron::end': }
  Class {
    require => Anchor['juno::profiles::controller::neutron::begin'],
    before  => Anchor['juno::profiles::controller::neutron::end']
  }

  # Get the Internal IP of the controller
  $internal_address = hiera('network::internal::ip')

  # Determine the internal address for vxlan
  $vxlan = {
    'vxlan/local_ip' => $internal_address,
  }

  # merge the two settings
  $ml2_settings = hiera('openstack::neutron::plugins::ml2::settings')
  $ml2_merged = merge($ml2_settings, $vxlan)

  class {
    'cubbystack::neutron':
      settings => hiera('openstack::neutron::settings');
    'cubbystack::neutron::dhcp':
      settings => hiera('openstack::neutron::dhcp::settings');
    'cubbystack::neutron::l3':
      settings => hiera('openstack::neutron::l3::settings');
    'cubbystack::neutron::metadata':
      settings => hiera('openstack::neutron::metadata::settings');
    'cubbystack::neutron::plugins::ml2':
      settings => $ml2_merged;
    'cubbystack::neutron::fwaas':
      settings => hiera('openstack::neutron::fwaas::settings');
    'cubbystack::neutron::plugins::linuxbridge':;
    'cubbystack::neutron::server':;
  }

  case $::lsbdistid {
    'Ubuntu': {
      file_line { '/etc/default/neutron-server NEUTRON_PLUGIN_CONFIG':
        path    => '/etc/default/neutron-server',
        line    => 'NEUTRON_PLUGIN_CONFIG="/etc/neutron/plugins/ml2/ml2_conf.ini"',
        match   => '^NEUTRON_PLUGIN_CONFIG',
        require => Class['cubbystack::neutron::plugins::ml2'],
      }
    }
  }

}
