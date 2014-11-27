class juno::roles::swift_proxy {

  anchor { 'juno::roles::swift_proxy': }
  Class { require => Anchor['juno::roles::swift_proxy'] }

  class { 'cubbystack::repo':
    release => 'juno',
  } ->
  class { 'juno::profiles::common::users': }
  class { 'juno::profiles::common::memcached': }
  class { 'cubbystack::swift':
    settings => hiera('openstack::swift::settings'),
    require  => Class['juno::profiles::common::users'],
  }
  class { 'juno::profiles::swift::rsync':
    require  => Class['juno::profiles::common::users']
  }
  class { 'juno::profiles::swift::rings':
    require  => Class['juno::profiles::common::users']
  }
  class { 'cubbystack::swift::proxy':
    settings => hiera('openstack::swift::proxy::settings'),
    require  => Class['juno::profiles::common::users']
  }

  # Extra packages
  $packages = ['swift-plugin-s3', 'python-keystone', 'python-keystoneclient']
  package { $packages:
    ensure => latest,
  }

  # sets up an rsync service that can be used to sync the ring DB
  rsync::server::module { 'swift_server':
    path            => '/etc/swift',
    lock_file       => '/var/lock/swift_server.lock',
    uid             => 'swift',
    gid             => 'swift',
    max_connections => 5,
    read_only       => true,
  }

}
