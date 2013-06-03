#!/bin/bash
#author zhangge
#email zhgeaits@gmail.com
#description experiment 1 of unix course

parameters=$#
INPUT="input"

#判断参数是否小于1
if [ $parameters -lt 1 ]; then
	echo "Usage: experiment.sh filename"
	exit
fi

#循环读入
while [ "$INPUT" != '' ];do
	read INPUT
	if [ "$INPUT" != '' ]
	then
		echo $INPUT >> $1
	fi
done
