class juno::profiles::controller::nova {

  anchor { 'juno::profiles::controller::nova::begin': }
  anchor { 'juno::profiles::controller::nova::end': }
  Class {
    require => Anchor['juno::profiles::controller::nova::begin'],
    before  => Anchor['juno::profiles::controller::nova::end']
  }

  class { 'cubbystack::nova':
    settings => hiera('openstack::nova::settings'),
  }
  class { 'cubbystack::nova::api': }
  class { 'cubbystack::nova::cert': }
  class { 'cubbystack::nova::conductor': }
  class { 'cubbystack::nova::objectstore': }
  class { 'cubbystack::nova::scheduler': }
  class { 'cubbystack::nova::vncproxy': }
  class { 'cubbystack::nova::db_sync': }

  ## Generate an openrc file
  cubbystack::functions::create_openrc { '/root/openrc':
    keystone_host        => hiera('openstack::cloud_controller'),
    keystone_api_version => 'v2.0',
    admin_password       => hiera('openstack::keystone::admin::password'),
    admin_tenant         => 'admin',
    region               => hiera('openstack::region'),
  }

}
