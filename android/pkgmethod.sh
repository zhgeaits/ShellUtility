#!/bin/bash
   
#author:zhangge
#email:zhgeaits@gmail.com
#description:
#  统计一个apk包指定包名的方法数
   
# 得到命令行的所有参数
tool_name="$0"
apk_path=$1
pkg_list=$2
   
# 检验参数的合法性
if [ x"$apk_path" == x ] || [ x"$pkg_list" == x ] ;then
    echo -e "\n\t用法："
    echo -e "\tpkgmethod your_apk_path \"your_package_list\""
    echo -e "\n\t例："
    echo -e "\tpkgmethod ../../tieba.apk \"com.baidu.tieba.frs com.baidu.tieba.pb\"\n"
    exit 1;
fi
   
# 得到工具的原始目录
prog=$tool_name
while [ -h "${prog}" ]; do
    newProg=`/bin/ls -ld "${prog}"`
    newProg=`expr "${newProg}" : ".* -> \(.*\)$"`
    if expr "x${newProg}" : 'x/' >/dev/null; then
        prog="${newProg}"
    else
        progdir=`dirname "${prog}"`
        prog="${progdir}/${newProg}"
    fi
done
   
# 这就是工具的目录了
tool_dir=`dirname "${prog}"`
   
# 以此得到两个jar文件的完整路径
baksmali_jarfile=$tool_dir/baksmali-2.0.3.jar
smali_jarfile=$tool_dir/smali-2.0.3.jar
   
# 下面要做的事情是：在当前目录下创建临时文件夹，将目标apk文件拷贝进来并解压
# 创建一个临时目录，来解压这个apk文件
rm -rf apk_temp
mkdir apk_temp
cp $1 apk_temp/
cd apk_temp
echo "创建临时目录成功..."
   
# 获得apk的名称
apk_name="$(basename *.apk)"
   
# 重命名为zip
mv $apk_name $apk.zip
   
# 解压apk，得到classes.dex包
unzip -x $APK_NAME.zip > /dev/null
echo "解压apk文件并提取dex文件成功..."
   
# 在当前目录下，就可以得到classes.dex文件了
# 接下来要做的事情就是：
# 1、使用baksmali将classes.dex中的class导出（smali文件）
java -jar $baksmali_jarfile -o classes_dir/ classes.dex
echo "反编译dex文件成功..."
echo -e "开始进行package下方法数量的统计...\n"
   
# 2、用smali对各个package进行转换：smali to dex
for pkg_item in $pkg_list ;do
    target_pkg_name=$pkg_item
    # 将.替换成/得到路径，比如：com.baidu.tieba.pb替换为com/baidu/tieba/pb
    target_pkg_path="classes_dir/${pkg_item//.//}"
   
    if [ -d "$target_pkg_path" ];then
        # 编译得到以包名命名的dex文件，如：com.baidu.tieba.pb.dex
        java -jar $smali_jarfile $target_pkg_path/ -o $target_pkg_name.dex
   
        # 从dex文件中统计方法数
        method_num=`dexdump -f $target_pkg_name.dex | grep method_ids_size`
        # 为了得到纯数字部分，咱们吧不相干的东西删掉
        method_num=${method_num//method_ids_size/}
        method_num=${method_num//:/}
        method_num=`echo $method_num | sed -e 's/\(^ *\)//' -e 's/\( *$\)//'`
        echo -e "  $target_pkg_name \t: $method_num"
    else
        echo -e "  $target_pkg_name \t: 包不存在"
    fi
done
   
# 删除临时目录，结束
# cd ../ && rm -rf apk_temp
echo -e "\n删除临时目录成功，方法数量统计结束！"