# Simple WordPress Vagrant

This is a relatively simple configuration package that will use vagrant, virtualbox, and puppet to create and configura a webserver running WordPress on your computer.

This project has a simple set of goals:

* Setup a WordPress site at http://www.wp.dev
* Setup a phpMyAdmin site at http://db.wp.dev
* Allow access to WordPress files at [this-directory]/sites/www/
* Allow access to phpMyAdmin files at [this-directory]/sites/db/

# Installation

Required software

* Virtualbox
* Vagrant
* Vagrant - hostsupdater

**Virtualbox**

Virtualbox is a virtual computer system allowing you to have the Linux Operating System running inside your current computer operating system. VirtualBox is usable on MacOS, Windows, and Linux. You can download and install this software by visiting [https://www.virtualbox.org]

**Vagrant**

Vagrant is a virtual machine management application. Vagrant allows the configuration and setup of virtual computers. The Vagrant application uses VirtualBox to launch and run the virtual computers running on your local computer. You can download and install Vagrant by visiting [https://www.vagrantup.com/]

**Vagrant - hostsupdater**

Vagrant - hostsupdater is a plugin for the Vagrant application that allows it to modify the networking settings of your main operating system. This will allow you to use customized hostnames and domain names.

## Instalation Procedure

All installation procedures assume you have administrative access to your comparator to install software. Some of these procedures utilize installation applications that are common to most computer users, but some steps may require the use of a terminal application to run some commands. On MacOS these commands are run using Terminal, and on many versions of Windows the commands will use the CMD application.

### Primary Applications & Utilities

These are the basic applications and utilities that need to be installed.

1. Install VirtualBox by visiting [https://www.virtualbox.org], downloading the latest version, and running the downloaded installation application.
2. Install Vagrant by visiting [https://www.vagrantup.com/], downloading the latest version, and running the downloaded installation application.
3. Install Vagrant - hostsupdater by using a command line utility (on MacOS use Terminal and on Windows use CMD). The command to use is `# vagrant plugin install vagrant-hostsupdater`

### Simple WordPress Vagrant Installation

1. Download the archive for this repository.
2. Uncompress this archive on the computer where you've installed and configured VirtualBox, Vagrant, and Vagrant - HostsUpdater.

## Simple WordPress Vagrant Usage

The Simple WordPress Vagrant environment is fairly easy to manage and is meant to offer a cheap relatively simple way to learn WordPress web development. The goal is to create a system that will offer some familiarity by using the operating system you are familiar with. The following commands will use the command line terminal available on your operating system.

**To Perform Setup and Activate the Simple WordPress Vagrant**

1. Use the command line utility on your computer and visit the uncompressed directory downloaded from [https://github.com/ev3rywh3re/vagrant-wp-simple]
2. use the command `# vagrant up` to perform the install and activation.

**To Test and Use the Simple WordPress Vagrant**

If everything installed fine and is working great, you should have the following URLs running on your local computer.

* [http://db.wp.dev] - The phpMyAdmin utility. This utility is installed so you can interact with the database portion of the WordPress installation. Information about phpMyAdmin can be found at [https://www.phpmyadmin.net].
* [http://www.wp.dev] - Your local WordPress installed. This installation is a fresh installation, so you will still need to supply the basic information when you first setup your Simple WordPress Vagrant.

The **WordPress** portion of your Simple WordPress Vagrant has been prepared with a basic database and database user for you to use in the WordPress installation on [http://www.wp.dev] The MySQL database, user, and password are as follows:

* Database name: wordpress
* Database user: wordpress
* Database password: wordpress
