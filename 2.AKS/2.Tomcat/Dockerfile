FROM tosp.icp.skt.com:8500/infra/openjdk8-utf8:0.1
ENV container docker
USER root
# ENV SHELL /bin/bash
# COPY
# ADD
# RUN
# CMD
RUN groupadd webwas
RUN useradd webwas -g webwas -u 1004
ADD tomcat.tar.gz /
ADD data.tar.gz /
ADD tomcat-ReportingServer11.env /software/tomcat/servers/ReportingServer11/shl/tomcat.env
RUN chown webwas.webwas /software/tomcat/servers/ReportingServer11/shl/tomcat.env
ADD tomcat-Container11.env /software/tomcat/servers/Container11/shl/tomcat.env
RUN chown webwas.webwas /software/tomcat/servers/Container11/shl/tomcat.env
ADD ROOT.xml /software/tomcat/servers/Container11/conf/Catalina/localhost/ROOT.xml
RUN chown webwas.webwas /software/tomcat/servers/Container11/conf/Catalina/localhost/ROOT.xml
ADD configuration.properties /data/daisy/WEB-INF/classes/META-INF/properties/configuration.properties
ADD start_tomcat.sh /software/tomcat/servers/Container11/shl/start_tomcat.sh
RUN chmod a+x /software/tomcat/servers/Container11/shl/start_tomcat.sh
# RUN yum update -y
# RUN yum reinstall glibc-common -y
# RUN yum-config-manager --disable CentOS-fasttrack
# RUN localedef -v -c -i ko_KR -f UTF8 ko_KR.UTF8; exit 0
USER webwas
# WORKDIR /home/ptw
CMD [ "/software/tomcat/servers/Container11/shl/start_tomcat.sh" ]