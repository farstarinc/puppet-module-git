define git::repo($ensure=present) {

  $repo_dir = "${git::server::home_dir}/${name}"
  $owner = $git::server::owner
  $group = $git::server::group

  if $ensure == present {
    file { $repo_dir:
      ensure => directory,
      owner => $owner,
      group => $group,
    }

    exec { "git::repo::init $repo_dir":
      command => "git init --bare",
      creates => "${repo_dir}/config",
      cwd => $repo_dir,
      user => $owner,
      group => $group,
    }

    Class["git::client"] -> File[$repo_dir] -> Exec["git::repo::init $repo_dir"]

  } elsif $ensure == absent {

    file { $repo_dir:
      ensure => $ensure,
      recurse => true,
      purgeforce => true,
      force => true,
    }
  }
}
