# Cleanup and remove downloads and temp directories

class cleanup::install {

  exec { "cleanup-remove-wordpress":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => "/vagrant/",
    command => "sudo rm -Rf /vagrant/latest.tar.gz /vagrant/wordpress"
  }

  exec { "cleanup-remove-phpmyadmin":
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    cwd     => "/vagrant/",
    command => "sudo rm -Rf /vagrant/phpmyadmin.zip /vagrant/phpMyAdmin"
  }

}
