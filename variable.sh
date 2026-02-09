#!/bin/bash

echo "Reusing the code by calling another file by sh"

A=12
B=100

Tot=$(("$A+$B"))

echo "The tot is: $Tot"
echo $$