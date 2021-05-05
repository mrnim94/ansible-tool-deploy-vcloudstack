#!/bin/bash
echo "Import Database";
mysql --host vip_master_nim -uroot -pT4ygH9lQ3j7kAh2 sme_api < /home/auto_deploy_2portal/deploy-sme_vstorage/config/sme_api_nim.sql;
echo "Import Database";
mysql --host vip_master_nim -uroot -pT4ygH9lQ3j7kAh2 sme_backup_restore < /home/auto_deploy_2portal/deploy-sme_vstorage/config/sme_backup_restore_nim.sql;

echo "Skipping an Error"
mysql --host vip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "STOP SLAVE;"
mysql --host vip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -e "SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1;"
mysql --host vip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -AN -e "START SLAVE;"
mysql --host vip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -e "SELECT SLEEP(5);"
mysql --host vip_master_nim -uroot -pT4ygH9lQ3j7kAh2 -e "SHOW SLAVE STATUS\G"
