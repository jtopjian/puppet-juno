class juno::profiles::compute::nova {

  anchor { 'juno::profiles::compute::nova::begin': }
  anchor { 'juno::profiles::compute::nova::end': }
  Class {
    require => Anchor['juno::profiles::compute::nova::begin'],
    before  => Anchor['juno::profiles::compute::nova::end'],
  }

  class { 'cubbystack::nova':
    settings => hiera('openstack::nova::settings'),
  }

  class { 'cubbystack::nova::compute': }

  case $::operatingsystem {
    'Ubuntu': {
      class { 'cubbystack::nova::compute::libvirt':
        libvirt_type => hiera('openstack::nova::compute::libvirt_type'),
      }
    }
  }

}
