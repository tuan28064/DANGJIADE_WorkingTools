#!/bin/sh

CURRENT_PATH=$(dirname $0)
FILE_NAME=$1
DIR_NAME=$2
FILE_PATH=$CURRENT_PATH/$1
DIR_PATH=$CURRENT_PATH/$2

# 检查名称文件
if [[ ! -f $FILE_PATH ]]; then
	echo "### 名称文件缺失 ###"
	echo "请准备好名称文件"
	exit -1
fi

# 检查文件夹
if [[ ! -d $DIR_PATH ]]; then
	echo "### 文件夹缺失，无法剪切相关文件 ###"
	exit -1
fi

# 拷贝文件到对应的文件夹
cat $FILE_PATH | while read dirName
do
	# 判断目标文件夹是否已创建
	if [[ ! -d $CURRENT_PATH/$dirName ]]; then
		echo "### 目标文件夹不存在，无法剪切文件 ###"
		echo "请先创建目标文件夹"
		exit -1
	fi

	# 截取名称
	dir_name=${dirName#*《}
	dir_name=${dir_name%》*}

	# 匹配文件
	ls $DIR_PATH | while read fileName
	do
		if [[ $fileName =~ "《""$dir_name""》" ]]; then
			# 剪切文件
			mv "$DIR_PATH/$fileName" "$dirName"
			continue
		fi
	done

done

echo "剪切完毕~"