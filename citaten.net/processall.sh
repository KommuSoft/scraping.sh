#!/bin/bash
frm=0
tom=29
while true
do
	echo "Retrieving $frm-$tom..."
	bash processpage.sh "$frm" "$tom" >> retrieved.dat
	frm=$(($frm+30))
	tom=$(($tom+30))
	sleep 1
done
