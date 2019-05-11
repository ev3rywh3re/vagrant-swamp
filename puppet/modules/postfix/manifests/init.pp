#Install Postfix

class postfix {
  package { 'postfix':
    ensure  => installed,
    before  => Exec['postfix'],
  }

  exec { 'postfix':
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command     => 'echo "postfix packages are installed"',
    logoutput   => true,
    refreshonly => true,
  }

  service { 'postfix':
    ensure  => 'running',
    require => Exec['postfix']
  }
}
