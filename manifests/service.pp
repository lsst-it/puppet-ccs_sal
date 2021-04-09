class ccs_sal::service {

  $common_vars = {
    user    => 'ccs',
    group   => 'ccs',
    workdir => '/home/ccs',
  }

  $instrument = $ccs_sal::instrument

  $sal_file = '/etc/ccs/setup-sal5'

  $opensplice = {
    service  => 'opensplice',
    template => 'opensplice',
    vars     => {
      desc  => 'OpenSpliceDDS daemons',
      env   => 'LSST_DDS_RESPONSIVENESS_TIMEOUT=15s',
      start => "/bin/bash -c 'source ${sal_file} && \$OSPL_HOME/bin/ospl -f start'",
      stop  => "/bin/bash -c 'source ${sal_file} && \$OSPL_HOME/bin/ospl stop'",
    }
  }


  $ocs_vars = {
    desc  => "CCS OCS bridge for ${instrument}",
    env   => 'LSST_DDS_HISTORYSYNC=0',
    start => "/opt/lsst/ccs/prod/bin/ocs-bridge-${instrument}",
  }

  $ocs_bridge = {
    service  => "ocs-bridge-${instrument}",
    template => 'ocs-bridge',
    vars     => $ocs_vars,
  }

  $ocs_bridge_dev = $ocs_bridge + {
    service => "${ocs_bridge['service']}-dev",
    vars    => $ocs_vars + {
      desc      => "${ocs_vars['desc']} (dev version)",
      start     => regsubst( $ocs_vars['start'], '\/prod\/', '/dev/'),
      conflicts => "${ocs_bridge['service']}.service",
    }
  }


  $mcm_vars = {
    desc  => "CCS MCM for ${instrument}",
    env   => '',
    start => "/opt/lsst/ccs/prod/bin/mcm-${instrument}",
  }

  $mcm = {
    service  => "mcm-${instrument}",
    template => 'mcm',
    vars     => $mcm_vars
  }

  $mcm_dev = $mcm + {
    service => "${mcm['service']}-dev",
    vars    => $mcm_vars + {
      desc      => "${mcm_vars['desc']} (dev version)",
      start     => regsubst( $mcm_vars['start'], '\/prod\/', '/dev/'),
      conflicts => "${mcm['service']}.service",
    }
  }


  $services = [$opensplice, $ocs_bridge, $mcm, $ocs_bridge_dev, $mcm_dev]

  $services.each | $hash | {
    $service  = $hash['service']
    $template = $hash['template']
    $epp_vars = $common_vars + $hash['vars']
    systemd::unit_file { "${service}.service":
      content => epp("${module_name}/${template}.service.epp", $epp_vars),
    }
    -> service { $service:
      enable => $service !~ /-dev$/,
    }
  }

}
