# RPM Build  and Yum Repo - Demo

The project contains a Vagrant config file, and Puppet manifests that together with an appropriate basebox will create a VM setup to build RPMS and host them on a Custom Yum repository

To run this

 1. Install vagrant http://vagrantup.com/ (on Ubuntu just `apt-get install vagrant`)
 
 1. Install Virtualbox https://www.virtualbox.org/wiki/Downloads (again on Ubuntu `apt-get install virtualbox`)

 1. Clone this reporitory `git clone git@github.com:practicalweb/vagrant-rpmbuild.git`

 1. run `vagrant up` from the root of your cloned repository (NB the first time you do the a 600Mb base image will be dowmloaded)

 1. run `vagrant ssh` to connect to the new VM  

 1. To build the demo rpm and publish it locally run `/vagrant/build-rpm.sh` the key password is 'secret'

 1. To install the demo package on the VM run `sudo yum install demo`

 
This project is intended as documentation of how to setup this build environment, and as a starting point for further customisation, I'm sure it isn't perfect.

I've tried to group the code logically, there are 4 modulea

<dl>
  <dt>base</dt>
    <dd>This contains some generic stuff, pulling in a couple of packages not in the minimal centos install but that I find essential.<dd>
    <dd>The idea is that I would use this base module on every server I setup.</dd>

  <dt>rpmbuild</dt>
    <dd>Just what is needed to actually build the RPMs<dd>
  
  <dt>tomyumrepo</dt>
     <dd>Just what is needed to serve a custom yum repository, the packages could be built elsewhere</dd>
  <dt>usemyrepo</dt>
     <dd>Config to setup a machine to consume yum packages.</dd>
     <dd>This could be added to the setup for any machine that needs to use the custom packages</dd>
</dl>

I've included a minimal RPM project to get things rolling, it just installs a single text file.

I've built a GPG key to sign packages with, and also included a script ( generate-gpg-key.sh ) which shows how to generate a new one, edit this file to make your own key.

The base box I've defined is a minimal install of CentOS 6.3 (64 bit) with the dependencies required for vagrant.

Base boxes are quite a heavy download, but you only need to do it once and then you can have as many VMs as you want based on them, because the base is minimal and all extra config is done in puppet each of these VMs can serve a very differnt purpose - just by changing the Vagrantfile and puppet config.

The Vagrantfile runs puppet in standalone mode, but the modules /should/ work with a client/server Puppet setup - so hopefully migrating the Vagrant setup to any Puppet manged system should be easy.


