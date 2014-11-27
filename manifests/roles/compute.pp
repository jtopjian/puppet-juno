class juno::roles::compute {

  class { 'cubbystack::repo':
    release => 'juno'
  } ->
  class { 'juno::profiles::common::users': } ->
  class { 'juno::profiles::compute::nova': } ->
  class { 'juno::profiles::compute::neutron': }

}
