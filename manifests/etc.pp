# @summary
#   Configure /etc for CCS/SAL
#
class ccs_sal::etc {
  $dds = $ccs_sal::dds
  $kafka = $ccs_sal::kafka

  $prefix_service = $ccs_sal::prefix_service

  $dir = '/etc/ccs'

  $attributes = {
    'owner' => 'ccsadm',
    'group' => 'ccsadm',
    'mode'  => '0664',
  }

  $ptitle = regsubst($title, '::.*', '', 'G')

  $salfile = 'setup-sal5'
  $kafka_salfile = 'setup-sal-kafka'
  $prefile = 'setup-sal'

  file { "${dir}/${prefile}":
    ensure => file,
    source => "puppet:///modules/${ptitle}/${prefile}",
    *      => $attributes,
  }

  if $kafka {
    $implementation = 'system.property.org.lsst.sal.implementation=kafka'
  } else {
    $implementation = undef
  }

  if $kafka {
    file { "${dir}/${kafka_salfile}":
      ensure  => file,
      content => epp("${ptitle}/${kafka_salfile}.epp", {
          'broker_address' => $ccs_sal::kafka_broker_address,
          'sasl_username'  => $ccs_sal::kafka_sasl_username,
          'sasl_password'  => $ccs_sal::kafka_sasl_password,
          'registry_url'   => $ccs_sal::kafka_registry_url,
        },
      ),
      *       => $attributes,
    }
  }

  if $dds {
    file { "${dir}/${salfile}":
      ensure  => file,
      content => epp("${ptitle}/${salfile}.epp", {
          'domain'    => $ccs_sal::dds_domain,
          'interface' => $ccs_sal::dds_interface,
          'home'      => $ccs_sal::ospl_home,
          'java_home' => $ccs_sal::java_home,
          'extra'     => $ccs_sal::dds_extra,
        },
      ),
      *       => $attributes,
    }

    ['ospl-shmem.xml', 'QoS.xml'].each|$thing| {
      $file = "${dir}/${thing}"
      file { $file:
        ensure => file,
        source => "puppet:///modules/${ptitle}/${thing}",
        *      => $attributes,
      }
    }
  }

  if $prefix_service {
    $prefix = "${$ccs_sal::instrument}-"
  } else {
    $prefix = ''
  }

  ['bridge', 'gui'].each|$thing| {
    $file = "${dir}/${prefix}ocs-${thing}.app"
    file { $file:
      ensure  => file,
      content => epp("${ptitle}/ocs-app.epp", {
          'prefile' => $prefile,
          'extra'   => $implementation,
        },
      ),
      *       => $attributes,
    }
  }

  if $dds {
    ## Stop tmpfiles.d removing opensplice sockets.
    $tmpfiles_conf = 'ccs-ospl.conf'

    file { "/etc/tmpfiles.d/${tmpfiles_conf}":
      ensure => file,
      source => "puppet:///modules/${ptitle}/${tmpfiles_conf}",
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
  }

  $lfa = $ccs_sal::lfa

  unless empty($lfa) {
    file { "${dir}/lfa.properties":
      ensure  => file,
      owner   => 'ccs',
      group   => 'ccsadm',
      mode    => '0660',
      content => epp("${ptitle}/lfa.epp", $lfa ),
    }
  }
}
