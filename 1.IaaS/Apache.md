# Apache

## Ubuntu 에서 아파치 웹서버 설치하기
## Apache 설치
1. sudo apt-get install apache2
```powershell
azureuser@vm-skcc-comdpt1:~$ sudo apt-get install apache2
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  apache2-bin apache2-data apache2-utils libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap liblua5.2-0
  ssl-cert
Suggested packages:
  www-browser apache2-doc apache2-suexec-pristine | apache2-suexec-custom openssl-blacklist
The following NEW packages will be installed:
  apache2 apache2-bin apache2-data apache2-utils libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap
  liblua5.2-0 ssl-cert
0 upgraded, 10 newly installed, 0 to remove and 4 not upgraded.
Need to get 1729 kB of archives.
After this operation, 6997 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 http://azure.archive.ubuntu.com/ubuntu bionic/main amd64 libapr1 amd64 1.6.3-2 [90.9 kB]
Get:2 http://azure.archive.ubuntu.com/ubuntu bionic/main amd64 libaprutil1 amd64 1.6.1-2 [84.4 kB]
Get:3 http://azure.archive.ubuntu.com/ubuntu bionic/main amd64 libaprutil1-dbd-sqlite3 amd64 1.6.1-2 [10.6 kB]
Get:4 http://azure.archive.ubuntu.com/ubuntu bionic/main amd64 libaprutil1-ldap amd64 1.6.1-2 [8764 B]
Get:5 http://azure.archive.ubuntu.com/ubuntu bionic/main amd64 liblua5.2-0 amd64 5.2.4-1.1build1 [108 kB]
Get:6 http://azure.archive.ubuntu.com/ubuntu bionic-updates/main amd64 apache2-bin amd64 2.4.29-1ubuntu4.21 [1070 kB]
Get:7 http://azure.archive.ubuntu.com/ubuntu bionic-updates/main amd64 apache2-utils amd64 2.4.29-1ubuntu4.21 [83.8 kB]
Get:8 http://azure.archive.ubuntu.com/ubuntu bionic-updates/main amd64 apache2-data all 2.4.29-1ubuntu4.21 [160 kB]
Get:9 http://azure.archive.ubuntu.com/ubuntu bionic-updates/main amd64 apache2 amd64 2.4.29-1ubuntu4.21 [95.1 kB]
Get:10 http://azure.archive.ubuntu.com/ubuntu bionic/main amd64 ssl-cert all 1.0.39 [17.0 kB]
Fetched 1729 kB in 2s (879 kB/s)
Preconfiguring packages ...
Selecting previously unselected package libapr1:amd64.
(Reading database ... 85977 files and directories currently installed.)
Preparing to unpack .../0-libapr1_1.6.3-2_amd64.deb ...
Unpacking libapr1:amd64 (1.6.3-2) ...
Selecting previously unselected package libaprutil1:amd64.
Preparing to unpack .../1-libaprutil1_1.6.1-2_amd64.deb ...
Unpacking libaprutil1:amd64 (1.6.1-2) ...
Selecting previously unselected package libaprutil1-dbd-sqlite3:amd64.
Preparing to unpack .../2-libaprutil1-dbd-sqlite3_1.6.1-2_amd64.deb ...
Unpacking libaprutil1-dbd-sqlite3:amd64 (1.6.1-2) ...
Selecting previously unselected package libaprutil1-ldap:amd64.
Preparing to unpack .../3-libaprutil1-ldap_1.6.1-2_amd64.deb ...
Unpacking libaprutil1-ldap:amd64 (1.6.1-2) ...
Selecting previously unselected package liblua5.2-0:amd64.
Preparing to unpack .../4-liblua5.2-0_5.2.4-1.1build1_amd64.deb ...
Unpacking liblua5.2-0:amd64 (5.2.4-1.1build1) ...
Selecting previously unselected package apache2-bin.
Preparing to unpack .../5-apache2-bin_2.4.29-1ubuntu4.21_amd64.deb ...
Unpacking apache2-bin (2.4.29-1ubuntu4.21) ...
Selecting previously unselected package apache2-utils.
Preparing to unpack .../6-apache2-utils_2.4.29-1ubuntu4.21_amd64.deb ...
Unpacking apache2-utils (2.4.29-1ubuntu4.21) ...
Selecting previously unselected package apache2-data.
Preparing to unpack .../7-apache2-data_2.4.29-1ubuntu4.21_all.deb ...
Unpacking apache2-data (2.4.29-1ubuntu4.21) ...
Selecting previously unselected package apache2.
Preparing to unpack .../8-apache2_2.4.29-1ubuntu4.21_amd64.deb ...
Unpacking apache2 (2.4.29-1ubuntu4.21) ...
Selecting previously unselected package ssl-cert.
Preparing to unpack .../9-ssl-cert_1.0.39_all.deb ...
Unpacking ssl-cert (1.0.39) ...
Setting up libapr1:amd64 (1.6.3-2) ...
Setting up apache2-data (2.4.29-1ubuntu4.21) ...
Setting up ssl-cert (1.0.39) ...
Setting up libaprutil1:amd64 (1.6.1-2) ...
Setting up liblua5.2-0:amd64 (5.2.4-1.1build1) ...
Setting up libaprutil1-ldap:amd64 (1.6.1-2) ...
Setting up libaprutil1-dbd-sqlite3:amd64 (1.6.1-2) ...
Setting up apache2-utils (2.4.29-1ubuntu4.21) ...
Setting up apache2-bin (2.4.29-1ubuntu4.21) ...
Setting up apache2 (2.4.29-1ubuntu4.21) ...
Enabling module mpm_event.
Enabling module authz_core.
Enabling module authz_host.
Enabling module authn_core.
Enabling module auth_basic.
Enabling module access_compat.
Enabling module authn_file.
Enabling module authz_user.
Enabling module alias.
Enabling module dir.
Enabling module autoindex.
Enabling module env.
Enabling module mime.
Enabling module negotiation.
Enabling module setenvif.
Enabling module filter.
Enabling module deflate.
Enabling module status.
Enabling module reqtimeout.
Enabling conf charset.
Enabling conf localized-error-pages.
Enabling conf other-vhosts-access-log.
Enabling conf security.
Enabling conf serve-cgi-bin.
Enabling site 000-default.
Created symlink /etc/systemd/system/multi-user.target.wants/apache2.service → /lib/systemd/system/apache2.service.
Created symlink /etc/systemd/system/multi-user.target.wants/apache-htcacheclean.service → /lib/systemd/system/apache-htcacheclean.service.
Processing triggers for libc-bin (2.27-3ubuntu1.4) ...
Processing triggers for systemd (237-3ubuntu10.53) ...
Processing triggers for man-db (2.8.3-2ubuntu0.1) ...
Processing triggers for ufw (0.36-0ubuntu0.18.04.2) ...
Processing triggers for ureadahead (0.100.0-21) ...
```

