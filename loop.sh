#!/bin/bash

echo "if loop"

num=20
num1=22

if [ $num -gt $num1 ]; then
    echo "num is greater than num1"
elif [ $num1 -gt $num ]; then 
    echo "num1 is greater than num"
else
    echo "num1 is eq to num2"
fi

