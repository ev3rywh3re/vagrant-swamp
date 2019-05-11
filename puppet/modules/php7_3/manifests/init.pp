class php7_3::install {

  exec { "install_php":
    path => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo apt install -y php",
    user => "root"
  }

  exec { "install_php_mods":
    path => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo apt install -y php-cli php-common php-curl php-mbstring php-mysql php-xml php-gd",
    user => "root"
  }

  exec { "install_php73":
    path => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo apt install php7.3",
    user => "root"
  }

  exec { "install_php7_mods":
    path => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    command => "sudo apt install php7.3-cli php7.3-common php7.3-curl php7.3-mbstring php7.3-mysql php7.3-xml",
    user => "root"
  }

  # Custom
  file { '/etc/php/7.0/apache2/php.ini':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/vagrant/files/etc/php7_3/php.ini',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

}
