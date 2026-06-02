# @summary
#   Install stuff for CCS/SAL gateway.
#
# @param instrument
#   String giving instrument (eg comcam).
# @param kafka_broker_address
#   String giving broker address
# @param kafka_registry_url
#   String giving registry URL
# @param kafka_sasl_username
#   String giving SASL username
# @param kafka_sasl_password
#   String giving SASL password
# @param lfa
#   Hash of properties (id, secret, endpoint, bucket) for large file
#   annex (lfa) configuration.
# @param prefix_service
#   Boolean; if false do not prefix systemctl services with the instrument.
#   Also applies to the .app files in /etc/ccs.
#
class ccs_sal (
  String $instrument = 'comcam',
  String $kafka_broker_address = 'sasquatch-tts-kafka-bootstrap.lsst.codes:9094',
  String $kafka_registry_url = 'https://tucson-teststand.lsst.codes/schema-registry',
  String $kafka_sasl_password = 'password',
  String $kafka_sasl_username = 'username',
  Hash $lfa = {},
  Boolean $prefix_service = true,
) {
  include ccs_sal::etc
  include ccs_sal::service
}
