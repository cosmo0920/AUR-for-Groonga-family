from base/archlinux

maintainer Hiroshi Hatake <cosmo0920.wp@gmail.com>

# install pkgbuild-introspection & yaourt
RUN pacman -Sy --noconfirm pkgbuild-introspection base-devel
RUN curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
RUN tar zxvf package-query.tar.gz
RUN cd package-query && makepkg -si --noconfirm --asroot
RUN curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
RUN tar zxvf yaourt.tar.gz
RUN cd yaourt && makepkg -si --noconfirm --asroot
RUN sudo sed -i -e 's/^#MAKEFLAGS/MAKEFLAGS/g' /etc/makepkg.conf
RUN sudo yaourt -Syu --noconfirm
