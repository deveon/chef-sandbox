# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.provider :virtualbox do |provider|
    provider.customize ["modifyvm", :id, "--memory", "700"]
    config.vm.box = "ubuntu-precise-12.04.3-lts"
    config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  end


  config.vm.define "apt_server_node" do |node|
    node.vm.network :private_network, ip: "33.33.33.11"

    node.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"
      chef.data_bags_path = "data_bags"

      chef.add_role "base"
      chef.add_role "repo"
    end
  end

  config.vm.define "loghost_node" do |node|
    node.vm.network :private_network, ip: "33.33.33.12"

    node.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"
      chef.data_bags_path = "data_bags"

      chef.add_role "base"
      chef.add_role "loghost"
    end
  end

end
