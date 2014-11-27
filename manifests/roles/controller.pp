class juno::roles::controller {

  class { 'cubbystack::repo':
    release => 'juno'
  } ->
  class { 'juno::profiles::common::users': } ->
  class { 'juno::profiles::common::memcached': } ->
  class { 'juno::profiles::common::utils': } ->
  class { 'juno::profiles::controller::mysql': } ->
  class { 'juno::profiles::controller::rabbitmq': } ->
  class { 'juno::profiles::controller::keystone': } ->
  class { 'juno::profiles::controller::glance': } ->
  class { 'juno::profiles::controller::nova': } ->
  class { 'juno::profiles::controller::cinder': } ->
  class { 'juno::profiles::controller::neutron': } ->
  class { 'juno::profiles::controller::heat': } ->
  #class { 'juno::profiles::controller::trove': } ->
  class { 'juno::profiles::controller::horizon': }

}
