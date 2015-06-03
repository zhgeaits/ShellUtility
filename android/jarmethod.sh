#! /bin/sh
  
#author:zhangge
#email:zhgeaits@gmail.com
#description:
#  统计一个jar包的方法数

# 获得输入的jar文件
JAR_FILE=$1;
  
# 这里直接使用dx命令，是因为我已经提前配置好了环境变量，dx目录位于：
# $ANDROID_HOME/sdk/build-tools/android-4.3.1/dx
dx --dex --verbose --no-strict --output=temp.dex $JAR_FILE > /dev/null
  
# 计算jar包中的方法数
METHOD_COUNT=`cat temp.dex | head -c 92 | tail -c 4 | hexdump -e '1/4 "%d\n"'`
  
# 显示结果
echo $METHOD_COUNT
  
# 删除临时文件temp.dex
rm -f temp.dex