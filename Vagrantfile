# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  # All development local env servers listed below will need to be added to your /etc/hosts file
  # Example:
  # 10.123.50.100 base.development-local.synctree.com

  domain        =  "synctree.com"
  
  environments  = {
    
    ### LOCAL ###
    development_local: [
      {
        name:             "base", 
        ip:               "10.123.50.100", 
        roles:            %w(base)
      }
    ],

    ### AWS ###
    production_east: []
  }  
  
  environments.each do |e, machines|
    environment = e.to_s.gsub!("_","-")

    machines.each do |machine|
      
      dns = "#{machine[:name]}.#{environment}.#{domain}"

      config.vm.define dns do |node|
        node.vm.network :private_network, ip: machine[:ip]

        case machine[:provider]
        when :aws
          node.vm.box                       = "dummy"

          node.vm.provider :aws do |aws, override|
            aws.access_key_id               = ENV["AWS_SYNCTREE_ACCESS_KEY_ID"]
            aws.secret_access_key           = ENV["AWS_SYNCTREE_SECRET_ACCESS_KEY"]
            aws.subnet_id                   = ENV["AWS_SYNCTREE_VPC_PRIVATE_SUBNET_ID"]
            
            aws.private_ip_address          = machine[:ip]
            aws.ami                         = machine[:ami]
            aws.instance_type               = machine[:instance_type]
            aws.security_groups             = machine[:security_groups]
            
            aws.region                      = "us-east-1"
            aws.availability_zone           = "us-east-1e"
            aws.keypair_name                = ENV["AWS_SYNCTREE_KEYPAIR_NAME"]
            aws.tags                        = {"Name" => machine[:name]}

            aws.user_data                   = "#!/bin/bash\necho 'Defaults:ec2-user !requiretty' > /etc/sudoers.d/999-vagrant-cloud-init-requiretty && chmod 440 /etc/sudoers.d/999-vagrant-cloud-init-requiretty"

            override.ssh.username           = "ec2-user"
            override.ssh.private_key_path   = ENV["AWS_SYNCTREE_KEYPAIR_PATH"]
          end
        when :virtualbox
        else
          node.vm.box                       = "ubuntu-precise-12.04.1-lts"
          node.vm.box_url                   = "http://files.vagrantup.com/precise64.box"

          node.vm.provider :virtualbox do |provider|
            provider.customize ["modifyvm", :id, "--memory", "256"]
          end
        end

        chef_solo(dns, node, environment, machine[:roles])
      end
    end

    def chef_solo(dns, node, environment, additional_roles = [])
      node.vm.provision :chef_solo do |chef|
        chef.roles_path = "roles"
        chef.data_bags_path = "data_bags"
        chef.environments_path = "environments"
        
        chef.environment = environment
        chef.add_role "base"

        additional_roles.each do |role_name|
          chef.add_role role_name
        end

        chef.node_name = dns

        chef.json = {
          rvm: {
            vagrant: {
              system_chef_client: "/opt/chef/bin/chef-client",
              system_solo_client: "/opt/chef/bin/chef-solo"
            }
          }
        }
        
        yield(chef) if block_given?
      end
    end
  end

end
