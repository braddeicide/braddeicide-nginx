# == Class: nginx
#
# Simple nginx module that provides minimal configuration and deploys a fixed
# site.
#
# === Parameters
#
# Required:
# [site_git_src]
#   Defines git src for website.
#
# Optional:
# [listenport]
#   Defines which TCP port nginx will listen on for requests.
# [package_name]
#   Defines name of nginx package, defaults to nginx.
# [service_name]
#   Defines name of nginx service, defaults to nginx.
# [service_ensure]
#   Defines wether we ensure running/stopped.
# [site_folder_dst]
#   Defines where on the filesystem site will be checked out.
#
# === Examples
#
#  # all defaults
#  class { nginx: }
#
#  # With customisation
#  class {"nginx":
#    listenport      => 8000,
#    package_name    => "nginx",
#    service_name    => "nginx",
#    service_ensure  => "running",
#    site_git_src    => "https://github.com/puppetlabs/exercise-webpage.git",
#    site_folder_dst => "/usr/share/nginx/exercise/",
#
# === Authors
#
# Bradley Jenkins <braddeicide@hotmail.com>
#
# === Copyright
#
# Copyright 2014 Bradley Jenkins, unless otherwise noted.
#
class nginx (
    $listenport      = $nginx::params::listenport,
    $package_name    = $nginx::params::package_name,
    $service_name    = $nginx::params::service_name,
    $service_ensure  = $nginx::params::service_ensure,
    $site_git_src    = $nginx::params::site_git_src,
    $site_folder_dst = $nginx::params::site_folder_dst,
  ) inherits params {

  validate_re($listenport, ['^\d+$', ''],'$listenport should be a number, or empty')
  validate_string($package_name)

  # for ordering, compatibility < 3.4
  anchor { 'nginx::begin': } ->
  class  { '::nginx::install': } ->
  class  { '::nginx::config': } ~>
  class  { '::nginx::service': } ->
  anchor { 'nginx::end': }
}
