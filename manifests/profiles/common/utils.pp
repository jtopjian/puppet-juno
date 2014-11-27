class juno::profiles::common::utils {

  $utils = [
    'python-openstackclient',
    'python-novaclient',
    'python-glanceclient',
    'python-keystoneclient',
    'python-cinderclient',
    'python-swiftclient',
  ]

  package { $utils:
    ensure => latest,
  }

}
