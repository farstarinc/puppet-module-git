define git::clone($dir=undef,
                  $dir_parent=undef,
                  $ensure=present,
                  $owner="root",
                  $group="root",
                  $target_name=undef) {

    if !$dir and !$dir_parent {
      fail("You must specify either dir or dir_parent")
    }

    $repo_url = $name
    $repo_name = regsubst($repo_url, '^.*?([^:/]+).git$', '\1')

    $target_dir = $dir ? {
      undef => "${dir_parent}/${repo_name}",
      default => $dir
    }

    if $ensure == present {
      exec { "git::clone ${repo_url} as ${owner}":
        user => $owner,
        group => $group,
        command => "git clone ${repo_url} ${target_dir}",
        unless => "[ \"$(ls -A ${target_dir}/)\" ]",
        logoutput => true,
        require => Package["git-core"],
      }
    }
}
