# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

def config_salt(salt, hostname)
  salt.minion_pub = "salt/key/#{hostname}.pub"
  salt.minion_key = "salt/key/#{hostname}.pem"
  salt.minion_config = "salt/minion"
  salt.run_highstate = true
  salt.verbose = true
  salt.colorize = true
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
# EXTERNAL
  config.vm.define :teamunpro do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "teamunpro.com"

    config.vm.network :private_network, ip: "192.168.50.2"

    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.synced_folder "grains", "/srv/grains/"
    config.vm.provision "shell", path: "vagrant/add-hosts.sh"
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end
  end

  config.vm.define :vpn do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "vpn"

    config.vm.network :private_network, ip: "192.168.50.3"

    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.synced_folder "grains", "/srv/grains/"
    config.vm.provision "shell", path: "vagrant/grain-up"
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end
  end

  # INTERNAL
  config.vm.define :nasus do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "nasus"

    config.vm.network :private_network, ip: "192.168.50.4"

    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.provision :salt do |salt|
        salt.install_master = true
        salt.seed_master = { "nasus" => "salt/key/nasus.pub", "teamunpro.com" => "salt/key/teamunpro.com.pub"}
        config_salt(salt, box.vm.hostname)
    end    
  end

  config.vm.define :'sjds-laptop' do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    box.vm.hostname = "sjds-laptop"
    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.synced_folder "grains", "/srv/grains/"
    config.vm.provision "shell", path: "vagrant/grain-up"
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end    
  end

  config.vm.define :fednet do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    box.vm.hostname = "fednet"
    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.synced_folder "grains", "/srv/grains/"
    config.vm.provision "shell", path: "vagrant/grain-up"
    config.vm.provision :salt do |salt|
        config_salt(salt, box.vm.hostname)
    end    
  end
end
