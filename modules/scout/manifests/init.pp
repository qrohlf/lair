# == Class: scout
#
# Full description of class scout here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { scout:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class scout {
    apt::ppa { 'ppa:brightbox/ruby-ng': }

    class { 'ruby':
      ruby_package     => 'ruby2.1',
      require => Apt::Ppa['ppa:brightbox/ruby-ng'],
      notify => Exec['apply-ruby'],
      gems_version => 'latest'
    }

    # package {'rubygems':
    #     ensure  => 'latest'
    # }

    exec {"apply-ruby":
        command => "update-alternatives --set ruby /usr/bin/ruby2.1",
        refreshonly => true
    }

    exec { 'install-scout':
        command => 'gem install --no-rdoc --no-ri scout_realtime && gem update scout_realtime',
        require => Exec['apply-ruby']
    }

    file { '/etc/init/scout.conf':
          ensure => present,
          source => "puppet:///modules/scout/scout-upstart.conf",
    }

    service {'scout':
        ensure => running,
        provider => upstart,
        require => [File['/etc/init/scout.conf'], Exec['install-scout']]
    }
}
