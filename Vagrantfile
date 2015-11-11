# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "arch"
  config.vm.box_url = "./packer-arch/packer_arch_virtualbox.box"

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

  pacman_conf = <<-CONF
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\\$arch
  CONF

  $script = <<-SCRIPT
  echo "Installing pkgbuild-introspection..."
  sudo pacman -Sy --noconfirm pkgbuild-introspection yajl
  echo "Installing yaourt..."
  cd ~
  egrep --quiet "^[archlinuxfr]" /etc/pacman.conf
  if [ $? -ne 0 ]; then
    sudo sh -c "echo '#{pacman_conf}' >> /etc/pacman.conf"
  fi
  sudo pacman -Sy --noconfirm yaourt
  SCRIPT

  config.vm.provision :shell, inline: $script, privileged: false
end
