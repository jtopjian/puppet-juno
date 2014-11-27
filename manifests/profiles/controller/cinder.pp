class juno::profiles::controller::cinder {

  anchor { 'juno::profiles::controller::cinder::begin': }
  anchor { 'juno::profiles::controller::cinder::end': }
  Class {
    require => Anchor['juno::profiles::controller::cinder::begin'],
    before  => Anchor['juno::profiles::controller::cinder::end'],
  }

  class { 'cubbystack::cinder':
    settings => hiera('openstack::cinder::settings'),
  }
  class { 'cubbystack::cinder::api': }
  class { 'cubbystack::cinder::scheduler': }
  class { 'cubbystack::cinder::volume': }
  class { 'cubbystack::cinder::db_sync': }

}
