#!/bin/bash

echo "IFS working and read -r working"

Debug_path="/var/debug/path/ files"
path="/var/logs/shell-script/ logs.log"

pwd
if [ IFS= read -r filepath -eq path ]; then
    echo "they are same"
fi