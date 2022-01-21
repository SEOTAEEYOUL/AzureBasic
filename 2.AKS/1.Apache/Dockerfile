FROM tosp.icp.skt.com:8500/infra/openjdk8-utf8:0.1
ENV container docker
USER root
# ENV SHELL /bin/bash
# COPY
# ADD
# RUN
# CMD
RUN groupadd webwas
RUN useradd webwas -g webwas
ADD apache.tar.gz /
ADD data.tar.gz /
ADD workers.properties ../mw/software/apache/servers/node11/conf/extra/workers.properties
ADD start_apache.sh /software/apache/servers/node11/shl/start_apache.sh
RUN chmod +x /software/apache/servers/node11/shl/start_apache.sh
# RUN yum update -y
# RUN yum reinstall glibc-common -y
# RUN yum-config-manager --disable CentOS-fasttrack
# RUN localedef -v -c -i ko_KR -f UTF8 ko_KR.UTF8; exit 0
# USER mtw
# WORKDIR /home/ptw
CMD [ "/software/apache/servers/node11/shl/start_apache.sh" ]
