#!/bin/bash

echo " mongoDB Database Backing UP "
file_name="amandb_$(date +"%d-%m-%Y-%T")"
mkdir -p /home/amanpathak/mongoDBBackups/$file_name
mongodump --db DevOps -o /home/amanpathak/mongoDBBackups/$file_name
cd /home/amanpathak/mongoDBBackups
zip -r $file_name.zip $file_name
if [ $? -eq 0 ]
then
	aws s3 cp //home/amanpathak/mongoDBBackups/$file_name.zip s3://devops-aman-s3-bucket/${file_name}.zip
	if [ $? -eq 0 ]
	then
		find /home/amanpathak/mongoDBBackups/ -type f -name "*.zip" -mmin +1 -exec rm -rf {} \;
		sudo find /home/amanpathak/mongoDBBackups/ -type d -name "*" -mmin +1 -exec rm -rf {} \; 
		echo "File Deleted"
	fi
fi
echo "Backup Complete"

