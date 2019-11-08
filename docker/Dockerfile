FROM ubuntu:18.04

RUN apt-get update && apt-get -y install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping libsdl1.2-dev xterm tar locales curl vim && \
     apt-get clean && \
     rm -rf /var/lib/apt/lists/*

RUN rm /bin/sh && ln -s bash /bin/sh

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo && \
    chmod a+x /usr/bin/repo

RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV USER_NAME yocto
ENV PROJECT yocto 

ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME && useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

#USER $USER_NAME

WORKDIR /home/$USER_NAME 

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

