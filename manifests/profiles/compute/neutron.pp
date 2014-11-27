class juno::profiles::compute::neutron {

  anchor { 'juno::profiles::compute::neutron::begin': }
  anchor { 'juno::profiles::compute::neutron::end': }
  Class {
    require => Anchor['juno::profiles::compute::neutron::begin'],
    before  => Anchor['juno::profiles::compute::neutron::end'],
  }

  # Get the internal IP of the compute node
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
    'cubbystack::neutron::plugins::ml2':
      settings => $ml2_merged;
    'cubbystack::neutron::plugins::linuxbridge':;
  }

}
