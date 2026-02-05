#!/bin/bash

echo "If loop"

dnf install nginx -y

User_id = $(id -u)


if [ $User_id -ne 0 ]; then
    echo " you are not a root user, please proceed with sudo access"
    exit 1
fi

echo "installing nginx"
dnf install nginx -y

if [ $? -ne 0 ]; then
    echo "Instllation failed...nginx"
    exit 1
else
    echo "Installation Success..nginx"