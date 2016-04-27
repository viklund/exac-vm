# -*- mode: ruby -*-
# vi: set ft=ruby :

mongodb_image = '../exac_vm_mongodb.vdi'

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.synced_folder "../exac_data", "/home/vagrant/exac_data"
  config.vm.synced_folder "../exac_browser", "/home/vagrant/exac_browser"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "12288"
    vb.cpus = 2

    ## Extra disk, 100 Gb
    if ARGV[0] == "up" && !File.exist?(mongodb_image)
        vb.customize ['createhd', '--filename', mongodb_image, 
                                  '--size', 100 * 1024,
                                  '--format', 'VDI',
                                  '--variant', 'fixed']
        vb.customize ['storageattach', :id,
                        '--storagectl', "IDE Controller",
                        '--port', 1, '--device', 0,
                        '--type', 'hdd', '--medium', mongodb_image]
    end
  end
  config.vm.provision "shell", path: "attach_disk.sh"
  config.vm.provision "ansible" do |ansible|
      ansible.sudo = true
      ansible.playbook = 'playbook.yml'
      ansible.verbose = false
  end
end
