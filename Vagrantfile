# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
require 'yaml'
VAGRANTFILE_API_VERSION = "2"

def seed_hash(hosts)
  Hash[hosts.map {|host| [host, "vagrant/key/#{host}.pub"]}]
end

def config_vm(config)
    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.provision "shell", path: "vagrant/add-hosts.sh"
end

def config_salt(salt, hostname)
  salt.minion_pub = "vagrant/key/#{hostname}.pub"
  salt.minion_key = "vagrant/key/#{hostname}.pem"
  grain_file_path = "vagrant/grains/#{hostname}"
  if Vagrant.has_plugin?("salty-vagrant-grains") && File.file?(grain_file_path)
    salt.grains(YAML.load_file grain_file_path)
  end
  salt.minion_config = "salt/minion"
  salt.run_highstate = true
  salt.verbose = true
  salt.colorize = true
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
# EXTERNAL
  config.vm.define :salt do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "salt"

    config.vm.network :private_network, ip: "192.168.50.2", virtualbox__intnet: "amazon"

    config_vm(config)
    config.vm.provision :salt do |salt|
        salt.install_master = true
        salt.seed_master = seed_hash(["salt", "mumble", "vpn", "www", "nasus"])
        config_salt(salt, box.vm.hostname)
    end
  end

  config.vm.define :mumble do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "mumble"

    config.vm.network :private_network, ip: "192.168.50.3", virtualbox__intnet: "amazon"

    config_vm(config)
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end
  end

  config.vm.define :vpn do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "vpn"

    config.vm.network :private_network, ip: "192.168.50.4", virtualbox__intnet: "amazon"
    config.vm.network :private_network, ip: "192.168.51.2", virtualbox__intnet: "internet"

    config_vm(config)
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end
  end

  config.vm.define :www do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "www"

    config.vm.network :private_network, ip: "192.168.50.5", virtualbox__intnet: "amazon"

    config_vm(config)
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end
  end

  # INTERNAL
  config.vm.define :nasus do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "nasus"

    config.vm.network :private_network, ip: "192.168.51.3", virtualbox__intnet: "internet"

    config_vm(config)
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end    
  end

  config.vm.define :'sjds-laptop' do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "sjds-laptop"

    config_vm(config)
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end    
  end

  config.vm.define :fednet do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "fednet"

    config_vm(config)
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end    
  end
end
