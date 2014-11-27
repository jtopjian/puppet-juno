class juno::profiles::swift::object {

  anchor { 'juno::profiles::swift::object': }
  Class { require => Anchor['juno::profiles::swift::object'] }

  rsync::server::module { 'object':
    path            => '/srv/node',
    lock_file       => "/var/lock/object.lock",
    uid             => 'swift',
    gid             => 'swift',
    max_connections => 25,
    read_only       => false,
  }

  $ring_server = hiera('openstack::swift_proxy')
  rsync::get { '/etc/swift/object.ring.gz':
    source => "rsync://${ring_server}/swift_server/object.ring.gz",
  }

  class { 'cubbystack::swift::object':
    settings => hiera('openstack::swift::object::settings'),
  }

}
