class ccs_sal::rpms {
  ## Needed by ts_sal_utils.
  ensure_packages(['linuxptp'])

  ## Public rpms.
  $repo = $ccs_sal::rpm_repo

  $rpm_opts = {
    ensure       => 'latest',
    provider     => 'rpm',
    ## Following allows us to have multiple versions installed.
    ## Must include the version+release in the package name.
    ## Eg instead of "OpenSpliceDDS", use "OpenSpliceDDS-6.11.0-16.el7".
    install_only => true,
  }

  $ccs_sal::rpms.each |$package, $rpm| {
    $file = "/var/tmp/${rpm}"

    archive { $file:
      ensure => present,
      source => "${repo}/${rpm}",
    }
    package { $package:
      source => $file,
      *      => $rpm_opts,
    }
  }

  ## Private rpms.
  $repo_private0 = $ccs_sal::rpm_repo_private
  if $repo_private0 !~ Undef {
    $repo_private = $repo_private0
  } else {
    $repo_private = regsubst($repo, 'yum', 'yum_private')
  }

  $user = $ccs_sal::rpm_user
  $pass = $ccs_sal::rpm_pass

  $ccs_sal::rpms_private.each |$package, $rpm| {
    $file = "/var/tmp/${rpm}"

    archive { $file:
      ensure   => present,
      source   => "${repo_private}/${rpm}",
      username => $user,
      password => $pass,
    }

    package { $package:
      source => $file,
      *      => $rpm_opts,
    }
  }
}
