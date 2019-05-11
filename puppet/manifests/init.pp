# Define puppet run order customization
stage { 'setup':
  require => Stage['main'],
}

stage { 'final':
  require => Stage['setup'],
}

include postfix

class { 'git::install': }
class { 'apache2::install': }

# PHP Installations (php5 & php7 see comments)
# PHP5 requires debian/jessie64 - see VagrantFile
# class { 'php5::install': }
class { 'php7::install': }
# class { 'php7_3::install': }


class { 'mysql::install': }
class { 'startup::install': stage => 'setup'  }

class { 'wordpress::install': stage => 'setup' }
class { 'phpmyadmin::install': stage => 'setup' }

class { 'cleanup::install': stage => 'final' }
