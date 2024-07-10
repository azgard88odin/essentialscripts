#!/bin/bash

# This script takes a command line argument for the amount of bytes and the unit to convert it to
# This script is for coverting bytes to a human readable format

bytes=$1
unit=$2

if [ "$unit" = "-m"  ]; then
    divisor=1048576
    unit_name="MB"
elif [ "$unit" = "-g" ]; then
    divisor=1073741824
    unit_name="GB"
else
    echo "Invalid unit flag. Use either -m (megabytes) or -g (gigabytes)."
    exit 1
fi

result=$((bytes / divisor))
remainder=$((bytes % divisor))

if [ $remainder -ne 0 ]; then
    result+=".$(printf "%03d" $((remainder * 1000 / divisor)))"
fi

echo "$result $unit_name"
