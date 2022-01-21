# FROM scratch
# ADD centos-7-docker.tar.x.z
# FROM centos:latest
# FROM centos:7
# FROM centos:7.4.1708
# FROM mtwp.icp.skt.com:8500/infra/nodejs10-utf8:0.0.1

FROM centos:7.6.1810
MAINTAINER taeeyoul <taeeyoul@sk.com>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=8.0.38
USER  root

# USER root
# ENV SHELL /bin/bash
# RUN yum update -y
# RUN yum reinstall glibc-common -y
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
# COPY utf8/locale.conf /etc/locale.conf
# COPY utf8/locales.tgz /
COPY repo/CentOS-Base.repo /etc/yum.repos.d
COPY repo/CentOS-fasttrack.repo /etc/yum.repos.d
# RUN yum-config-manager --disable CentOS-fasttrack
# RUN tar xvfPpz locales.tgz
# RUN localedef -cvi en_US -f EUC-KR en_US; exit 0
# RUN localedef -cvi en_US -f UTF-8 en_US; exit 0
# RUN localedef -v -c -i en_US -f UTF8 en_US.UTF8; exit 0



ENV LANG=en_US.UTF8
ENV LC_ALL=en_US.UTF8
ENV APP nodejs-bot

RUN echo 'LANGUAGE=en_US.UTF8; export LANG' >> /etc/environment && \
    echo 'LANG=en_US.UTF8; export LANG' >> /etc/environment && \
    echo 'LC_ALL=en_US.UTF8; export LC_ALL' >> /etc/environment && \
    echo 'LANG=en_US.UTF8:en_US:ko:en_US.UTF-8:en_US:en' >> /etc/sysconfig/i18n && \
    echo 'SYSFONT=latarcyrheb-sun16' >> /etc/sysconfig/i18n && \
    echo 'LC_CTYPE=en_US.UTF8; export LC_CTYPE' >> /etc/sysconfig/i18n && \
    echo 'LC_MESSAGES=en_US.UTF8; export LC_MESSAGES' >> /etc/sysconfig/i18n && \
    echo 'LANG=en_US.UTF8; export LANG' >> /etc/bashrc && \
    echo 'LC_ALL=en_US.UTF8; export LC_ALL' >> /etc/bashrc && \
    echo 'LANG=en_US.UTF8' > /etc/locale.conf && \
    echo 'LC_ALL=en_US.UTF8; export LC_ALL' >> /etc/profile && \
    echo 'LANG=en_US.UTF8' > /etc/profile && \
    echo 'DOCKER_CONTAINER_TRUST=1; export DOCKER_CONTAINER_TRUST' > /etc/bash && \
    echo 'DOCKER_CONTAINER_TRUST=1; export DOCKER_CONTAINER_TRUST' > /etc/profile

# SHELL ["/bin/bash", "-c"]
RUN sed -i 's/^PASS_MIN_LEN.*/PASS_MIN_LEN 9/g' /etc/login.defs && \
    sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 70/g' /etc/login.defs && \
    sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 7/g' /etc/login.defs
RUN userdel lp
RUN echo "umask 022" >> /etc/profile; \
    chmod u-s /sbin/unix_chkpwd; \
    chmod u-s /usr/bin/newgrp; \
    touch /etc/hosts.equiv; \
    chown root /etc/hosts.equiv; \
    chmod 000 /etc/hosts.equiv; \
    touch /root/.rhosts; \
    chown root /root/.rhosts; \
    chmod 000 /root/.rhosts; \
    echo "# This system is for the use of authorized users only. #" >> /etc/issue; \
    echo "export TMOUT=3600" >> /etc/profile

RUN find / -perm +6000 -type f -exec chmod a-s {} \; || true

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

RUN mkdir -p /home/nodejs ; \
    mkdir -p /home/appadmin ; \
    groupadd -g 1004 nodejs ; \
    useradd -d /home/nodejs -m -s /bin/bash -u 1004 -g 1004 nodejs
COPY ./scripts/bash_profile /root/.bash_profile
COPY ./scripts/bash_profile /home/nodejs/.bash_profile

COPY ./scripts/netstat  /usr/local/bin
COPY ./scripts/nslookup /usr/local/bin
COPY ./scripts/kubectl  /usr/local/bin
RUN  chmod +777 /usr/local/bin/netstat && \
     chmod +777 /usr/local/bin/nslookup && \
     chmod +777 /usr/local/bin/kubectl && \
     chown -R nodejs:nodejs /home/nodejs

# Update and install latest packages and prerequisites
# RUN yum -y update && yum clean all && yum -y install wget which

RUN yum erase nodejs -y && \
    curl --silent --location https://rpm.nodesource.com/setup_14.x | bash - && \
    yum -y install nodejs npm && \
    yum -y install wget which && \
    yum clean all

WORKDIR /home/appadmin

COPY package*.json ./
RUN npm install && npm cache clean --force

COPY nodejs-exporter.js ./
COPY logger.js ./
COPY redis-ha.js ./
COPY server.js ./
# COPY . .
EXPOSE 8080

CMD [ "npm", "start" ]
