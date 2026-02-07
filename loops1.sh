#!/bin/bash

echo "for loop"

echo "using for loop to execute multiple commands and making it flexible so it can accept any number of arguments"

User_id=$(id -u)

if [ $User_id -ne 0 ]; then 
    echo "Please get the root access...or if u already have the root access use root user by ...sudo su"
    exit 1
fi

Logs_folder=$("/var/logs/shell-script")
Logs_file=$("/var/logs/shell-script/$0.log")

echo "Creating directory in /var/logs path"

mkdir -p $Logs_folder

validate(){
    if [ $1 -ne 0 ]; then
        echo "$2: Installation falied" | tee -a $Logs_file
    else
        echo "$2: Installation success" | tee -a $Logs_file
    fi
}

for package in $@ | tee -a $Logs_file # it will take all args passed by the user and store each of them in package and iterate
do
    echo "Installing :$package"
    dnf install @package -y &>> $Logs_file
done