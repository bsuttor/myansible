FROM ubuntu:17.04
MAINTAINER Benoît Suttor

ENV DEBIAN_FRONTEND noninteractive
ENV USER bsuttor


# Installing fuse filesystem is not possible in docker without elevated priviliges
# but we can fake installling it to allow packages we need to install for GNOME
# RUN apt-get install libfuse2 -y && \
#     cd /tmp ; apt-get download fuse && \
#     cd /tmp ; dpkg-deb -x fuse_* . && \
#     cd /tmp ; dpkg-deb -e fuse_* && \
#     cd /tmp ; rm fuse_*.deb && \
#     cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst && \
#     cd /tmp ; dpkg-deb -b . /fuse.deb && \
#     cd /tmp ; dpkg -i /fuse.deb

# RUN localectl set-locale LANG="en_US.UTF-8"

# Upstart and DBus have issues inside docker.
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl
# Install GNOME and tightvnc server.
# RUN apt-get update && apt-get install -y --no-install-recommends ubuntu-desktop gnome-core tightvncserver

RUN apt-get update && \
    apt-get install -y --no-install-recommends ubuntu-desktop && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
    apt-get install -y tightvncserver

# Pull in the hack to fix keyboard shortcut bindings for GNOME 3 under VNC
ADD dev_files/gnome-keybindings.pl /usr/local/etc/gnome-keybindings.pl
RUN chmod +x /usr/local/etc/gnome-keybindings.pl

# Add the script to fix and customise GNOME for docker
ADD dev_files/gnome-docker-fix-and-customise.sh /usr/local/etc/gnome-docker-fix-and-customise.sh
RUN chmod +x /usr/local/etc/gnome-docker-fix-and-customise.sh

RUN apt-get install -y software-properties-common sudo git

RUN useradd -ms /bin/bash bsuttor && echo "bsuttor:bsuttor" | chpasswd && adduser bsuttor sudo
RUN echo "bsuttor ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/bsuttor && \
    chmod 0440 /etc/sudoers.d/bsuttor
USER bsuttor
RUN mkdir -p /home/bsuttor/myansible
ADD Makefile /home/bsuttor/myansible
# WORKDIR /home/bsuttor/myansible
# RUN make install

RUN mkdir -p /home/bsuttor/.vnc
ADD dev_files/xstartup /home/bsuttor/.vnc/xstartup
ADD dev_files/passwd /home/bsuttor/.vnc/passwd
RUN sudo chown bsuttor:bsuttor -R /home/bsuttor/.vnc/
RUN sudo chmod +x /home/bsuttor/.vnc/xstartup
RUN sudo chmod 600 /home/bsuttor/.vnc/passwd
CMD sudo su - bsuttor -c "/usr/bin/vncserver :1 -geometry 1280x800 -depth 24 && tail -f /home/bsuttor/.vnc/*:1.log"

EXPOSE 5901