### Apache 서버 시작하기  
sudo service apache2 start
1. cd /etc/init.d
```powershell
azureuser@vm-skcc-comdpt1:~$ cd /etc/init.d
azureuser@vm-skcc-comdpt1:/etc/init.d$ dir
acpid                cron              irqbalance         lxcfs           plymouth-log    ufw
apache-htcacheclean  cryptdisks        iscsid             lxd             procps          unattended-upgrades
apache2              cryptdisks-early  keyboard-setup.sh  mdadm           rsync           uuidd
apparmor             dbus              kmod               mdadm-waitidle  rsyslog
apport               ebtables          lvm2               open-iscsi      screen-cleanup
atd                  grub-common       lvm2-lvmetad       open-vm-tools   ssh
console-setup.sh     hwclock.sh        lvm2-lvmpolld      plymouth        udev
```

2. Apache 서버 기동 및 확인
- 기동 : sudo service apache2 start
- 데몬 상태 확인 : sudo service apache2 status
- Listen Port 확인 : netstat -an | grep LISTEN
```powershell
azureuser@vm-skcc-comdpt1:~$ sudo service apache2 start
azureuser@vm-skcc-comdpt1:~$ sudo service apache2 status
● apache2.service - The Apache HTTP Server
   Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
  Drop-In: /lib/systemd/system/apache2.service.d
           └─apache2-systemd.conf
   Active: active (running) since Fri 2022-01-28 06:58:09 UTC; 4min 35s ago
 Main PID: 20117 (apache2)
    Tasks: 55 (limit: 4674)
   CGroup: /system.slice/apache2.service
           ├─20117 /usr/sbin/apache2 -k start
           ├─20123 /usr/sbin/apache2 -k start
           └─20124 /usr/sbin/apache2 -k start

Jan 28 06:58:09 vm-skcc-comdpt1 systemd[1]: Starting The Apache HTTP Server...
Jan 28 06:58:09 vm-skcc-comdpt1 systemd[1]: Started The Apache HTTP Server.
azureuser@vm-skcc-comdpt1:~$ netstat -an | grep LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN
tcp6       0      0 :::22                   :::*                    LISTEN
tcp6       0      0 :::80                   :::*                    LISTEN
unix  2      [ ACC ]     SEQPACKET  LISTENING     14174    /run/udev/control
unix  2      [ ACC ]     STREAM     LISTENING     762324   /run/user/1000/systemd/private
unix  2      [ ACC ]     STREAM     LISTENING     762328   /run/user/1000/gnupg/S.gpg-agent.ssh
unix  2      [ ACC ]     STREAM     LISTENING     762329   /run/user/1000/gnupg/S.gpg-agent
unix  2      [ ACC ]     STREAM     LISTENING     762330   /run/user/1000/gnupg/S.dirmngr
unix  2      [ ACC ]     STREAM     LISTENING     762331   /run/user/1000/gnupg/S.gpg-agent.browser
unix  2      [ ACC ]     STREAM     LISTENING     762332   /run/user/1000/gnupg/S.gpg-agent.extra
unix  2      [ ACC ]     STREAM     LISTENING     762333   /run/user/1000/snapd-session-agent.socket
unix  2      [ ACC ]     STREAM     LISTENING     19336    /var/lib/lxd/unix.socket
unix  2      [ ACC ]     STREAM     LISTENING     20512    @irqbalance1168.sock
unix  2      [ ACC ]     STREAM     LISTENING     19338    /run/snapd.socket
unix  2      [ ACC ]     STREAM     LISTENING     19324    /run/uuidd/request
unix  2      [ ACC ]     STREAM     LISTENING     19331    /var/run/dbus/system_bus_socket
unix  2      [ ACC ]     STREAM     LISTENING     19340    /run/snapd-snap.socket
unix  2      [ ACC ]     STREAM     LISTENING     19345    /run/acpid.socket
unix  2      [ ACC ]     STREAM     LISTENING     14167    /run/systemd/private
unix  2      [ ACC ]     STREAM     LISTENING     14172    /run/systemd/fsck.progress
unix  2      [ ACC ]     STREAM     LISTENING     14176    /run/lvm/lvmpolld.socket
unix  2      [ ACC ]     STREAM     LISTENING     14182    /run/systemd/journal/stdout
unix  2      [ ACC ]     STREAM     LISTENING     14191    /run/lvm/lvmetad.socket
unix  2      [ ACC ]     STREAM     LISTENING     19335    @ISCSIADM_ABSTRACT_NAMESPACE
azureuser@vm-skcc-comdpt1:~$
```