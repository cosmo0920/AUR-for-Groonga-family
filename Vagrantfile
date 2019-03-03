# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "arch"
  config.vm.box_url = "./packer-arch/output/packer_arch_virtualbox.box"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.network "private_network", ip: "192.168.33.107"

  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  $script = <<-SCRIPT
  sudo pacman -Sy --noconfirm yajl git
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ~
  echo "enable parallel build..."
  sudo sed -i -e 's/^#MAKEFLAGS/MAKEFLAGS/g' /etc/makepkg.conf
  echo "Installing pkgbuild-introspection..."
  yay -Sy --noconfirm pkgbuild-introspection
  SCRIPT

  config.vm.provision :shell, inline: $script, privileged: false
end
