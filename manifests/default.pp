class quickbuild {
  # Added this clean because I was seeing odd apt-get errors
  exec { 'apt-get clean':
    command => '/usr/bin/apt-get clean',
  }

  # Update all currently installed packages
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
    require => Exec['apt-get clean']
  }

  # Quickbuild needs Java6
  package { "openjdk-6-jdk":
    ensure => present,
    require => Exec['apt-get update']
  }
  
  # create the installation directory      
  file { "/opt/quickbuild":
    ensure => "directory",
  }
	
  # create the quickbuild user
  user { 'quickbuild':
    uid         => '1337',
    managehome  => true,
  }

  # Need that vim!
  package { "vim":
    ensure => present,
  }

  # mysql-server
  package { "mysql-server":
    ensure => present,
    require => Exec['apt-get update']
  }

  # mysql-client
  package { "mysql-client":
    ensure => present,
    require => Exec['apt-get update']
  }
}

include quickbuild
