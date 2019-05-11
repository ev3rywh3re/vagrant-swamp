class php7::install {

  exec { "install_php":
    path => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo apt-get install -y php",
    user => "root"
  }

  exec { "install_php_mods":
    path => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo apt-get install -y php-cli php-common php-curl php-mbstring php-mysql php-xml php-gd",
    user => "root"
  }

  exec { "install_php7":
    path => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo apt-get install -y php7.0",
    user => "root"
  }

  exec { "install_php7_mods":
    path => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo apt-get install -y php7.0-mysql php7.0-curl php7.0-gd php7.0-fpm php7.0-dev php7.0-xdebug php7.0-mbstring libapache2-mod-php7.0",
    user => "root",
    notify => Service['apache2']
  }

  # Custom
  file { '/etc/php/7.0/apache2/php.ini':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/vagrant/files/etc/php7/php.ini',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

}
