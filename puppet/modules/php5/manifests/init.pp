# Install PHP

class php5::install {

  package { [
      'php5',
      'php5-mysql',
      'php5-curl',
      'php5-gd',
      'php5-fpm',
      'libapache2-mod-php5',
    ]:
    ensure => present,
  }

}

define set_php_var($value) {
  exec { "sed -i 's/^;*[[:space:]]*$name[[:space:]]*=.*$/$name = $value/g' /etc/php.ini":
    unless  => "grep -xqe '$name[[:space:]]*=[[:space:]]*$value' -- /etc/php.ini",
    path    => "/bin:/usr/bin",
    require => Package[php5],
    notify  => Service[apache2];
  }
}
set_php_var {
  "post_max_size":       value => '10M';
  "upload_max_filesize": value => '10M';
}
