# Simple WordPress Vagrant

This is a relatively simple configuration package that will use vagrant, virtualbox, and puppet to create and configura a webserver running WordPress on your computer.

This project has a simple set of goals:

* Setup a WordPress site at (http://www.wp.dev)
* Setup a phpMyAdmin site at (http://db.wp.dev)
* Allow access to WordPress files at [this-directory]/sites/www/
* Allow access to phpMyAdmin files at [this-directory]/sites/db/

# Installation

Required software

* Virtualbox
* Vagrant
* Vagrant - hostsupdater

**Virtualbox**

Virtualbox is a virtual computer system allowing you to have the Linux Operating System running inside your current computer operating system. VirtualBox is usable on MacOS, Windows, and Linux. You can download and install this software by visiting (https://www.virtualbox.org)

**Vagrant**

Vagrant is a virtual machine management application. Vagrant allows the configuration and setup of virtual computers. The Vagrant application uses VirtualBox to launch and run the virtual computers running on your local computer. You can download and install Vagrant by visiting (https://www.vagrantup.com/)

**Vagrant - hostsupdater**

Vagrant - hostsupdater is a plugin for the Vagrant application that allows it to modify the networking settings of your main operating system. This will allow you to use customized hostnames and domain names.

## Instalation Procedure

All installation procedures assume you have administrative access to your comparator to install software. Some of these procedures utilize installation applications that are common to most computer users, but some steps may require the use of a terminal application to run some commands. On MacOS these commands are run using Terminal, and on many versions of Windows the commands will use the CMD application.

### Primary Applications & Utilities

These are the basic applications and utilities that need to be installed.

1. Install VirtualBox by visiting (https://www.virtualbox.org), downloading the latest version, and running the downloaded installation application.
2. Install Vagrant by visiting (https://www.vagrantup.com/), downloading the latest version, and running the downloaded installation application.
3. Install Vagrant - hostsupdater by using a command line utility (on MacOS use Terminal and on Windows use CMD). The command to use is `# vagrant plugin install vagrant-hostsupdater`

### Simple WordPress Vagrant Installation

1. Download the archive for this repository.
2. Uncompress this archive on the computer where you've installed and configured VirtualBox, Vagrant, and Vagrant - HostsUpdater.
3. Using a terminal application or other command line utility, attempt to run the `# vagrand up` command.
4. Once complete you should be able to interact with your MySQL databases by visiting http://db.wp.dev, and you can start your WordPress installation by visiting http://www.wp.dev.

## Simple WordPress Vagrant Usage

The Simple WordPress Vagrant environment is fairly easy to manage and is meant to offer a cheap relatively simple way to learn WordPress web development. The goal is to create a system that will offer some familiarity by using the operating system you are familiar with. The following commands will use the command line terminal available on your operating system.

**To Perform Setup and Activate the Simple WordPress Vagrant**

1. Use the command line utility on your computer and visit the uncompressed directory downloaded from (https://github.com/ev3rywh3re/vagrant-wp-simple)
2. use the command `# vagrant up` to perform the install and activation.

**To Test and Use the Simple WordPress Vagrant**

If everything installed fine and is working great, you should have the following URLs running on your local computer.

* (http://db.wp.dev) - The phpMyAdmin utility. This utility is installed so you can interact with the database portion of the WordPress installation. Information about phpMyAdmin can be found at (https://www.phpmyadmin.net).
* (http://www.wp.dev) - Your local WordPress installed. This installation is a fresh installation, so you will still need to supply the basic information when you first setup your Simple WordPress Vagrant.

The **WordPress** portion of your Simple WordPress Vagrant has been prepared with a basic database and database user for you to use in the WordPress installation on (http://www.wp.dev) The MySQL database, user, and password are as follows:

* Database name: wordpress
* Database user: wordpress
* Database password: wordpress

The **files for your Simple WordPress Vagrant site** will be found in [this-directory]/sites/www/. This means that you will be able to directly edit files and install themes into [this-directory]/sites/www/wp-content/themes/ and plugins into [this-directory]/sites/www/wp-content/plugins/.

**To Shutdown the Simple WordPress Vagrant**

Use your computers command line utility and submit the `# vagrant halt` command. This is a non-destructive option that will shutdown the virtual system and you will be able to restart the system by issuing the `# vagrant up` command.

**To Reset and Remove the Simple WordPress Vagrant**

This option is also still partially non-destructive, but this will remove the virtual system and destroy the database used by your (http://www.wp.dev) site. To perform this option, use your operating system command line utility to run the `# vagrant destroy` command. **This option will not modify files in the [this-directory]/sites/www or [this-directory]/sites/db directories.**

**Other Ways to Interact With Your New System**

This simple Vagrant setup uses the standard Vagrant accounts. **Be aware that this type of system is intended for development purposes and this system is not secure. Please review all security before making systems like this accessible to the internet.**

You will be able to access this systems by using SSH on your local system. Using SSH will allow you to login and access the virtual server from the local machine where you've installed VirtualBox and Vagrant. You learn more elsewhere about using SSH to manage Linux systems. Here are the basic user accounts and root or administrative user account.

* General user account: Username: vagrant Password: vagrant
* Root administrative user: Username: root Password: vagrant
