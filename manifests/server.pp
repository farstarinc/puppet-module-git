class git::server($authorized_keys=[], $username="git", $guid=2010) {

  $home_dir = "/home/${username}"

  group { $username:
    ensure => present,
    allowdupe => false,
    gid => $guid,
  }

  user { $username:
    ensure => present,
    allowdupe => false,
    home => $home_dir,
    managehome => true,
    uid => $guid,
    gid => $guid,
    password => "!",
    shell => "/usr/bin/git-shell",
  }

  file { $home_dir:
    ensure => directory,
    owner => $username,
    group => $username,
  }

  git::ssh_authorized_key { $authorized_keys:
    username => $username,
  }
}

define git::ssh_authorized_key($username) {

  $type = "ssh-rsa"
  if "type" in $name {
    $type = $name[type]
  }

  ssh_authorized_key { $name:
    ensure  => present,
    key => $name[key],
    target  => "${git::server::home_dir}/.ssh/authorized_keys",
    user  => $username,
    type  => $type,
  }
}
