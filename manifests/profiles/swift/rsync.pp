class juno::profiles::swift::rsync {

  anchor { 'juno::profiles::swift::rsync': }
  Class { require => Anchor['juno::profiles::swift::rsync'] }

  # Determine the IP address
  $ip = hiera('network::internal::ip')

  class { 'rsync::server':
    use_xinetd => true,
    address    => $ip,
    use_chroot => 'no'
  }

}
