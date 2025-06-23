#!/bin/bash

day=$(date +'%A')

case $day in
	"Monday")
		echo "Today is Monday"
	;;
	
	"Tuesday")
		echo "Getting better Tuesday"
	;;

	"Wednesday")
		echo "Middle of the week Wednesday"
	;;

	"Thursday")
		echo "Thirsty Thursday"
	;;

	"Friday")
		echo "TGIF!"
	;;

	"Saturday")
		echo "Yippy, Samedi!!"
	;;

	"Sunday")
		echo "Domingo yo"
	;;

	*)
		echo "Yo, wtf??"
	;;
esac

echo "TADA!!!"