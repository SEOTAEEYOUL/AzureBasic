FROM openjdk:8-jdk-alpine
# RUN apk --no-cache add curl
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# ENTRYPOINT ["java","-jar","/app.jar"]

ARG WAR_FILE=target/*.war
ARG APP_NAME=app
ARG DEPENDENCY=target/classes

RUN mkdir -p /home/spring
# RUN mkdir -p /gclog
WORKDIR /home/spring

COPY ${WAR_FILE} /home/spring/app.war
COPY jmx_prometheus.yml /home/spring/jmx_prometheus.yml
COPY jmx_prometheus_javaagent-0.13.1-SNAPSHOT.jar /home/spring/jmx_prometheus_javaagent.jar

EXPOSE 8088
# COPY ${DEPENDENCY}/BOOT-INF/lib /home/spring/${APP_NAME}/lib
# COPY ${DEPENDENCY}/META-INF /home/spring/app/META-INF
# COPY ${DEPENDENCY}/BOOT-INF/classes /home/spring/${APP_NAME}
# ENV PROFILE=local

# ENTRYPOINT ["java","-cp","app:app/lib/*","hello.Application"]
# ENTRYPOINT ["java","-cp","app:app/lib/*", "-Djava.security.egd=file:/dev/./urandom", "-Dspring.profiles.active=${PROFILE}","org.springframework.boot.loader.JarLauncher"]
#		-javaagent:`ls /whatap/whatap.agent.tracer-*.jar | sort | tail -1`
#		-javaagent:/prometheus/jmx_prometheus_javaagent-0.3.1.jar=8090:/prometheus/jmx_prometheus.yml
#		-Dwhatap.name=$HOSTNAME
#               -Dmtrace_spec=${VERSION}

ENTRYPOINT java -cp app:app/lib/* -Xms512m -Xmx512m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:MaxMetaspaceSize=128m -XX:MetaspaceSize=128m -XX:ParallelGCThreads=3 \
		-XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintHeapAtGC -Xloggc:/gclog/gc_${HOSTNAME}_$(date +%Y%m%d%H%M%S).log -Dgclog_file=/gclog/gc_${HOSTNAME}_$(date +%Y%m%d%H%M%S).log \
		-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/gclog/${HOSTNAME}.log \
		-javaagent:/home/spring/jmx_prometheus_javaagent.jar=8090:/home/spring/jmx_prometheus.yml \
		-Djava.security.egd=file:/dev/./urandom -jar /home/spring/app.war

# ENTRYPOINT ["java","-cp","app:app/lib/*","-jar","/home/spring/app.war"]