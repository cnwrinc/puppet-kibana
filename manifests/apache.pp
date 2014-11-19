class kibana::apache {

  class { '::apache':
    default_vhost => false,
  }

  apache::vhost { 'kibana':
    docroot => '/var/www/kibana/src/',
    port    => '80',
    require => Class['kibana::install'],
  }

}
