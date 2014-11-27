class juno::profiles::controller::heat {

  anchor { 'juno::profiles::controller::heat::begin': }
  anchor { 'juno::profiles::controller::heat::end': }
  Class {
    require => Anchor['juno::profiles::controller::heat::begin'],
    before  => Anchor['juno::profiles::controller::heat::end']
  }

  class { 'cubbystack::heat':
    settings => hiera('openstack::heat::settings'),
  }
  class { 'cubbystack::heat::api': }
  class { 'cubbystack::heat::api_cfn': }
  class { 'cubbystack::heat::api_cloudwatch': }
  class { 'cubbystack::heat::engine': }
  class { 'cubbystack::heat::db_sync': }

}
