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
}

define git::authorized_key($key, $type="ssh-rsa") {

  ssh_authorized_key { "git@${name}":
    ensure  => present,
    key => $key,
    user  => $git::server::username,
    type  => $type,
  }
}
