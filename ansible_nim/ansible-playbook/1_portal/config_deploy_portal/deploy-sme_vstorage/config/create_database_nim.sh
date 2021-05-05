#!/bin/bash
echo "waiting NIM.."

echo "ceate DB sme_api"
mysql --host localhost -uroot -pT4ygH9lQ3j7kAh2 -AN -e "CREATE DATABASE sme_api CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

echo "ceate DB sme_backup_restore"
mysql --host localhost -uroot -pT4ygH9lQ3j7kAh2 -AN -e "CREATE DATABASE sme_backup_restore CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

echo "execute DATABASE"
mysql --host 127.0.0.1 -uroot -pT4ygH9lQ3j7kAh2 sme_api < /home/sme_api_nim.sql
mysql --host 127.0.0.1 -uroot -pT4ygH9lQ3j7kAh2 sme_backup_restore < /home/sme_backup_restore.sql

echo "mysql_native_password for root"
mysql --host localhost -uroot -pT4ygH9lQ3j7kAh2 -AN -e "ALTER USER 'root'@'localhost'IDENTIFIED WITH mysql_native_password BY 'T4ygH9lQ3j7kAh2';"
mysql --host localhost -uroot -pT4ygH9lQ3j7kAh2 -AN -e "ALTER USER 'root'@'%'IDENTIFIED WITH mysql_native_password BY 'T4ygH9lQ3j7kAh2';"
