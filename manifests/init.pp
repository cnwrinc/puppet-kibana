class kibana {
  include kibana::install
  include kibana::apache

  Class['kibana::install'] -> Class['kibana::apache']
}

