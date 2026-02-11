#!/bin/bash

echo "Writing a cmd to delete old files"

Log_folder="/var/logs/shell-script"
Logs_file="$Log_folder/$0.log"

echo "Creating Log folder"
mkdir -p $Log_folder
if [ $? -eq 0 ]; then
    echo "created Log folder successfully"
else
    echo "failed..."
fi


find /var/log/ -type f -mtime +14
if [ $? -eq 0 ]; then
    echo "deleting the old log files"
    find /var/log/ -name "*.log" -type f -mtime +14 -delete
    if [ $? -eq 0]; then
        echo "deleted the old log files"
    else
        echo "No old log files are there"

    fi
else
    echo "Cannot delete the log files"
fi

