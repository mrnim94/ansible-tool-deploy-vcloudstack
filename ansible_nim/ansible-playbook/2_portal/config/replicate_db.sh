#!/bin/bash

echo "stopping slave in MYSQL-01"
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "stop slave;";
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "reset slave all;";


echo "stopping slave in MYSQL-02"
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "stop slave;";
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "reset slave all;";


echo "creating replication user in MYSQL-01"
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "create user 'replicator'@'%' identified by 'Nim@DepTrai';";
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "grant replication slave on *.* to 'replicator'@'%';";
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "ALTER USER 'replicator'@'%'IDENTIFIED WITH mysql_native_password BY 'Nim@DepTrai';";
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "flush privileges;";

echo "creating replication user in MYSQL-02"
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "create user 'replicator'@'%' identified by 'Nim@DepTrai';";
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "grant replication slave on *.* to 'replicator'@'%';";
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "ALTER USER 'replicator'@'%'IDENTIFIED WITH mysql_native_password BY 'Nim@DepTrai';";
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "flush privileges;";

echo "getting MASTER MYSQL-01 config"
Master_Position_Mysql01="$(mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -e 'show master status \G' | grep Position | grep -o '[0-9]*')";
Master_File_Mysql01="$(mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -e 'show master status \G' | grep File | sed -n -e 's/^.*: //p')";

echo "getting MASTER MYSQL-02 config"
Master_Position_Mysql02="$(mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -e 'show master status \G' | grep Position | grep -o '[0-9]*')";
Master_File_Mysql02="$(mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -e 'show master status \G' | grep File | sed -n -e 's/^.*: //p')";

echo "set SLAVE MYSQL-01 to upstream MASTER MYSQL-02"
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "change master to master_host='ip_backup_nim',master_user='replicator',master_password='Nim@DepTrai',master_log_file='$Master_File_Mysql02',master_log_pos=$Master_Position_Mysql02;";

echo "set SLAVE MYSQL-02 to upstream MASTER MYSQL-01"
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "change master to master_host='ip_master_nim',master_user='replicator',master_password='Nim@DepTrai',master_log_file='$Master_File_Mysql01',master_log_pos=$Master_Position_Mysql01;";

echo "Repair MySQL Replication MYSQL-01"
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1;";

echo "Repair MySQL Replication MYSQL-02"
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1;";

echo "start sync: MYSQL-01"
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "start slave;"
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -e "SELECT SLEEP(5);"
mysql --host ip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -e "show slave status \G;"

echo "start sync: MYSQL-02"
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "start slave;"
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -e "SELECT SLEEP(5);"
mysql --host ip_backup_nim -uroot -pT4ygH9lQ3j7kAh2 -e "show slave status \G;"
