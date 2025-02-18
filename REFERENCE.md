# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`ccs_sal`](#ccs_sal): Install stuff for CCS/SAL gateway.
* [`ccs_sal::etc`](#ccs_sal--etc): Configure /etc for CCS/SAL
* [`ccs_sal::rpms`](#ccs_sal--rpms): Install rpms needed by CCS/SAL
* [`ccs_sal::service`](#ccs_sal--service): Manage systemd service files for CCS/SAL

## Classes

### <a name="ccs_sal"></a>`ccs_sal`

Install stuff for CCS/SAL gateway.

#### Parameters

The following parameters are available in the `ccs_sal` class:

* [`rpms`](#-ccs_sal--rpms)
* [`ospl_home`](#-ccs_sal--ospl_home)
* [`dds`](#-ccs_sal--dds)
* [`dds_domain`](#-ccs_sal--dds_domain)
* [`dds_interface`](#-ccs_sal--dds_interface)
* [`dds_extra`](#-ccs_sal--dds_extra)
* [`instrument`](#-ccs_sal--instrument)
* [`java_home`](#-ccs_sal--java_home)
* [`kafka`](#-ccs_sal--kafka)
* [`kafka_broker_address`](#-ccs_sal--kafka_broker_address)
* [`kafka_registry_url`](#-ccs_sal--kafka_registry_url)
* [`kafka_sasl_username`](#-ccs_sal--kafka_sasl_username)
* [`kafka_sasl_password`](#-ccs_sal--kafka_sasl_password)
* [`lfa`](#-ccs_sal--lfa)
* [`prefix_service`](#-ccs_sal--prefix_service)
* [`rpm_repo`](#-ccs_sal--rpm_repo)
* [`rpm_requirements`](#-ccs_sal--rpm_requirements)
* [`rpms_private`](#-ccs_sal--rpms_private)
* [`rpm_repo_private`](#-ccs_sal--rpm_repo_private)
* [`rpm_user`](#-ccs_sal--rpm_user)
* [`rpm_pass`](#-ccs_sal--rpm_pass)

##### <a name="-ccs_sal--rpms"></a>`rpms`

Data type: `Hash[String,String,1]`

Hash of packages and rpms to install. Eg:
"ts_sal_utils" => "ts_sal_utils-4.0.0-1.x86_64.rpm"

##### <a name="-ccs_sal--ospl_home"></a>`ospl_home`

Data type: `String`

String giving OSPL_HOME.

Default value: `'/opt/OpenSpliceDDS/VX.Y.Z/example/example'`

##### <a name="-ccs_sal--dds"></a>`dds`

Data type: `Boolean`

Boolean; if true install DDS support

Default value: `true`

##### <a name="-ccs_sal--dds_domain"></a>`dds_domain`

Data type: `String`

String giving LSST_DDS_DOMAIN (eg base)

Default value: `'summit'`

##### <a name="-ccs_sal--dds_interface"></a>`dds_interface`

Data type: `String`

String giving name of SAL interface (eg somehost-dds)

Default value: `'localhost-dds'`

##### <a name="-ccs_sal--dds_extra"></a>`dds_extra`

Data type: `String`

String giving extra content for DDS setup file.

Default value: `'export LD_PRELOAD=${JAVA_HOME}/jre/lib/amd64/libjsig.so'`

##### <a name="-ccs_sal--instrument"></a>`instrument`

Data type: `String`

String giving instrument (eg comcam).

Default value: `'comcam'`

##### <a name="-ccs_sal--java_home"></a>`java_home`

Data type: `String`

String giving JAVA_HOME (only used by DDS).

Default value: `'/usr/java/default'`

##### <a name="-ccs_sal--kafka"></a>`kafka`

Data type: `Boolean`

Boolean; if true install Kafka support
kafka will be used.

Default value: `false`

##### <a name="-ccs_sal--kafka_broker_address"></a>`kafka_broker_address`

Data type: `String`

String giving broker address

Default value: `'sasquatch-tts-kafka-bootstrap.lsst.codes:9094'`

##### <a name="-ccs_sal--kafka_registry_url"></a>`kafka_registry_url`

Data type: `String`

String giving registry URL

Default value: `'https://tucson-teststand.lsst.codes/schema-registry'`

##### <a name="-ccs_sal--kafka_sasl_username"></a>`kafka_sasl_username`

Data type: `String`

String giving SASL username

Default value: `'username'`

##### <a name="-ccs_sal--kafka_sasl_password"></a>`kafka_sasl_password`

Data type: `String`

String giving SASL password

Default value: `'password'`

##### <a name="-ccs_sal--lfa"></a>`lfa`

Data type: `Hash`

Hash of properties (id, secret, endpoint, bucket) for large file
annex (lfa) configuration.

Default value: `{}`

##### <a name="-ccs_sal--prefix_service"></a>`prefix_service`

Data type: `Boolean`

Boolean; if false do not prefix systemctl services with the instrument.
Also applies to the .app files in /etc/ccs.

Default value: `true`

##### <a name="-ccs_sal--rpm_repo"></a>`rpm_repo`

Data type: `String`

String giving repo url for rpm download

Default value: `'https://repo-nexus.lsst.org/nexus/repository/ts_yum/releases'`

##### <a name="-ccs_sal--rpm_requirements"></a>`rpm_requirements`

Data type: `Array[String]`

Array of system rpm requirements to install

Default value: `['linuxptp']`

##### <a name="-ccs_sal--rpms_private"></a>`rpms_private`

Data type: `Hash[String,String]`

Optional hash of rpms to download from private repo.

Default value: `{}`

##### <a name="-ccs_sal--rpm_repo_private"></a>`rpm_repo_private`

Data type: `Optional[String]`

private repo name

Default value: `undef`

##### <a name="-ccs_sal--rpm_user"></a>`rpm_user`

Data type: `Optional[Variant[Sensitive[String[1]],String[1]]]`

private repo username

Default value: `undef`

##### <a name="-ccs_sal--rpm_pass"></a>`rpm_pass`

Data type: `Optional[Variant[Sensitive[String[1]],String[1]]]`

private repo password

Default value: `undef`

### <a name="ccs_sal--etc"></a>`ccs_sal::etc`

Configure /etc for CCS/SAL

### <a name="ccs_sal--rpms"></a>`ccs_sal::rpms`

Install rpms needed by CCS/SAL

### <a name="ccs_sal--service"></a>`ccs_sal::service`

Manage systemd service files for CCS/SAL

