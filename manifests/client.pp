class git::client {
  package { "git-core":
    ensure => present,
  }
}
