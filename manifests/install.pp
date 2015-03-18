class kibana::install (
  $version = '3.1.2',
  $site = 'https://github.com/elasticsearch/kibana/archive/',
  $target = '/var/www/kibana',
  $archtarget = '/opt/',
) {
  validate_string($version)
  validate_string($site)

  $archive = "v${version}.tar.gz"
  $downloadurl = "${site}/${archive}"

  file { $archtarget:
    ensure => directory,
  }

  file { $target:
    ensure => directory,
  }

  # We use curl to download
  package { 'curl':
    ensure => present,
  }

  exec { 'download-kibana':
    command => "curl -L -s -S -k -o ${archtarget}/${archive} ${downloadurl}",
    path    => '/bin:/usr/bin',
    creates => "${archtarget}/${archive}",
    require => [Package['curl'], File[$archtarget], File[$target]],
    notify  => Exec['extract-kibana'],
  }

  exec { 'extract-kibana':
    command     => "tar --strip-components=1 -zxf ${archtarget}/${archive} -C ${target}",
    path        => '/bin:/usr/bin',
    refreshonly => true,
  }

}

