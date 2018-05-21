# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 4
    vb.memory = "2048"
  end
  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "fedora/27-cloud-base"
  end
  config.vm.define "centos7" do |centos|
    centos.vm.box = "geerlingguy/centos7"
  end
end
