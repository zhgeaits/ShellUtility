#! /bin/sh
  
#author:zhangge
#email:zhgeaits@gmail.com
#description:
#  ͳ��һ��jar���ķ�����

# ��������jar�ļ�
JAR_FILE=$1;
  
# ����ֱ��ʹ��dx�������Ϊ���Ѿ���ǰ���ú��˻���������dxĿ¼λ�ڣ�
# $ANDROID_HOME/sdk/build-tools/android-4.3.1/dx
dx --dex --verbose --no-strict --output=temp.dex $JAR_FILE > /dev/null
  
# ����jar���еķ�����
METHOD_COUNT=`cat temp.dex | head -c 92 | tail -c 4 | hexdump -e '1/4 "%d\n"'`
  
# ��ʾ���
echo $METHOD_COUNT
  
# ɾ����ʱ�ļ�temp.dex
rm -f temp.dex