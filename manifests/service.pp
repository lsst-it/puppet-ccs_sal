# @summary
#   Manage systemd service files for CCS/SAL
#
class ccs_sal::service {
  $common_vars = {
    user    => 'ccs',
    group   => 'ccs',
    workdir => '/home/ccs',
  }

  $instrument = $ccs_sal::instrument
  $prefix_service = $ccs_sal::prefix_service

  if $prefix_service {
    $prefix = "${instrument}-"
  } else {
    $prefix = ''
  }

  ## 202107: Name changed from ocs-bridge-${instrument}
  $ocs_bridge = {
    service  => "${prefix}ocs-bridge",
    vars     => {
      desc  => 'CCS OCS bridge service',
      env   => ['LSST_DDS_HISTORYSYNC=0'],
      start => "/opt/lsst/ccs/prod/bin/${prefix}ocs-bridge",
    },
  }

  ## 202107: Name changed from mcm-${instrument}
  $mcm = {
    service  => "${prefix}mcm",
    vars     => {
      desc    => 'CCS MCM service',
      start   => "/opt/lsst/ccs/prod/bin/${prefix}mcm",
    },
  }

  ## FIXME ccs_software module can also manage basic services.
  $services = [$ocs_bridge, $mcm]

  $services.each | $hash | {
    $service  = $hash['service']
    $epp_vars = $common_vars + $hash['vars']
    systemd::unit_file { "${service}.service":
      content => epp("${module_name}/service.epp", $epp_vars),
    }
    -> service { $service:
      enable => true,
    }

    $epp_sudo_vars = {
      service => $service,
      user    => $common_vars['user'],
    }

    sudo::conf { "ccs-service-${service}":
      content => epp("${module_name}/sudo.epp", $epp_sudo_vars),
    }
  }
}
