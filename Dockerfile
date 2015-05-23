from cosmo0920/arch-dockerfile

maintainer Hiroshi Hatake <cosmo0920.wp@gmail.com>

RUN mkdir -p /aur-build
COPY abs /aur-build
RUN cd /aur-build && chown -R pacman:pacman .
RUN pacman -S zlib lz4 glib2 libedit zeromq libevent --noconfirm
RUN su -c "yaourt -S mecab mecab-ipadic --noconfirm" pacman
RUN cd /aur-build/groonga && su -c "makepkg $MAKEPKGOPTS -s --noconfirm" pacman
