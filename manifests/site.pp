include apt, git, scout, wardenclyffe_default

# Set the default exec path
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/local/bin/", "/usr/sbin/" ] }
package { "libnss-mdns": ensure => installed } #lets you access the vm with wardenclyffe.local - test with ping wardenclyffe.local

# reload the avahi daemon for wardenclyffe.local urls
exec {"reload-avahi":
    command => "sudo service avahi-daemon restart",
    require => Package["libnss-mdns"]
}

# install dokku
class {'dokku':
    version => 'master',
}

package { "nginx":
    ensure => installed,
}

service { "nginx":
    ensure => running,
    provider => 'init',
    require => Package['nginx']
}