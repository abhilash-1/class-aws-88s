#!/bin/bash

source ./common.sh

R="\[e31m"
G="\[e32m"
Y="\[e33m"


source="/home/ec2-user/app-logs"
destination="/var/log/backup"

echo -e " $Y moving the files from $source to $destination"

LogsFileCreation
User_id

echo -e "$Y Finding the files older than 14 days, and zipping them and moving to new location"

Files_del=$(find $source -name "*.log" -mtime +14) 
if [ -z "$Files_del" ]; then
    echo -e " $R There are no files older than 14 days...So skipping"
else
    while IFS= read -r filepath; do
        echo -e " $Y Reading the filepath of logs : $filepath "
        echo -e " $G Moving the file path to destination : $destination "
        mv $filepath $destination &>>$Logs_file 
        validate $? "The migration of older log files is....."
        echo -e " $G The new path of older log files: $destination"
    done <<<$Files_del
fi
