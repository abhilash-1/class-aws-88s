#!/bin/bash

echo "common functions or methods"

validate() {
    if [ $1 -ne 0 ]; then 
        echo "$2.....Failed"
    else
        echo "$2.....Success"
    fi
}

User_id(){
    UserId=$(id -u)
    if [ $UserId -ne 0 ]; then
        echo "you are not a root user, please login as root user to make this changes"
    else
        echo "you are a root user ....please continue.."
    fi
}

LogsFileCreation(){
    Logs_folder="/var/log/shell-script"
    Logs_file="$Logs_folder/$0.log"

    echo "Creating Logs Folder"
    mkdir -p Logs_folder
    validate $? "Logs folder creation successful"
}