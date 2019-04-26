# Dockerfile for Coreseek:3.2.14
# Copyright (C) 2018 - 2019 liwl <i@1iwl.com>
# From:https://github.com/sunfjun/Dockfile-Coreseek/
# https://github.com/303493624/coreseek_docker

FROM centos:6
MAINTAINER liwl i@1iwl.com

RUN yum install -y \
        make \
        gcc \
        g++ \
        gcc-c++ \
        libtool \
        autoconf \
        automake \
        imake \
        libxml2-devel \
        expat-devel \
        mysql-devel

RUN mkdir -p /usr/local/src/coreseek
ADD ./coreseek /usr/local/src/coreseek
RUN chmod 755 -R /usr/local/src/coreseek

WORKDIR /usr/local/src/coreseek/mmseg-3.2.14
RUN ./bootstrap
RUN ./configure
RUN make && make install

WORKDIR /usr/local/src/coreseek/csft-3.2.14
RUN ./buildconf.sh
RUN ./configure --without-unixodbc --with-mmseg --with-mysql
RUN make && make install


ADD ./cron/sphinx /etc/cron.hourly/sphinx
#liwl Edited in 2019.4.26
VOLUME ["/usr/local/etc/sphinx", "/var/log/sphinx"]

RUN ln -s /usr/local/etc/sphinx/sphinx.conf /usr/local/etc/csft.conf
RUN mkdir -p /var/sphinx/log/
RUN mkdir -p /var/sphinx/data/

WORKDIR /

EXPOSE 9312


ADD ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]



