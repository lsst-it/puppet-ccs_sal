## @summary
##   Install stuff for CCS/SAL gateway.
##
## @param rpms
##   Hash of packages and rpms to install. Eg:
##   "ts_sal_utils" => "ts_sal_utils-4.0.0-1.x86_64.rpm"
## @param ospl_home
##   String giving OSPL_HOME.
## @param dds_domain
##   String giving LSST_DDS_DOMAIN (eg base)
## @param dds_interface
##   String giving name of SAL interface (eg somehost-dds)
## @param instrument
##   String giving instrument (eg comcam).
## @param rpm_repo, rpm_user, rpm_pass
##   Strings giving repo url, username and password for rpm download.

class ccs_sal (
  Hash[String,String,2] $rpms,
  String $ospl_home = '/opt/OpenSpliceDDS/V6.10.4/HDE/x86_64.linux',
  String $dds_domain = 'summit',
  String $dds_interface = 'localhost-dds',
  String $instrument = 'comcam',
  ## Old: http://www.slac.stanford.edu/~gmorris/lsst/pkgarchive
  String $rpm_repo = 'https://repo-nexus.lsst.org/nexus/repository/ts_yum_private/releases',
  ## In lsst-puppet-hiera-private.
  Optional[String] $rpm_user = undef,
  Optional[String] $rpm_pass = undef,
) {

  include ccs_sal::rpms
  include ccs_sal::etc
  include ccs_sal::service

}
