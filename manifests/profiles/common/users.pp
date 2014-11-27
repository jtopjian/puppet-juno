class juno::profiles::common::users {

  $users = hiera('openstack::users')

  $users.each |$user, $data| {
    cubbystack::functions::create_system_user { $user:
      uid => $data['uid'],
      gid => $data['gid'],
    }
  }

}
