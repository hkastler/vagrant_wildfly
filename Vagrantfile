# -*- mode: ruby -*-
# vi: set ft=ruby :

PROJECT_NAME = "wildfly"
PROJECT_TITLE = "Wildfly"
SERVER_IP = "192.168.10.10"

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.  
  config.omnibus.chef_version = :latest
  
  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []
  
  
config.vm.define :wildfly do |wildfly|
  wildfly.vm.hostname = "#{PROJECT_NAME}"
  

  # Every Vagrant virtual environment requires a box to build off of.
  wildfly.vm.box = "opscode_centos-6.5"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  wildfly.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  wildfly.vm.network :private_network, ip: "#{SERVER_IP}"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.

  # config.vm.network :public_network

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
	wildfly.vm.network :forwarded_port, guest: 8080, host: 8080
	wildfly.vm.network :forwarded_port, guest: 9990, host: 9990
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   wildfly.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
	 vb.name = "#{PROJECT_TITLE}"
  # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "2048"]
   end
  #
  
  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  wildfly.vm.provision :chef_solo do |chef|
  
	chef.add_recipe "ark"
	chef.add_recipe "yum"
	chef.add_recipe "java"
	chef.add_recipe "wildfly"
  
    chef.json = {
      :java => {
				  :install_flavor => "oracle",
				  :jdk_version => "7",
				  :oracle => {
					:accept_oracle_download_terms => true
				  }
				},
	   :wildfly => {			
			:version => "wildfly-8.0.0.Final",
			:zip_url => "http://download.jboss.org/wildfly/8.0.0.Final/wildfly-8.0.0.Final.zip",
			:user => "wildfly",
			:group => "wildfly",
			:adminuser => "wildfly",
			:adminuserpwd => "wildfly"}
    }
  end
  
 
end
end
