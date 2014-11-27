class juno::roles::swift_node {

  anchor { 'juno::profiles::swift::node': }
  Class { require => Anchor['juno::profiles::swift::node'] }

  # Determine the IP address
  $ip = hiera('network::internal::ip')

  $swift_disks = hiera('openstack::swift::disks')

  package { 'xfsprogs':
    ensure => latest,
  }

  file { '/srv/node':
    ensure => directory,
    owner  => 'swift',
    group  => 'swift',
    mode   => '0644',
  }

  cubbystack::functions::create_swift_device { $swift_disks:
    swift_zone => $::swift_zone,
    ip         => $ip,
    require    => [File['/srv/node'], Package['xfsprogs']],
  }

  class { 'cubbystack::repo':
    release => 'juno',
  } ->
  class { 'juno::profiles::common::users': }
  class { 'cubbystack::swift':
    settings => hiera('openstack::swift::settings'),
    require  => Class['juno::profiles::common::users'],
  }
  class { 'juno::profiles::swift::rsync':
    require  => Class['juno::profiles::common::users'],
  }
  class { 'juno::profiles::swift::account':
    require  => Class['juno::profiles::common::users'],
  }
  class { 'juno::profiles::swift::container':
    require  => Class['juno::profiles::common::users'],
  }
  class { 'juno::profiles::swift::object':
    require  => Class['juno::profiles::common::users'],
  }

}
