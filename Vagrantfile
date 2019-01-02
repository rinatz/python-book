# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  config.vm.provision "shell", inline: <<-SHELL
    sed -i 's,archive.ubuntu.com,ubuntutym.u-toyama.ac.jp,g' /etc/apt/sources.list
    apt-get update
    apt-get install -y python3-pip
    pip3 install pipenv
  SHELL

  config.vm.provision "docker"
end
