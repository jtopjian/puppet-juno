class juno::profiles::swift::account {

  anchor { 'juno::profiles::swift::account': }
  Class { require => Anchor['juno::profiles::swift::account'] }

  rsync::server::module { 'account':
    path            => '/srv/node',
    lock_file       => "/var/lock/account.lock",
    uid             => 'swift',
    gid             => 'swift',
    max_connections => 25,
    read_only       => false,
  }

  $ring_server = hiera('openstack::swift_proxy')
  rsync::get { '/etc/swift/account.ring.gz':
    source => "rsync://${ring_server}/swift_server/account.ring.gz",
  }

  class { 'cubbystack::swift::account':
    settings => hiera('openstack::swift::account::settings'),
  }
}
