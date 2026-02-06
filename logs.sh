#!/bin/bash

echo "logs"

validate(){
    if [ $1 -ne 0 ]; then
        echo "$2: Installation failed dudeee"
        exit 1
    else
        echo "$2: Installation Successful dudee"
    fi
}

dnf install nginx -y &>> logging.txt
validate $? "ngnix"
dnf install python -y &>> logging.txt
validate $? "python"
