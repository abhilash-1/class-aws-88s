#!/bin/bash

echo "while loop reading from output of cmd"

Logs_folder="/var/log/shell-script"
Logs_file="$Logs_folder/$0.log"
app_logs="/home/ec2-user/app-logs"

R="\e[31m"
G="\e[32m"
Y="\e[33m"

source ./common.sh

echo -e "$Y Creating Logs folder"
mkdir -p $Logs_folder
validate $? "Cration of logs folder"

Files_del=$(find "$app_logs" -name "*.log" -mtime +14)
if [ -z $Files_del ]; then
    echo -e "$R There are no files older than 14 days....$Y so skipping"
    exit 1
else
    while IFS= read -r filepath; do
        echo -e "$Y Reading files which are older than 14 days"
        rm -rf $filepath
        echo -e "$G deleted the $filepath"
    done <<<$Files_del
fi
echo -e "$G deleted all the older files"