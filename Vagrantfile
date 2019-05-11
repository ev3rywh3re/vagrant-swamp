# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

#Vagrant.require_version ">= 1.5.0"
if `vagrant --version` < 'Vagrant 1.5.0'
    abort('Your Vagrant is too old. Please install at least 1.5.0')
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2024"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.box = "debian/stretch64"
  # config.vm.box = "debian/buster64"
  # PHP5 requires Debian Jessie64 see PHP Puppet configuration.
  # config.vm.box = "debian/jessie64"
  config.vm.hostname = "wp.loc"
  config.vm.network :private_network, ip: "192.168.33.28"

  # trying to fix browsersync
  config.vm.network :forwarded_port, guest: 8181, host: 80, auto_correct: true

  # If you have problems TRY: # vagrant plugin install vagrant-vbguest
  # config.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant"
  # config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  # Synced folder with custom open permissions.
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox", mount_options: ["dmode=777", "fmode=777"]

  # fix some ssh issures
  # ssh settings
  config.ssh.insert_key = false
  config.ssh.keys_only = false
  config.ssh.private_key_path = ["keys/private", "~/.vagrant.d/insecure_private_key"]
  config.vm.provision "file", source: "keys/public", destination: "~/.ssh/authorized_keys"
  config.vm.provision "shell", inline: <<-EOC
    sudo sed -ri 's/#?PubkeyAuthentication\sno/PubkeyAuthentication yes/' /etc/ssh/sshd_config
    sudo service ssh restart
  EOC

  if defined? VagrantPlugins::HostsUpdater
  config.hostsupdater.aliases = [
    "www.wp.loc",
    "db.wp.loc",
    "dev.wp.loc"
  ]
  end

  # Fix some 'stdin: is not a tty' errors
  # https://github.com/mitchellh/vagrant/issues/1673
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # fixes for vagrant errors found at: https://github.com/hashicorp/vagrant/issues/7508
  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = true
    s.inline = "sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n \\|\\| true/' /root/.profile"
  end

  config.vm.provision "disable-apt-periodic-updates", type: "shell" do |s|
    s.privileged = true
    s.inline = "echo 'APT::Periodic::Enable \"0\";' > /etc/apt/apt.conf.d/02periodic"
  end

  # Address a bug in an older version of Puppet
  # See http://stackoverflow.com/questions/10894661/augeas-support-on-my-vagrant-machine
  # config.vm.provision :shell, :inline => "if ! dpkg -s puppet > /dev/null; then sudo apt-get update --quiet --yes && sudo apt-get install puppet --quiet --yes; fi"
  # config.vm.provision :shell, :inline => "dpkg -l | grep puppetlabs >/dev/null ; if [ $? == 1 ];then wget https://apt.puppetlabs.com/puppetlabs-release-squeeze.deb && dpkg -i puppetlabs-release-squeeze.deb && apt-get update && apt-get install -y puppet facter -t puppetlabs;fi"
  # fix apt-get issues in provisioning: https://github.com/zivtech/vagrant-development-vm/issues/11
  config.vm.provision "shell", :inline => <<-SHELL
    sudo apt-get update --fix-missing
    sudo apt-get upgrade
    sudo apt-get install -y puppet
    sudo apt-get install -y unzip
    sudo wget -q https://apt.puppetlabs.com/puppet5-release-stretch.deb
    sudo dpkg -i puppet5-release-stretch.deb
    sudo apt-get install -y ca-certificates apt-transport-https
  SHELL

  # prep external reposity to install non-standard PHP versions
  config.vm.provision "shell", :inline => <<-SHELL
    wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add -
    echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list
  SHELL

  # Make sure submodules are installed
  config.vm.provision :shell, :inline => "if ! `which git` > /dev/null; then sudo apt-get install git --quiet --yes; fi;"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "init.pp"
    puppet.options="--verbose --debug"
  end

  # Shell script setup methods
  # config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.define "debian" do |debian|

      # Backup Databases
      debian.trigger.before :destroy do |trigger|
        trigger.warn = "Dumping database to /vagrant/backups"
        trigger.run_remote = {inline: "/vagrant/scripts/backupdbs.sh"}
        trigger.on_error = :continue
      end

      # Restore Databases
      debian.trigger.after :up do |trigger|
        trigger.warn = "Restoring database from /vagrant/backups"
        trigger.run_remote = {inline: "/vagrant/scripts/restoredbs.sh"}
        trigger.on_error = :continue
      end

    end

end
