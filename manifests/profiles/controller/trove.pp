class juno::profiles::controller::trove {

  anchor { 'juno::profiles::controller::trove::begin': }
  anchor { 'juno::profiles::controller::trove::end': }
  Class {
    require => Anchor['juno::profiles::controller::trove::begin'],
    before  => Anchor['juno::profiles::controller::trove::end']
  }

  # For the cloudinit template
  $cloud_controller = hiera('network::internal::ip')
  $rabbit_password  = hiera('openstack::rabbitmq::password')
  $nova_password    = hiera('openstack::nova::keystone::password')

  class { 'cubbystack::trove':
    settings => hiera('openstack::trove::settings'),
  }
  class { 'cubbystack::trove::api': }
  class { 'cubbystack::trove::taskmanager':
    settings => hiera('openstack::trove::taskmanager::settings'),
  }
  class { 'cubbystack::trove::conductor':
    settings => hiera('openstack::trove::conductor::settings'),
  }
  class { 'cubbystack::trove::api_paste':
    settings => hiera('openstack::trove::api_paste::settings'),
  }
  class { 'cubbystack::trove::db_sync': }

  file { '/etc/init/trove-conductor.conf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    source => 'puppet:///modules/juno/trove/trove-conductor.conf',
    before => Class['cubbystack::trove::conductor'],
  }

  file { '/etc/trove/cloudinit/mysql.cloudinit':
    ensure  => present,
    owner   => 'trove',
    group   => 'trove',
    mode    => '0640',
    content => template('juno/trove/mysql.cloudinit.erb'),
    require => Class['cubbystack::trove'],
  }

  file { '/etc/trove/api-paste.ini':
    ensure  => present,
    owner   => 'trove',
    group   => 'trove',
    mode    => '0640',
    replace => false,
    source  => 'puppet:///modules/juno/trove/api-paste.ini',
    require => Class['cubbystack::trove'],
    before  => Class['cubbystack::trove::api_paste'],
  }

}
