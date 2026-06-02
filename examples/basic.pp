group { 'ccsadm':
  ensure => present,
  system => true,
}
-> user { 'ccsadm':
  ensure     => present,
  gid        => 'ccsadm',
  home       => '/',
  managehome => false,
  shell      => '/sbin/nologin',
  system     => true,
}

include ccs_sal
