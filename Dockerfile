from l3iggs/archlinux

maintainer Hiroshi Hatake <cosmo0920.wp@gmail.com>

# install pkgbuild-introspection & yaourt
RUN pacman -Sy --noconfirm pkgbuild-introspection base-devel
RUN curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
RUN tar zxvf package-query.tar.gz
RUN id pacman >/dev/null 2>/dev/null || useradd -r -d /var/empty pacman
# build and install package-query
RUN pacman -S yajl --noconfirm
RUN cd package-query && chown -R pacman:pacman . && su -c "makepkg $MAKEPKGOPTS -si --noconfirm" pacman
RUN cd package-query && pacman -U package-query-*.pkg.tar.xz --noconfirm
# build and install yaourt
RUN curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
RUN tar zxvf yaourt.tar.gz
RUN cd yaourt && chown -R pacman:pacman . && su -c "makepkg $MAKEPKGOPTS -f --noconfirm" pacman
RUN cd yaourt && pacman -U yaourt-*.pkg.tar.xz --noconfirm
RUN sudo sed -i -e 's/^#MAKEFLAGS/MAKEFLAGS/g' /etc/makepkg.conf
# full system upgrade
RUN sudo yaourt -Syu --noconfirm
