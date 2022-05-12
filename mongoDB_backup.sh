#!/bin/bash

echo " mongoDB Database Backing UP "
file_name="amandb_$(date +"%d-%m-%Y-%T")"
mongodump --authenticationDatabase admin -u aman -paman@123 --db Aman --out /home/amanpathak/mongodb_backups/$file_name
cd /home/amanpathak/mongodb_backups
zip -r $file_name.zip $file_name
if [ $? -eq 0 ]
then
	aws s3 cp //home/amanpathak/mongodb_backups/$file_name.zip s3://devops-aman-s3-bucket/${file_name}.zip
	if [ $? -eq 0 ]
	then
		find /home/amanpathak/mongodb_backups/ -type f -name "*.zip" -mmin +1 -exec rm -rf {} \;
		sudo find /home/amanpathak/mongodb_backups/ -type d -name "*" -mmin +1 -exec rm -rf {} \; 
		echo "File Deleted"
	fi
fi
echo "Backup Complete"

