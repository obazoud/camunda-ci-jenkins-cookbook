# Using Vagrant

## Prerequisites

For development of the camunda-ci-jenkins cookbook environment, you need to install:

* [Chef Development Kit](http://www.getchef.com/downloads/chef-dk/) or
   * alternatively install
      * Ruby >= 2.0.0 (maybe use something like [RVM](http://rvm.io) to install and manage your ruby versions.
      * Gems
         * [Bundler](http://bundler.io/)

* Virtualbox
    * Latest Version -> http://download.virtualbox.org/virtualbox/LATEST.TXT
    * Windows -> http://download.virtualbox.org/virtualbox/
    * Linux -> https://www.virtualbox.org/wiki/Linux_Downloads
* Vagrant -> [ ![Download](https://api.bintray.com/packages/mitchellh/vagrant/vagrant/images/download.png) ](https://bintray.com/mitchellh/vagrant/vagrant/_latestVersion)
* Vagrant plugins
```
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-berkshelf --plugin-version '>= 2.0.1'
```


## Managing the Vagrant VM

Use ```vagrant up``` to create the virtual machine using the camunda-ci-jenkins cookbook while provisioning.
Use ```vagrant ssh``` to login to the virtual machine.
The user / password combo is ```vagrant / vagrant ```. The user has sudo rights.
If you want to start all over, execute
```
vagrant halt && \
vagrant destroy -f && \
vagrant up
```


## Known issues

If you got an error during boot regarding the network configuration and DHCP. Please see this
[vagrant issue](https://github.com/mitchellh/vagrant/issues/3083).

A known workaround is to execute

```
VBoxManage dhcpserver remove --netname HostInterfaceNetworking-vboxnet0
```

before `vagrant up`.
