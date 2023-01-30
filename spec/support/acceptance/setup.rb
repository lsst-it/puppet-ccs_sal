# frozen_string_literal: true

configure_beaker do |host|
  # /etc/ccs is owned by lsst/ccs_software
  on host, 'mkdir -p /etc/ccs'
end
