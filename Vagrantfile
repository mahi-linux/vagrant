# -*- mode: ruby -*-
# vi: set ft=ruby :
 
# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version ">= 2.2.14"
VAGRANTFILE_API_VERSION = "2"
 
# Require YAML module
require 'yaml'
 
# Read YAML file with box details
hosts = YAML.load_file('vagrant_hosts.yaml')

# Create and configure the VMs
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

# Disabled vbguest additions
#config.vm.box_check_update = false
#config.vbguest.auto_update = false
config.vm.box_download_insecure = true

# Iterate through entries in YAML file
hosts.each do |host|
  config.vm.define host['name'] do |node|
    node.vm.box = host['box']
    node.vm.hostname = host['hostname']
    node.vm.disk :disk, size: host['size'], name: "Data Disk"
    node.vm.network :private_network, ip: host['ip']
    
    node.vm.provider :virtualbox do |vb|
      vb.name = host['name']
      vb.memory = host['ram']
      vb.cpus = host['vcpu']
end
    node.vm.provision :shell do |sh|
      sh.path = host['provision']

config.vm.provision "file", source: "~/vagrant/zscaler.cer", destination: "/tmp/zscaler.cer"
config.vm.provision "shell", inline: "sudo cp -r /tmp/zscaler.cer /etc/pki/ca-trust/source/anchors/zscaler.cer"
config.vm.provision "shell", inline: "sudo update-ca-trust force-enable; sudo update-ca-trust extract"
#config.vm.provision :shell, run: 'always', path: host['provision'] if host['provision']

end # config.vm.provider 'virtualbox'
end # config.vm.define
end # config.vm.provision
end # Vagrant.configure
