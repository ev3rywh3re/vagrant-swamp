#Install MySQL

class mysql::install {

  $password = 'vagrant'

  package { [
      'mysql-client',
      'mysql-server',
    ]:
    ensure => installed,
  }

  # Custom mysql.cnf
  file { '/etc/mysql/conf.d/mysql.cnf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/vagrant/files/etc/mysqld/mysql.cnf',
    require => Package['mysql-server'],
  }

  exec { "mysqld-start-first":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo service mysql start",
    returns => [0,1]
  }

  exec { 'Set MySQL server\'s root password':
    subscribe   => [
      Package['mysql-server'],
      Package['mysql-client'],
    ],
    path  => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    refreshonly => true,
    unless      => "sudo mysqladmin -uroot -p${password} status",
    command     => "sudo mysqladmin -uroot password ${password}",
  }

  exec { "mysqld-stop":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo service mysql stop",
    returns => [0,1]
  }

  exec { "mysqld-start":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo service mysql start",
    require => Exec['mysqld-stop'],
    returns => [0,1]
  }

}
