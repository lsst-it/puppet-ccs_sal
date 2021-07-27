class ccs_sal::etc {

  $dir = '/etc/ccs'

  $attributes = {
    'owner' => 'ccsadm',
    'group' => 'ccsadm',
    'mode'  => '0664',
  }


  $ptitle = regsubst($title, '::.*', '', 'G')

  $salfile = 'setup-sal5'

  file { "${dir}/${salfile}":
    ensure  => file,
    content => epp("${ptitle}/${salfile}", {
        'domain'    => $ccs_sal::dds_domain,
        'interface' => $ccs_sal::dds_interface,
        'home'      => $ccs_sal::ospl_home,
      },
    ),
    *       => $attributes,
  }


  ['ospl-shmem.xml', 'QoS.xml'].each|$thing| {
    $file = "${dir}/${thing}"
    file { $file:
      ensure => present,
      source => "puppet:///modules/${ptitle}/${thing}",
      *      => $attributes,
    }
  }


  $instrument = $ccs_sal::instrument

  ['bridge', 'gui'].each|$thing| {
    $file = "${dir}/${instrument}-ocs-${thing}.app"
    file { $file:
      ensure  => present,
      content => "system.pre-execute=${salfile}\n",
      *       => $attributes,
    }
  }


  ## Stop tmpfiles.d removing opensplice sockets.
  $tmpfiles_conf = 'ccs-ospl.conf'

  file { "/etc/tmpfiles.d/${tmpfiles_conf}":
    ensure => present,
    source => "puppet:///modules/${ptitle}/${tmpfiles_conf}",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

}
