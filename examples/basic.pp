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
    ts_sal_utilsKafka => 'ts_sal_utilsKafka-10.1.1-1.x86_64.rpm',
  },
}
