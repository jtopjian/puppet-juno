class juno::profiles::controller::mysql {

  anchor { 'juno::profiles::controller::mysql::begin': }
  anchor { 'juno::profiles::controller::mysql::end': }
  Class {
    require => Anchor['juno::profiles::controller::mysql::begin'],
    before  => Anchor['juno::profiles::controller::mysql::end']
  }

  $allowed_hosts = hiera('openstack::mysql::allowed_hosts')

  class { 'mysql::server':
    root_password           => hiera('openstack::mysql::root_password'),
    remove_default_accounts => true,
    restart                 => true,
    override_options        => {
      'mysqld' => {
        'bind_address' => '0.0.0.0',
      }
    },
  }

  include mysql::bindings
  include mysql::bindings::python

  cubbystack::functions::create_mysql_db { 'keystone':
    user          => 'keystone',
    password      => hiera('openstack::keystone::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'glance':
    user          => 'glance',
    password      => hiera('openstack::glance::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'cinder':
    user          => 'cinder',
    password      => hiera('openstack::cinder::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'nova':
    user          => 'nova',
    password      => hiera('openstack::nova::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'neutron':
    user          => 'neutron',
    password      => hiera('openstack::neutron::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'heat':
    user          => 'heat',
    password      => hiera('openstack::heat::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'trove':
    user          => 'trove',
    password      => hiera('openstack::trove::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }


}
