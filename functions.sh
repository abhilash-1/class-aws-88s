#!/bin/bash

echo "Functions in shell scripting"

validate(){
    if [ $1 -ne 0 ]; then
        echo "$2: installation failed"
        exit 1
    else 
        echo "$2: installation successfull"
    fi

}

dnf install nginx -y
validate $? "Nginx"
dnf install nodejs -y
validate $? "Nodejs"
dnf install redis -y
validate $? "Redis"