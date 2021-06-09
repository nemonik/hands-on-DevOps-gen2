
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.name = "Hands-on DevOps class"
    virtualbox.gui = false

    # disable audio
    virtualbox.customize ['modifyvm', :id, '--audio', 'none']

    virtualbox.customize ['modifyvm', :id, '--nic1', 'nat']
    virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
    virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    virtualbox.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

    virtualbox.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-interval", 10000 ]
    virtualbox.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-min-adjust", 100 ]
    virtualbox.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-on-restore", 1 ]
    virtualbox.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-start", 1 ]
    virtualbox.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]

    virtualbox.memory = 32768
    virtualbox.cpus = 4

  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.box = "archlinux/archlinux"

  config.vm.box_check_update = true

  config.vm.network "private_network", ip: "192.168.0.10"

  config.vm.synced_folder ".", "/vagrant_data"

  config.disksize.size = '50GB' 

  config.vm.hostname = "k3d-cluster"

end
