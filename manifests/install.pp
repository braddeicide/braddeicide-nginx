#
class nginx::install inherits nginx {
  package { $nginx::package_name: }
}
