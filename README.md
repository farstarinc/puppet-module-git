Puppet Git Module
=================

Module for configuring Git.

Tested on Debian GNU/Linux 6.0 Squeeze and Ubuntu 10.4 LTS with
Puppet 2.6. Patches for other operating systems are welcome.


TODO
----

* Schedule `git-gc --auto --quiet` runs.


Installation
------------

Clone this repo to a git directory under your Puppet modules directory:

    git clone git://github.com/uggedal/puppet-module-git.git git

If you don't have a Puppet Master you can create a manifest file
based on the notes below and run Puppet in stand-alone mode
providing the module directory you cloned this repo to:

    puppet apply --modulepath=modules test_git.pp


Usage
-----

The `git::client` class installs the git client:

    import git::client

The `git::server` class creates a git user which can be used for
hosting git repositories over ssh:

    import git::server

You can specify which ssh keys should have access to the git repositories
stored under the git user's home directory by using the `git:authorized_key`
resource:

    git::authorized_key  { "bob":
      key => "a8a7dgf7ad8j13g",
    }

    git::authorized_key  { "joe":
      key  => "a8a7dgf7ad8j13g",
      type => "ssh-dsa",
    }

You can use `git::repo` to create bare repositories under the git user's
home directory which can be pushed to over ssh:

    git::repo { "blog": }
