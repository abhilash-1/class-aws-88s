#!/bin/bash

Fruits=("orange" "apple" "anjeer")
echo "all fruits: ${Fruits[@]}"
echo "1 fruit: ${Fruits[0]}"
echo "2 fruit: ${Fruits[1]}"
echo "PID: $$"
echo "Home: $Home"
echo "current user: $user"
echo "all args passing: $@"
echo "Present which directory you are in: $PWD"
sleep 100 &
echo "Background process id: $!"
echo "Exit status of previous command: $?"

num1=10
num2=100

sum=$(($num1+$num2))

echo "sum is : $sum"
