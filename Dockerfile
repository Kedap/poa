FROM blackikeeagle/archlinux-build
WORKDIR /home/archbuild
#RUN sudo pacman -Syu cargo git python-pip python2-pip wget ruby-bundler npm rsync --noconfirm
RUN sudo pacman -S cargo git
COPY poa.sh /usr/bin/poa
ENTRYPOINT [ "poa" ]
