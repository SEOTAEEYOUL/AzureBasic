# Springboot MySQL Sample

## Azure MySQL 접속 
- 서버 이름 : mysql-homepage.mysql.database.azure.com
- 서버 관리자 로그인 이름 : mysql@mysql-homepage
- MySQL 버전 : 5.7

### 접속
```
mysql -h mysql-homepage.mysql.database.azure.com 
  -u mysql@mysql-homepage -p
```

### DB 만들기
```
create database tutorial default character set utf8;
```

### 사용자 만들기
```
create user 'tutorial'@'localhost' identified by 'tutorial';
```

### 권한 주기
```
grant all privileges on tutorial.* to 'tutorial'@'localhost';
```

### Table 만들기
```
CREATE TABLE IF NOT EXISTS TUTORIAL.BOOKS
(
  SeqNo INT NOT NULL AUTO_INCREMENT,
  Title VARCHAR(20) NOT NULL,
  Author VARCHAR(20) NOT NULL,
  Price DOUBLE NOT NULL DEFAULT 0,
  published_date DATE NOT NULL,
  PRIMARY KEY(SeqNo)
);
```

### 데이터 넣기
```
insert into books (Title, Author, Price, published_date)
values ('TCP/IP 완벽 가이드', '강유,김혁진,...', 45000, '2021-12-01');
insert into books (Title, Author, Price, published_date)
values ('NGINX Cookbook', '데릭 디용기', 20000, '2021-06-01');
insert into books (Title, Author, Price, published_date)
values ('Learning CoreDNS', '존 벨라마릭,크리켓 리우', 25000, '2021-08-31');

insert into books (Title, Author, Price, published_date) values
 ('TCP/IP 완벽 가이드', '강유,김혁진,...', 45000, '2021-12-01'),
 ('NGINX Cookbook', '데릭 디용기', 20000, '2021-06-01'),
 ('Learning CoreDNS', '존 벨라마릭,크리켓 리우', 25000, '2021-08-31');
```

### 실행 예
```
azureuser@vm-skcc1-comdap1:~$ mysql -h mysql-homepage.mysql.database.azure.com -u mysql@mysql-homepage -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 64703
Server version: 5.6.47.0 MySQL Community Server (GPL)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.01 sec)

mysql> use mysql
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

selDatabase changed
mysql> select version( );
+------------+
| version( ) |
+------------+
| 5.7.32-log |
+------------+
1 row in set (0.00 sec)

mysql> create database tutorial default character set utf8;
Query OK, 1 row affected (0.04 sec)

mysql> show databases ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| tutorial           |
+--------------------+
5 rows in set (0.04 sec)

mysql> create user 'tutorial'@'localhost' identified by 'tutorial';
Query OK, 0 rows affected (0.02 sec)

mysql> grant all privileges on tutorial.* to 'tutorial'@'localhost';
Query OK, 0 rows affected, 1 warning (0.02 sec)

mysql> use tutorial
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables ;
+--------------------+
| Tables_in_tutorial |
+--------------------+
| books              |
+--------------------+
1 row in set (0.00 sec)

mysql> insert into books (Title, Author, Price, published_date) values
    ->  ('TCP/IP 완벽 가이드', '강유,김혁진,...', 45000, '2021-12-01'),
    ->  ('NGINX Cookbook', '데릭 디용기', 20000, '2021-06-01'),
    ->  ('Learning CoreDNS', '존 벨라마릭,크리켓 리우', 25000, '2021-08-31');
Query OK, 3 rows affected (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from books ;
+-------+-------------------------+-----------------------------------+-------+----------------+
| SeqNo | Title                   | Author                            | Price | published_date |
+-------+-------------------------+-----------------------------------+-------+----------------+
|     1 | TCP/IP 완벽 가이드      | 강유,김혁진,...                   | 45000 | 2021-12-01     |
|     2 | NGINX Cookbook          | 데릭 디용기                       | 20000 | 2021-06-01     |
|     3 | Learning CoreDNS        | 존 벨라마릭,크리켓 리우           | 25000 | 2021-08-31     |
+-------+-------------------------+-----------------------------------+-------+----------------+
3 rows in set (0.00 sec)

mysql> exit
Bye
azureuser@vm-skcc1-comdap1:~$
```