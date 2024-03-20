# @summary
#   Install stuff for CCS/SAL gateway.
#
# @param rpms
#   Hash of packages and rpms to install. Eg:
#   "ts_sal_utils" => "ts_sal_utils-4.0.0-1.x86_64.rpm"
# @param ospl_home
#   String giving OSPL_HOME.
# @param dds
#   Boolean; if true install DDS support
# @param dds_domain
#   String giving LSST_DDS_DOMAIN (eg base)
# @param dds_interface
#   String giving name of SAL interface (eg somehost-dds)
# @param instrument
#   String giving instrument (eg comcam).
# @param kafka
#   Boolean; if true install Kafka support
#   kafka will be used.
# @param kafka_broker_address
#   String giving broker address
# @param kafka_registry_url
#   String giving registry URL
# @param kafka_sasl_username
#   String giving SASL username
# @param kafka_sasl_password
#   String giving SASL password
# @param kafka_templates_directory
#   String giving location of templates directory
# @param prefix_service
#   Boolean; if false do not prefix systemctl services with the instrument.
# @param rpm_repo
#   String giving repo url for rpm download
# @param rpm_requirements
#   Array of system rpm requirements to install
# @param rpms_private
#   Optional hash of rpms to download from private repo.
# @param rpm_repo_private
#   private repo name
# @param rpm_user
#   private repo username
# @param rpm_pass
#   private repo password
#
class ccs_sal (
  Hash[String,String,1] $rpms,
  ## Change the following in hiera, not here.
  String $ospl_home = '/opt/OpenSpliceDDS/VX.Y.Z/example/example',
  Boolean $dds = true,
  String $dds_domain = 'summit',
  String $dds_interface = 'localhost-dds',
  String $instrument = 'comcam',
  Boolean $kafka = false,
  String $kafka_broker_address = 'sasquatch-tts-kafka-bootstrap.lsst.codes:9094',
  String $kafka_registry_url = 'https://tucson-teststand.lsst.codes/schema-registry',
  String $kafka_sasl_password = 'password',
  String $kafka_sasl_username = 'username',
  String $kafka_templates_directory = '/home/tonyj/avro-templates', # FIXME
  Boolean $prefix_service = true,
  ## Old: http://www.slac.stanford.edu/~gmorris/lsst/pkgarchive
  String $rpm_repo = 'https://repo-nexus.lsst.org/nexus/repository/ts_yum/releases',
  Array[String] $rpm_requirements = ['linuxptp'],
  ## If specified, rpms to fetch from _private repo using _user and _pass.
  Hash[String,String] $rpms_private = {},
  ## Defaults to _repo with yum -> yum_private.
  Optional[String] $rpm_repo_private = undef,
  ## In lsst-puppet-hiera-private.
  Optional[String] $rpm_user = undef,
  Optional[String] $rpm_pass = undef,
) {
  if $dds {
    include ccs_sal::rpms
  }
  include ccs_sal::etc
  include ccs_sal::service
}
