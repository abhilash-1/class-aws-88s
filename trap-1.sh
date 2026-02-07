#!/bin/bash

set -e

R='\e[31m'
G='\e[32m'
Y='\e[33m'

echo "$Y for loop"

echo "$R using for loop to execute multiple commands and $G making it flexible so it can accept any number of arguments"

User_id=$(id -u)

if [ $User_id -ne 0 ]; then 
    echo -e "$Y Please get the root access...or if u already have the root access use root user by ...sudo su"
    exit 1
fi


Logs_folder="/var/log/shell-script"
Logs_file="/var/log/shell-script/"$0".log"

echo -e "$Y Creating directory in /var/logs path"

mkdir -p "$Logs_folder"

trap ' echo "There is an error at line number $LINENO, and command: $BASH_COMMAND" | tee -a "Logs_file" ' ERR

validate(){
    set +e
    if [ $1 -ne 0 ]; then
        
        echo -e "$R $2: Installation falied" | tee -a $Logs_file
    else
        echo -e "$G $2: Installation success" | tee -a $Logs_file
    fi
    set -e
}

for package in "$@" # it will take all args passed by the user and store each of them in package and iterate
do
    echo -e "$G Installing :$package"
    dnf install $package -y &>> $Logs_file
    validate $? "$package"
done