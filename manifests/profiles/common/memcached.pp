class juno::profiles::common::memcached {

  anchor { 'juno::profiles::common::memcached::begin': }
  anchor { 'juno::profiles::common::memcached::end': }
  Class {
    require => Anchor['juno::profiles::common::memcached::begin'],
    before  => Anchor['juno::profiles::common::memcached::end'],
  }

  class { '::memcached':
    listen_ip => '127.0.0.1',
  }

  case $::operatingsystem {
    'Ubuntu': {
      package { 'python-memcache':
        ensure => latest,
      }
    }
  }

}
