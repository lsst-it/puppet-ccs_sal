class ccs_sal::rpms {

  ## Needed by ts_sal_utils.
  ensure_packages(['linuxptp'])

  $repo = $ccs_sal::rpm_repo
  $user = $ccs_sal::rpm_user
  $pass = $ccs_sal::rpm_pass

  $ccs_sal::rpms.each |$package, $rpm| {

    $file = "/var/tmp/${rpm}"

    archive { $file:
      ensure => present,
      source => "${repo}/${rpm}",
    }
    if $user !~ Undef {
      Archive[$file] {
        username => $user,
      }
    }
    if $pass !~ Undef {
      Archive[$file] {
        password => $pass,
      }
    }

    package { $package:
      ensure       => 'latest',
      provider     => 'rpm',
      source       => $file,
      ## Following allows us to have multiple versions installed.
      ## Must include the version+release in the package name.
      ## Eg instead of "OpenSpliceDDS", use "OpenSpliceDDS-6.11.0-16.el7".
      install_only => true,
    }
  }

}
