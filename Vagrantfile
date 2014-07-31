# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.3"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Configure base image for all VMs
  config.vm.box = "ubuntu/ubuntu-14.04-server-amd64"
  config.vm.box_url="http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.ssh.forward_agent = true # forward ssh keys from host to guest

  # PLUGINS
  # Set the version of chef to install using the vagrant-omnibus plugin
  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = :latest
  end

  # Enable berkshelf to copy cookbooks
  if Vagrant.has_plugin?("vagrant-berkshelf")
    config.berkshelf.enabled = true
  end

  # Enable provisioning caching for vagrant
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  # When chef-zero is installed, use chef_client to configure VM
  if Vagrant.has_plugin?("vagrant-chef-zero")
    config.chef_zero.enabled = true
    config.chef_zero.chef_repo_path = "."
    config.chef.encrypted_data_bag_secret_key_path = '~/hom/etc/chef/encrypted_data_bag_secret'

    config.vm.provision :chef_client do |chef|
      chef.run_list = [
          "recipe[camunda-ci-jenkins::default]"
      ]
    end
    # Use chef_solo to configure VM
  else
    VAGRANT_JSON = JSON.parse(Pathname(__FILE__).dirname.join('nodes', 'vagrant.json').read)
    config.vm.provision :chef_solo do |chef|

      # Allows to set chef log level frmóm cmdline like EXPORT CHEF_LOG=debug ...
      chef.formatter = ENV.fetch("CHEF_FORMAT", "null").downcase.to_sym
      chef.log_level = ENV.fetch("CHEF_LOG", "info").downcase.to_sym

      # DO NOT REMOVE otherwise chef-solo won't find the databags
      chef.data_bags_path = "data_bags"

      # Fill the runlist from 'nodes/vagrant.json'
      chef.json = VAGRANT_JSON
      VAGRANT_JSON['run_list'].each do |recipe|
        chef.add_recipe(recipe)
      end if VAGRANT_JSON['run_list']
    end
  end

  config.vm.define :jenkins, primary: true do |jenkins|
    jenkins.vm.hostname = "camunda-ci-jenkins"

    jenkins.vm.network :private_network, type: "dhcp"
    jenkins.vm.network :forwarded_port, guest: 8080, host: 8080

    jenkins.vm.provider :virtualbox do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
  end

end
