#!/bin/bash

echo "disk usage"

source ./common.sh
echo "hello world"
validate $? "print statement..."
Logs_folder

df -hT  | awk '{print $6}' &>>$Logs_file

