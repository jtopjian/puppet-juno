class juno::profiles::controller::keystone {

  anchor { 'juno::profiles::controller::keystone::begin': }
  anchor { 'juno::profiles::controller::keystone::end': }
  Class {
    require => Anchor['juno::profiles::controller::keystone::begin'],
    before  => Anchor['juno::profiles::controller::keystone::end'],
  }

  # Get the External and Internal IPs for the Keystone endpoints
  $external_address = hiera('network::external::ip')
  $internal_address = hiera('network::internal::ip')

  # Get the Region
  $region = hiera('openstack::region')

  class { 'cubbystack::keystone':
    settings => hiera('openstack::keystone::settings'),
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/identity":
    public_url   => "http://${external_address}:5000/v2.0",
    admin_url    => "http://${external_address}:35357/v2.0",
    internal_url => "http://${internal_address}:5000/v2.0",
    service_name => 'OpenStack Identity Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/image":
    public_url   => "http://${external_address}:9292",
    admin_url    => "http://${external_address}:9292",
    internal_url => "http://${internal_address}:9292",
    service_name => 'OpenStack Image Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/volume":
    public_url   => "http://${external_address}:8776/v1/%(tenant_id)s",
    admin_url    => "http://${external_address}:8776/v1/%(tenant_id)s",
    internal_url => "http://${internal_address}:8776/v1/%(tenant_id)s",
    service_name => 'OpenStack Volume Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/compute":
    public_url   => "http://${external_address}:8774/v2/%(tenant_id)s",
    admin_url    => "http://${external_address}:8774/v2/%(tenant_id)s",
    internal_url => "http://${internal_address}:8774/v2/%(tenant_id)s",
    service_name => 'OpenStack Compute Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/ec2":
    public_url   => "http://${external_address}:8773/services/Cloud",
    admin_url    => "http://${external_address}:8773/services/Cloud",
    internal_url => "http://${internal_address}:8773/services/Cloud",
    service_name => 'OpenStack EC2 Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/network":
    public_url   => "http://${external_address}:9696",
    admin_url    => "http://${external_address}:9696",
    internal_url => "http://${internal_address}:9696",
    service_name => 'OpenStack Networking Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/object-store":
    public_url   => "http://${external_address}:8080/v1/AUTH_%(tenant_id)s",
    admin_url    => "http://${external_address}:8080",
    internal_url => "http://${internal_address}:8080/v1/AUTH_%(tenant_id)s",
    service_name => 'OpenStack Object Storage Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/orchestration":
    public_url   => "http://${external_address}:8004/v1/%(tenant_id)s",
    admin_url    => "http://${external_address}:8004/v1/%(tenant_id)s",
    internal_url => "http://${internal_address}:8004/v1/%(tenant_id)s",
    service_name => 'OpenStack Orchestration Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/cloudformation":
    public_url   => "http://${external_address}:8000/v1/",
    admin_url    => "http://${external_address}:8000/v1/",
    internal_url => "http://${internal_address}:8000/v1/",
    service_name => 'OpenStack Cloudformation Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/database":
    public_url   => "http://${external_address}:8779/v1.0/%(tenant_id)s",
    admin_url    => "http://${external_address}:8779/v1.0/%(tenant_id)s",
    internal_url => "http://${internal_address}:8779/v1.0/%(tenant_id)s",
    service_name => 'OpenStack Database Service',
    tag          => $region,
  }


}
