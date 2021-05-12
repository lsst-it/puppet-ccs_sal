class ccs_sal::rpms {

  ## Needed by ts_sal_utils.
  ensure_packages(['linuxptp'])

  $ccs_pkgarchive = lookup('ccs_pkgarchive', String)

  $ccs_sal::rpms.each |$package, $rpm| {

    $file = "/var/tmp/${rpm}"

    archive { $file:
      ensure => present,
      source => "${ccs_pkgarchive}/${rpm}",
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
