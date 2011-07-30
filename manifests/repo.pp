define git::repo($ensure=present) {

  $repo_dir = "${git::server::home_dir}/${name}"

  if $ensure == present {

    exec { "git::create_repo $repo_dir":
      command => "mkdir $repo_dir && cd $repo_dir && git init --bare",
      creates => $repo_dir,
    }

  } elsif $ensure == absent {

    file { $repo_dir:
      ensure => $ensure,
      recurse => true,
      purgeforce => true,
      force => true,
    }
  }
}
