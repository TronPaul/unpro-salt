# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :unpro do |box|
    box.vm.box = "precise64"
  
    box.vm.box_url = "http://files.vagrantup.com/precise64.box"

    box.vm.hostname = "teamunpro.com"
  
    box.vm.network :forwarded_port, guest: 80, host: 8080
  
    box.vm.network :private_network, ip: "192.168.50.2"

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
    box.vm.box = "precise64"

    box.vm.box_url = "http://files.vagrantup.com/precise64.box"

    box.vm.hostname = "nasus"

    box.vm.network :private_network, ip: "192.168.50.4"
    box.vm.network :forwarded_port, guest: 8112, host: 8112

    config.vm.synced_folder "state", "/srv/salt/"
    config.vm.synced_folder "pillar", "/srv/pillar/"
    config.vm.synced_folder "grains", "/srv/grains/"
    config.vm.provision "shell", path: "vagrant/grain-up"
    config.vm.provision :salt do |salt|
        salt.minion_config = "vagrant/minion"
        salt.run_highstate = true
        salt.colorize = true
    end    
  end
end
