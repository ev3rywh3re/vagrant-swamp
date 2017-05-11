# Setup and make directories

class startup::install {

  # or you can assign them to a variable and use them in the resource
  $site_dirs = [
    '/vagrant/sites',
    '/vagrant/sites/www',
    '/vagrant/sites/db',
    '/vagrant/sites/dev',
  ]

  file { $site_dirs:
    ensure => 'directory',
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0755',
  }

}
