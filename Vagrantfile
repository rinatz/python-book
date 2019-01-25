# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  config.vm.provision "shell", inline: <<-SHELL
    sed -i 's,archive.ubuntu.com,jp.archive.ubuntu.com,g' /etc/apt/sources.list
    apt-get update

    apt-get install -y build-essential libbz2-dev libdb-dev \
      libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
      libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev \
      zlib1g-dev uuid-dev tk-dev

    curl -fsSL https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz | tar zxv -C /tmp
    cd /tmp/Python-3.7.2
    ./configure --enable-shared
    make
    make install
    ldconfig

    python3 -m pip install -U pip pipenv
  SHELL
end
