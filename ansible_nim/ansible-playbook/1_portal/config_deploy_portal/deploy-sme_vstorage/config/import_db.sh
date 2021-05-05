#!/bin/bash
echo "Import Database";
mysql --host vip_master_nim -uroot -pT4ygH9lQ3j7kAh2 sme_api < /home/auto_deploy_portal/deploy-sme_vstorage/config/sme_api_nim.sql;
echo "Import Database";
mysql --host vip_master_nim -uroot -pT4ygH9lQ3j7kAh2 sme_backup_restore < /home/auto_deploy_portal/deploy-sme_vstorage/config/sme_backup_restore_nim.sql;