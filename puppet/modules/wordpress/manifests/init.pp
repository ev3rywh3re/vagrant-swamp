# Install latest Wordpress

class wordpress::install {

  # Create the Wordpress database

  exec { 'create-database-wordpress':
    unless  => '/usr/bin/mysql -u root -pvagrant wordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute="CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"',
  }

  exec { 'create-user-wordpress':
    unless  => '/usr/bin/mysql -u wordpress -pwordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute="GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost IDENTIFIED BY \'wordpress\'"',
  }

  exec { 'create-database-wordpressmulti':
    unless  => '/usr/bin/mysql -u root -pvagrant wordpress_multi',
    command => '/usr/bin/mysql -u root -pvagrant --execute="CREATE DATABASE wordpress_multi DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"',
  }

  exec { 'create-user-wordpressmulti':
    unless  => '/usr/bin/mysql -u wordpress -pwordpress --database wordpress_multi',
    command => '/usr/bin/mysql -u root -pvagrant --execute="GRANT ALL PRIVILEGES ON wordpress_multi.* TO wordpress@localhost IDENTIFIED BY \'wordpress\'"',
  }

  # Get a new copy of the latest wordpress release
  # FILE TO DOWNLOAD: http://wordpress.org/latest.tar.gz

  exec { 'download-wordpress': #tee hee
    command => '/usr/bin/wget http://wordpress.org/latest.tar.gz -O /vagrant/latest.tar.gz',
    cwd     => '/vagrant/',
    creates => '/vagrant/latest.tar.gz'
  }

  exec { 'untar-wordpress':
    command => '/bin/tar -xzvf /vagrant/latest.tar.gz',
    cwd     => '/vagrant/',
    require => Exec['download-wordpress'],
    creates => '/vagrant/wordpress'
  }

  exec { "copy-wordpress":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => "/bin/cp -Rf /vagrant/wordpress/* /vagrant/sites/www/",
    require => Exec['untar-wordpress'],
    returns => [0,1]
  }

  exec { "owner-wordpress":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => "/bin/chown -Rf vagrant.vagrant /sites/www/*",
    require => Exec['copy-wordpress'],
    returns => [0,1]
  }

  exec { "permissions-wordpress":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => "/bin/chmod -Rf ug+rw /sites/www/*",
    require => Exec['copy-wordpress'],
    returns => [0,1]
  }

  exec { "copy-wordpress-multi":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => "/bin/cp -Rf /vagrant/wordpress/* /vagrant/sites/dev/",
    require => Exec['untar-wordpress'],
    returns => [0,1]
  }

  exec { "owner-wordpress-multi":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => "/bin/chown -Rf vagrant.vagrant /sites/dev/*",
    require => Exec['copy-wordpress-multi'],
    returns => [0,1]
  }

  exec { "permissions-wordpress-multi":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => "/bin/chmod -Rf ug+rw /sites/dev/*",
    require => Exec['copy-wordpress-multi'],
    returns => [0,1]
  }


}
