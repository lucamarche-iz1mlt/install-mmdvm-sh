#!/bin/bash
N_CPU=$(grep -e "processor" /proc/cpuinfo | tail --lines 1 | cut -f 2 -d" ")
if [ $N_CPU = "0" ]; then
	echo "1"
elif [ $N_CPU = "1" ]; then
        echo "2"
elif [ $N_CPU = "2" ]; then
        echo "3"
elif [ $N_CPU = "3" ]; then
        echo "4"
elif [ $N_CPU = "4" ]; then
        echo "5"
elif [ $N_CPU = "5" ]; then
        echo "6"
elif [ $N_CPU = "6" ]; then
        echo "7"
elif [ $N_CPU = "7" ]; then
        echo "8"
elif [ $N_CPU = "8" ]; then
        echo "9"
elif [ $N_CPU = "9" ]; then
        echo "10"
elif [ $N_CPU = "10" ]; then
        echo "11"
fi
exit
testo da inserire nel file
