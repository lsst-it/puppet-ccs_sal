# frozen_string_literal: true

# Managed by modulesync - DO NOT EDIT
# https://voxpupuli.org/docs/updating-files-managed-with-modulesync/

require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  # /etc/ccs is owned by lsst/ccs_software
  on host, 'mkdir -p /etc/ccs'
end

Dir['./spec/support/acceptance/**/*.rb'].sort.each { |f| require f }
