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

echo "Checking if there are any parameters passed"
    if [ $# -eq 0 ]; then 
        echo -e " $R you must pass the package name as parameters here when u are executing the file"
        exit 1
    fi

validate(){
    if [ $1 -ne 0 ]; then
        echo -e " $R $2: .....FAILED" | tee -a $Logs_file
        exit 1
    else
        echo -e "$G $2:....SUCCESS" | tee -a $Logs_file
    fi
}

echo "Creating Logs_folder in /var/logs/"
mkdir -p "$Logs_folder"
validate $? "Folder Creation"

#Creating .service file here
echo "Creating the Service files"
cp catalogue.service /etc/systemd/system/catalogue.service
validate $? "updated the config file"


for package in "$@"
do
    echo "Installing $package"


    echo "We are disabling the default $package version"
    dnf module disable $package -y &>>$Logs_file
    validate $? "Disabling default module"

    echo "We are enabling the nodejs:20 version"
    dnf module enable nodejs:20 -y
    validate $? "Enabling the fixed version for $package "

    echo "Before Installing we are checking if its already installed or not"
    dnf list installed "$package" -y &>>$Logs_file
    if [ $? -eq 0 ]; then
        echo -e "$Y The $package is already installed so...skipping it..."
        continue
    else
        echo -e " $Y The $package is not installed so..installing it"
        dnf install "$package" -y &>>$Logs_file
        validate $? "$package Installation"
        if [ $? -eq 0 ]; then
            echo "Installing all the required dependencies"
            #app_setup
            #User creation
            useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
            validate $? "User Creation"

            #creating app directory and unzip and storing it in app folder
            mkdir -p /app &>>$Logs_file
            validate $? "Craeted app directory"

            #unzip from the link and storing in app
            curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
            cd /app &>>$Logs_file
            validate $? "In App directory"

            rm -rf /app/*
            validate $? "Removing existing code"

            unzip /tmp/catalogue.zip &>>$Logs_file
            validate $? "Unzip"

            npm install &>>$Logs_file
            validate $? "Dependencies installation"

            echo "Starting the $package server using SYSTEMCTL"
            systemctl start mongod &>>$Logs_file
            validate $? "Started the server"

            systemctl enable mongod &>>$Logs_file
            validate $? "enabled the server"

            systemctl status mongod &>>$Logs_file
            validate $? "The status of the server is"
        else
            echo -e "$R There is an issue with installation...or while installing the appliaction" | tee -a $Logs_file
            exit 1
        fi

    fi

done



