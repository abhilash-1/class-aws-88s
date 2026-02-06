#!/bin/bash

echo "creating log file in var/logs location instaed of writing into repo file"

echo "Logs"

Logs_folder="/var/logs/shell-script"
Logs_file="/var/logs/shell-script/$0.log"

mkdir -p $Logs_folder

validate(){
    if [ $1 -ne 0 ]; then
        echo "$2: Installation failed"
    else
        echo "$2: Installation success"
    fi
}

#for package in $@
dnf install nodejs -y &>> Logs_file
validate $? "nodejs"
dnf install redis -y &>> Logs_file
validate $? "redis"
dnf install nginx -y &>> Logs_file
validate $? "nginx"

