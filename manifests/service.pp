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

  $ocs_bridge = {
    service  => "ocs-bridge-${instrument}",
    template => 'ocs-bridge',
    vars     => {
      desc  => "CCS OCS bridge for ${instrument}",
      env   => 'LSST_DDS_HISTORYSYNC=0',
      start => "/opt/lsst/ccs/prod/bin/ocs-bridge-${instrument}",
    }
  }

  $mcm = {
    service  => "mcm-${instrument}",
    template => 'mcm',
    vars     => {
      desc    => "CCS MCM for ${instrument}",
      start   => "/opt/lsst/ccs/prod/bin/mcm-${instrument}",
    }
  }

  $services = [$opensplice, $ocs_bridge, $mcm]

  $services.each | $hash | {
    $service  = $hash['service']
    $template = $hash['template']
    $epp_vars = $common_vars + $hash['vars']
    systemd::unit_file { "${service}.service":
      content => epp("${module_name}/service.epp", $epp_vars),
    }
    -> service { $service:
      enable => true,
    }
  }

}
