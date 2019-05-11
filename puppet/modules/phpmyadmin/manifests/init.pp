# Install latest phpMyAdmin

class phpmyadmin::install {

  # Get a new copy of the latest phpMyAdmin release
  # !!Issue!! - currently not direct stable download URL

  exec { 'download-phpmyadmin': #tee hee
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => 'sudo wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 4 https://files.phpmyadmin.net/phpMyAdmin/4.8.3/phpMyAdmin-4.8.3-all-languages.zip -O /vagrant/phpmyadmin.zip',
    cwd     => '/vagrant/',
    creates => '/vagrant/phpmyadmin.zip'
  }

  exec { 'unzip-phpmyadmin':
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => 'unzip /vagrant/phpmyadmin.zip -d /vagrant/phpmyadmin',
    require => Exec['download-phpmyadmin'],
    creates => '/vagrant/phpmyadmin'
  }

  exec { "move-phpmyadmin":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => "cp -Rf /vagrant/phpmyadmin/* /vagrant/sites/db/",
    require => Exec['unzip-phpmyadmin'],
    returns => [0,1]
  }

  exec { "owner-phpmyadmin":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => "/bin/chown -Rf vagrant.vagrant /sites/db/*",
    require => Exec['move-phpmyadmin'],
    returns => [0,1]
  }

  exec { "permissions-phpmyadmin":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => '/vagrant/',
    command => "/bin/chmod -Rf ug+rw /sites/db/*",
    require => Exec['move-phpmyadmin'],
    returns => [0,1]
  }

}
