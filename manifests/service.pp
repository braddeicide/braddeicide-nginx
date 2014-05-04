#
class nginx::service inherits nginx {
  service {$nginx::service_name:
    ensure => $nginx::service_ensure,
  }
}
