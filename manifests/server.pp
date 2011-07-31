class git::server($authorized_keys=[],
                  $owner="git",
                  $group="git",
                  $guid=2010) {

  $home_dir = "/home/${owner}"

  group { $group:
    ensure => present,
    allowdupe => false,
    gid => $guid,
  }

  user { $owner:
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
    owner => $owner,
    group => $group,
  }
}

define git::authorized_key($key, $type="ssh-rsa") {

  ssh_authorized_key { "git@${name}":
    ensure  => present,
    key => $key,
    user  => $git::server::owner,
    type  => $type,
  }
}
