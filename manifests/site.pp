include apt, git, scout, nginx

# Set the default exec path
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/local/bin/", "/usr/sbin/" ] }
package { "libnss-mdns": ensure => installed } #lets you access the vm with wardenclyffe.local - test with ping wardenclyffe.local

# reload the avahi daemon for wardenclyffe.local urls
exec {"reload-avahi":
    command => "sudo service avahi-daemon restart",
    require => Package["libnss-mdns"]
}

class {'dokku':
    version => 'v0.2.2',
}

nginx::resource::upstream { 'scout_stats':
  members => [
    'localhost:5555'
  ]
}

nginx::resource::vhost { "stats.$fqdn":
  proxy => 'http://scout_stats',
}