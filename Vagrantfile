# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
require 'yaml'
VAGRANTFILE_API_VERSION = "2"

def config_vm(box, n)
  box.vm.synced_folder "state", "/srv/salt/"
  box.vm.synced_folder "formulas", "/srv/formulas"
  box.vm.synced_folder "pillar", "/srv/pillar/"
  box.vm.network :private_network, ip: "192.168.50.#{n}"
end

def config_salt(salt, hostname)
  vagrant_grain_file_path = "salt/vagrant-grains/#{hostname}"
  grain_file_path = "salt/grains/#{hostname}"
  if Vagrant.has_plugin?("salty-vagrant-grains")
    if File.file?(grain_file_path)
      salt.grains(YAML.load_file grain_file_path)
    elsif File.file?(vagrant_grain_file_path)
      salt.grains(YAML.load_file vagrant_grain_file_path)
    end
  end
  salt.install_args = "-X -g https://github.com/TronPaul/salt.git git v2014.7.2"
  salt.minion_config = "salt/minion"
  salt.verbose = true
  salt.colorize = true
  salt.run_highstate = true
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

  # INTERNAL
  config.vm.define :nasus do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'nasus'

    config_vm(box, 7)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end    
  end

  config.vm.define :'sjds-laptop' do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'sjds-laptop'

    config_vm(box, 8)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end    
  end

  config.vm.define :fednet do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = 'fednet'

    config_vm(box, 9)
    box.vm.provision :salt do |salt|
      config_salt(salt, box.vm.hostname)
    end    
  end
end
