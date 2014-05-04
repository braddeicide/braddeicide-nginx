#
class nginx::config inherits nginx {

  file {$site_folder_dst:
    ensure => directory,
  }

  # Generally i'd prefer to import a well written git puppet module, however as this
  # is a demonstation module, I'll keep it self contained.
  package {'git': }

  exec {'git checkout':
    path    => '/usr/bin/',
    command => "git clone $site_git_src $site_folder_dst",
    require => [Package['git'],File['/usr/share/nginx/exercise']],
    notify  => File['cleangit'],
    creates => "${site_folder_dst}index.html"
  }

  # Could be replaced with a find exec if there are more .git folders.
  file {'cleangit':
    ensure  => absent,
    path    => "${site_folder_dst}.git",
    force   => true,
  }

  file {'/etc/nginx/conf.d/exercise_webpage':
    content => template('nginx/exercise.erb')
  }

  file {'/etc/nginx/sites-enabled/exercise_webpage':
    ensure  => link,
    target  => '/etc/nginx/conf.d/exercise_webpage',
    require => File['/etc/nginx/conf.d/exercise_webpage']
  }
}
