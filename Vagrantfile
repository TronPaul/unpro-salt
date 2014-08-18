# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :unpro do |box|
    box.vm.box = "trusty64"
  
    box.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

    box.vm.hostname = "teamunpro.com"
  
    box.vm.network :private_network, ip: "192.168.50.2"
    # nginx
    box.vm.network :forwarded_port, guest: 80, host: 8080
    # mumble

    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.synced_folder "grains", "/srv/grains/"
    config.vm.provision "shell", path: "vagrant/grain-up"
    config.vm.provision :salt do |salt|
        salt.minion_config = "vagrant/minion"
        salt.run_highstate = true
        salt.verbose = true
        salt.colorize = true
    end
  end

  config.vm.define :nasus do |box|
    box.vm.box = "trusty64"

    box.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

    box.vm.hostname = "nasus"

    box.vm.network :private_network, ip: "192.168.50.3"
    # nginx
    box.vm.network :forwarded_port, guest: 80, host: 8081
    # vpn
    box.vm.network :forwarded_port, guest: 1701, host: 1701
    box.vm.network :forwarded_port, guest: 4500, host: 4500
    box.vm.network :forwarded_port, guest: 500, host: 500

    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.synced_folder "grains", "/srv/grains/"
    config.vm.provision "shell", path: "vagrant/grain-up"
    config.vm.provision :salt do |salt|
        salt.minion_config = "vagrant/minion"
        salt.run_highstate = true
        salt.verbose = true
        salt.colorize = true
    end    
  end

  config.vm.define :'sjds-laptop' do |box|
    box.vm.box = "trusty64"
    box.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    box.vm.hostname = "sjds-laptop"
    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.synced_folder "grains", "/srv/grains/"
    config.vm.provision "shell", path: "vagrant/grain-up"
    config.vm.provision :salt do |salt|
        salt.minion_config = "vagrant/minion"
        salt.run_highstate = true
        salt.verbose = true
        salt.colorize = true
    end    
  end

  config.vm.define :fednet do |box|
    box.vm.box = "trusty64"
    box.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    box.vm.hostname = "fednet"
    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.synced_folder "grains", "/srv/grains/"
    config.vm.provision "shell", path: "vagrant/grain-up"
    config.vm.provision :salt do |salt|
        salt.minion_config = "vagrant/minion"
        salt.run_highstate = true
        salt.verbose = true
        salt.colorize = true
    end    
  end
end
