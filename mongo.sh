#!/bin/bash

echo "Installing an application in this server to set up DB"

User_id=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
Logs_folder="/var/logs/shell-script"
Logs_file="$Logs_folder/$0.log"


if [ $User_id -ne 0 ]; then
    echo -e " $R please get sudo/root access to make changes here....if u laready have access use "sudo su" to get into root directory"
    exit 1
else
    echo -e " $G You are in root directory or you have sudo access...so proceed forward"
fi

validate(){
    if [ $1 -ne 0 ]; then
        echo -e " $R $2: .....FAILED"
        exit 1
    else
        echo -e "$G $2:....SUCCESS"
    fi
}

echo "Creating Logs_folder in /var/logs/"
mkdir -p "$Logs_folder"
validate $? "Folder Creation"

for package in "$@"
do
    echo "Checking if there are any parameters passed"
    if [ $# -eq 0 ]; then 
        echo "you must pass the package name as parameters here when u are executing the file"
        exit 1
    fi
    echo "Installing $package"
    echo "Before Installing we are checking if its already installed or not"
    dnf list installed $package -y &>>$Logs_file
    if [ $? -eq 0 ]; then
        echo -e "$Y The $package is already installed so...skipping it..."
        continue
    else
        echo -e " $Y The $package is not installed so..installing it"
        dnf install "$package" -y &>>$Logs_file
        validate $? "$package Installation"
    fi

done