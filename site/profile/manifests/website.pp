class profile::website (
  Hash $vhosts,
) {
  $docroot = '/var/www/vhost'

  class { 'apache':
    default_vhost => false,
  }

  group { 'www-data':
    ensure => present,
  }

  user { 'www-data':
    ensure => present,
    shell  => '/bin/true',
    gid    => 'www-data',
  }

  file { $docroot:
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
  }

  $vhosts.each |Integer $index, String $vhost| {
    apache::vhost { $vhost:
      port          => 8000 + $index,
      docroot       => "${docroot}/${vhost}",
      docroot_owner => 'www-data',
      docroot_group => 'www-data',
    }

    file { "${docroot}/${vhost}/index.html":
      ensure => present,
      owner => 'www-data',
      group => 'www-data',
      content => "<HTML><HEAD><TITLE>Test website ${vhost}</TITLE></HEAD><BODY>Just a test website for vhost ${vhost}.</BODY></HTML>",
    }
  }
}
