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
    package { "build-essential": ensure => installed }


    vcsrepo { "/usr/src/dokku":
        ensure => present,
        provider => git,
        revision => $version,
        source => "https://github.com/progrium/dokku.git"
    }

    exec { "dokku-install":
        cwd => '/usr/src/dokku',
        command =>  "make install",
        timeout => "900", #it might take up to 15 minutes to install the whole shebang
        logoutput => "true",
        # refreshonly => "true", this is not really that useful
        require => [Vcsrepo["/usr/src/dokku"], Package['wget'], Package['build-essential'], Package['software-properties-common'], Package['python-software-properties']]
    }
}
