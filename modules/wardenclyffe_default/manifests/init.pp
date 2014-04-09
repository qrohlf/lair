# == Class: default
#
# Full description of class default here.
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
#  class { default:
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
class wardenclyffe_default {

    # setup the default page
    file {'/usr/share/nginx/wardenclyffe_default': 
        ensure => 'directory',
        source => 'puppet:///modules/wardenclyffe_default/html',
        recurse => 'true',
        require => Package['nginx']
    }

    file {'/etc/nginx/sites-available/wardenclyffe_default.conf':
        source => 'puppet:///modules/wardenclyffe_default/wardenclyffe_default.conf',
        require => File['/usr/share/nginx/wardenclyffe_default'],
    }

    file {'/etc/nginx/sites-enabled/wardenclyffe_default.conf':
        ensure => 'link',
        target => '/etc/nginx/sites-available/wardenclyffe_default.conf',
    }

    file {'/etc/nginx/sites-enabled/default':
        ensure => 'absent'
    }

    exec {"reload-nginx":
        command => 'nginx -s reload',
        require => [File['/etc/nginx/sites-enabled/wardenclyffe_default.conf'], 
            File['/usr/share/nginx/wardenclyffe_default'],
            Service['nginx']]
    }
}
