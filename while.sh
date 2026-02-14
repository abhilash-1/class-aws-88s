#!/bin/bash

echo "while loop reading from output of cmd"

Logs_folder="/var/log/shell-script"
Logs_file="$Logs_folder/$0.log"
app_logs="/home/ec2-user/app-logs"

source ./common.sh

echo "Creating Logs folder"
mkdir -p $Logs_folder
validate $? "Cration of logs folder"

Files_del=$(find "$app_logs" -name "*.log" -mtime +14)
if [ -z $Files_del ]; then
    echo "There are no files older than 14 days....so skipping"
    exit 1
fi
while IFS= read -r filepath; do
    echo "Reading files which are older than 14 days"
    rm -rf $filepath
    echo "deleted the $filepath"
done <<<$Files_del

