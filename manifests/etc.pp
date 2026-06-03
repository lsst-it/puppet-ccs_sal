# @summary
#   Configure /etc for CCS/SAL
#
class ccs_sal::etc {
  $prefix_service = $ccs_sal::prefix_service

  $dir = '/etc/ccs'

  $attributes = {
    'owner' => 'ccsadm',
    'group' => 'ccsadm',
    'mode'  => '0664',
  }

  $ptitle = regsubst($title, '::.*', '', 'G')

  $prefile = 'setup-sal'
  $oldfile = 'setup-sal-kafka'

  file { "${dir}/${prefile}":
    ensure  => file,
    content => epp("${ptitle}/${prefile}.epp", {
        'broker_address' => $ccs_sal::kafka_broker_address,
        'sasl_username'  => $ccs_sal::kafka_sasl_username,
        'sasl_password'  => $ccs_sal::kafka_sasl_password,
        'registry_url'   => $ccs_sal::kafka_registry_url,
      },
    ),
    *       => $attributes,
  }

  file { "${dir}/${oldfile}":
    ensure => link,
    target => $prefile,
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
        },
      ),
      *       => $attributes,
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
