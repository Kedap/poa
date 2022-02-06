FROM blackikeeagle/archlinux-build
WORKDIR /home/archbuild
RUN sudo pacman -Sy cargo git --noconfirm
COPY poa.sh /usr/bin/poa
RUN sudo pacman -Scc --noconfirm
ENTRYPOINT [ "poa" ]
