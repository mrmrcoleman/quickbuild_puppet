# Basic Puppet Apache manifest

class apache {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

  file { '/var/www':
    ensure => link,
    target => "/vagrant",
    notify => Service['apache2'],
    force  => true
  }
}

class jdk_6 {
  package { "openjdk-6-jdk":
    ensure => present,
  }
}

class quickbuild {
	# create the installation directory      
	file { "/opt/quickbuild":
    ensure => "directory",
	}
	
	# create the quickbuild user
	user { 'quickbuild':
		uid         => '1337',
		managehome  => true,
	}
}

class vim {
  package { "vim":
    ensure => present,
  }
}

include vim
include apache
include jdk_6
include quickbuild