# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "arch"
  config.vm.box_url = "./packer-arch/output/packer_arch_virtualbox.box"

  config.vm.network "forwarded_port", guest: 80, host: 8888

  config.vm.network "private_network", ip: "192.168.33.107"

  config.ssh.forward_agent = true

  # set auto_update to false, if you do NOT want to check the correct
  # additions version when booting this machine due to using NFS instead.
  config.vbguest.auto_update = false

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
  config.vm.synced_folder ".", "/vagrant", type: "nfs",
                          linux__nfs_options: ['rw','no_subtree_check','all_squash','async']
end
