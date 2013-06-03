#!/bin/bash
#author zhangge
#email zhgeaits@gmail.com
#dexcription experiment 2 of unix

parameters=$#
check_user=$1
get_user="who | cut -d ' ' -f 1"
users=""
check_user_logon()
{
	users=`eval $get_user`
	for user in $users
	do
		if [ "$user" == "$check_user" ];then
			echo "user $check_user is logon"
			return 1
		fi
	done
	return 0
}

if [ $parameters -ne 1 ];then
	echo "Usage:user_monitor username"
	exit
fi
check_user_logon
temp=$?
echo $users
if [ $temp -eq 1 ];then
	exit
fi
while [ $? -ne 1 ];do
	echo "waiting user[$check_user]..."
	sleep 5
	check_user_logon
done
