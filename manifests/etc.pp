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

  $bridge = "${dir}/ocs-bridge-${instrument}.app"
  $gui = "${dir}/ocs-bridge-${instrument}.app"

  ['bridge', 'gui'].each|$thing| {
    $file = "${dir}/ocs-${thing}-${instrument}.app"
    file { $file:
      ensure  => present,
      content => "system.pre-execute=${salfile}\n",
      *       => $attributes,
    }
  }


}
