#!/bin/bash

echo " Taking Database "
day="$(date +"%d-%m-%Y-%T")"
aman_db=aman-my-db_${day}.sql
echo "------------------------------------------------------------------------------------------------"
echo "####################################Taking Database Backup of "${day}"##########################"
sudo mysqldump -u $username -p$password DevOps > /home/amanpathak/SQLBackups/"${aman_db}"
if [ $? -eq 0 ]
then
        aws s3 cp /home/amanpathak/SQLBackups/${aman_db} s3://devops-backup-mysql-aman-bucket/${aman_db}

	if [ $? -eq 0 ]
        then
                find /home/amanpathak/SQLBackups/  -type f -name "*.sql" -mmin +1 -exec rm -rf {} \;

        fi
fi

