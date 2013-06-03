#!/bin/bash
#author:zhangge
#email:zhgeaits@gmail.com
#description:
#  The statement of case...esac

if [ $# -ne 1 ]
then
    echo "One argument must be declared"
    exit
fi
case $1 in
    file1)
	echo "User selects file1"
	;;
    file2)
	echo "User selects file2"
	;;
    *)
	echo "You must select either file1 or file2"
	;;
esac
