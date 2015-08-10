# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
require 'yaml'
VAGRANTFILE_API_VERSION = "2"

def config_vm(box, n)
  box.vm.network :private_network, ip: "192.168.50.#{n}"
  pre_bootstrap_script = "salt/pre-bootstrap/#{box.vm.box}.sh"
  if File.file?(pre_bootstrap_script)
    box.vm.provision :shell do |s|
      s.path = pre_bootstrap_script
      s.privileged = true
    end
  end
end

def config_salt(salt, hostname, type = :minion)
  vagrant_grain_file_path = "salt/vagrant-grains/#{hostname}"
  grain_file_path = "salt/grains/#{hostname}"
  if Vagrant.has_plugin?('salty-vagrant-grains')
    if File.file?(grain_file_path)
      salt.grains_config = grain_file_path
    elsif File.file?(vagrant_grain_file_path)
      salt.grains_config = vagrant_grain_file_path
    end
  end
  salt.install_args = '-P -g https://github.com/TronPaul/salt.git git 2015.8.unpro'
  salt.colorize = true
  #salt.verbose = true
  #salt.log_level = 'info'
  salt.run_highstate = true
  salt.minion_config = 'salt/minion'
  salt.minion_key = "salt/key/#{hostname}.pem"
  salt.minion_pub = "salt/key/#{hostname}.pub"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox"
  config.vm.define :nat do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'nat'

    config_vm(box, 3)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end
  end

  config.vm.define :vpn do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'vpn'

    config_vm(box, 4)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end
  end

  config.vm.define :mumble do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'mumble'

    config_vm(box, 5)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end
  end

  config.vm.define :'app-01' do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'app-01'

    config_vm(box, 6)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end
  end

  # Private subnet

  config.vm.define :sensu do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'sensu'

    config_vm(box, 7)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end
  end

  config.vm.define :'salt-master' do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'salt-master'

    config_vm(box, 8)
    box.vm.provision :shell do |s|
      s.path = 'salt/pre-bootstrap/master.sh'
      s.privileged = true
    end
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
      salt.install_master = true
      minions = Dir["salt/key/*.pub"].map {|f| File.basename(f, '.pub')}.reject { |f| f == 'master' }
      salt.seed_master = Hash[minions.collect {|m| [m, "salt/key/#{m}.pub"]}]
      salt.master_config = 'salt/master'
    end
  end

  # INTERNAL
  config.vm.define :nasus do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'nasus'

    config_vm(box, 9)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end    
  end

  config.vm.define :fednet do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'fednet'

    config_vm(box, 10)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end    
  end
end
