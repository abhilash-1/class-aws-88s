#!/bin/bash

echo "disk usage"

echo "hello world"
validate $? "print statement..."
Logs_folder

df -ht  | awk print{$6} &>>$Logs_file

