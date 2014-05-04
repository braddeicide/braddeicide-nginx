#
class nginx::params {
  $listenport      = hiera('nginx::config::listenport',     '8000')
  $package_name    = hiera('nginx::install::package_name',  'nginx')
  $service_name    = hiera('nginx::service::service_name',  'nginx')
  $service_ensure  = hiera('nginx::service::service_ensure','running')
  $site_git_src    = hiera('nginx::service::site_git_src',  '')
  $site_folder_dst = hiera('nginx::service::site_folder_dst','/usr/share/nginx/exercise/')
}
