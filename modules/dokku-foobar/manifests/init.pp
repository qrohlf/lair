# Dokku Puppet Module
# 
# Installs and updates Dokku
#
# to install the latest verion of Dokku, just install the module
# and include dokku in your site.pp file
#
# to manually specify a version of Dokku, use the version 
# parameter, like so:
# 
# class {'dokku': 
#   version => 'v0.2.2'
# }
#
# Copyright 2014 Quinn Rohlf
#

class dokku ($version = "v0.2.2") {
    package { 'software-properties-common': ensure => installed }
    package { "python-software-properties": ensure => installed }
    package { "wget": ensure => installed }


    vcsrepo { "/usr/src/dokku":
        ensure => present,
        provider => git,
        revision => $version,
        source => "https://github.com/progrium/dokku.git",
    }

    exec { "dokku-install":
        cwd => '/usr/src/dokku',
        command =>  "make install",
        logoutput => "true",
        require => Vcsrepo["/usr/src/dokku"],
        unless => "grep '^$version\$' /home/dokku/VERSION"
    }
}
