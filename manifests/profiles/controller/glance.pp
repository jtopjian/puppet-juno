class juno::profiles::controller::glance {

  anchor { 'juno::profiles::controller::glance::begin': }
  anchor { 'juno::profiles::controller::glance::end': }
  Class {
    require => Anchor['juno::profiles::controller::glance::begin'],
    before  => Anchor['juno::profiles::controller::glance::end'],
  }

  class { 'cubbystack::glance': }
  class { 'cubbystack::glance::api':
    settings => hiera('openstack::glance::api::settings'),
  }
  class { 'cubbystack::glance::registry':
    settings => hiera('openstack::glance::registry::settings'),
  }
  class { 'cubbystack::glance::cache':
    settings => hiera('openstack::glance::cache::settings'),
  }
  class { 'cubbystack::glance::db_sync': }

}
