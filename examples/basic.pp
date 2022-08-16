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

class { 'ccs_sal':
  rpms => {
    ts_sal_utils => 'ts_sal_utils-7.0.0-1.x86_64.rpm',
  },
}
