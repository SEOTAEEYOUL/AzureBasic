#!/bin/bash
exec 1> >(logger -s -t $(basename $0)) 2>&1
function shutdown()
{
    date
    echo "Shutting down Tomcat"
    ${CATALINA_HOME}/bin/catalina.sh stop
}

# Allow any signal which would kill a process to stop Tomcat
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP

if [ ! -f ${CATALINA_HOME}/scripts/.tomcat_admin_created ]; then
        ${CATALINA_HOME}/scripts/create_admin_user.sh
fi

# export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-2.el7_6.x86_64
# export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-0.el7_6.x86_64

date
echo "Starting Tomcat"
export CATALINA_PID=/tmp/$$

echo ""
echo ""
echo ""
cat ${CATALINA_HOME}/bin/catalina.sh
echo ""
echo ""
echo ""
exec ${CATALINA_HOME}/bin/catalina.sh run

echo "Waiting for `cat $CATALINA_PID`"
wait `cat $CATALINA_PID
