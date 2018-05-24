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

    fedora.vm.provision "build_rpm", type: "shell" do |p|
      p.privileged = true
      p.inline = 'cd /vagrant && make clean && make dependencies && make build && dnf install ./RPMS/x86_64/Signal-Desktop-1.11.0-1.el7.centos.x86_64.rpm -y'
    end
  end

  config.vm.define "centos7" do |centos|
    centos.vm.box = "geerlingguy/centos7"
    centos.vm.provision "build_rpm", type: "shell" do |p|
      p.privileged = true
      p.inline = 'cd /vagrant && make clean && make dependencies && make build && yum install ./RPMS/x86_64/Signal-Desktop-1.11.0-1.el7.centos.x86_64.rpm -y'
    end
  end
end
