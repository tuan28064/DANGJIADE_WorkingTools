#!/bin/sh

CURRENT_PATH=$(dirname $0)
FILE_NAME=$1
FILE_PATH=$CURRENT_PATH/$1

# 检查命名文件
if [[ ! -f $FILE_PATH ]]; then
	echo "### 命名文件缺失 ###"
	echo "请准备好命名文件"
	exit -1
fi

# 创建文件夹
cat $FILE_PATH | while read line
do
	#
	if [[ -d $CURRENT_PATH/$line ]]; then
		echo "### 文件夹已存在，无需创建 ###"
	fi

	# 创建
	mkdir "$CURRENT_PATH/$line"

	#
	if [[ ! -d $CURRENT_PATH/$line ]]; then
		echo "### 创建文件夹失败 ###"
		exit -1
	fi
done

echo "创建完毕~ 🤗"
