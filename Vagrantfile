# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "arch"
  # config.vm.box_url = <path to ArchLinux box>

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.network "private_network", ip: "192.168.33.107"

  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  $script = <<-SCRIPT
  echo "Installing pkgbuild-introspection..."
  sudo pacman -Sy --noconfirm pkgbuild-introspection
  echo "Installing yaourt..."
  curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
  tar zxvf package-query.tar.gz
  cd package-query
  makepkg -si --noconfirm --asroot
  cd ..
  curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
  tar zxvf yaourt.tar.gz
  cd yaourt
  makepkg -si --noconfirm --asroot
  cd ..
  echo "enable parallel build..."
  sudo sed -i -e 's/^#MAKEFLAGS/MAKEFLAGS/g' /etc/makepkg.conf
  SCRIPT

  config.vm.provision :shell, inline: $script
end
