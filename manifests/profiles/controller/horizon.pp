class juno::profiles::controller::horizon {

  anchor { 'juno::profiles::controller::horizon::begin': }
  anchor { 'juno::profiles::controller::horizon::end': }
  Class {
    require => Anchor['juno::profiles::controller::horizon::begin'],
    before  => Anchor['juno::profiles::controller::horizon::end']
  }

  class { 'cubbystack::horizon':
    config_file => 'puppet:///modules/juno/horizon/local_settings.py'
  }

  file_line { 'horizon root url':
    path    => '/etc/apache2/conf-enabled/openstack-dashboard.conf',
    line    => 'WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi',
    match   => 'WSGIScriptAlias ',
    require => Class['cubbystack::horizon'],
  }

}
