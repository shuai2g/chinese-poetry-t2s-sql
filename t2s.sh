 #!/bin/bash
#----------------------------------------------------------
# Description：chinese poetry traditional convert simple 
# Author：author@shuaigg.cn
# Source：https://github.com/chinese-poetry/chinese-poetry
# Explain：depend on opencc library
#----------------------------------------------------------

#source path
sourcePath="/opensource/chinese-poetry-master/"
# opencc config 
openccConfig="/usr/local/share/opencc/t2s.json"
# simple chinese path
simpleSourcePath=${sourcePath}"simple/"
# category path
chineseNames=(json ci lunyu shijing mengxue sishuwujing)
# log
logFile=${sourcePath}"t2s.log"

# check opencc
check_opencc(){
		[[ ! -x "$(command -v opencc)" ]] && echo -e "opencc没有安装 ! " && exit 1
}
# check config
check_config_source(){
	[[ ! -d ${sourcePath} ]] && echo -e "${sourcePath}-资源目录没有找到，请检查 !" && exit 1
	[[ ! -e ${openccConfig} ]] && echo -e "${openccConfig}-opencc配置没有找到，请检查 !" && exit 1
	[[ ! -d ${simpleSourcePath} ]] && echo -e "${simpleSourcePath}-简体目录没有找到，请检查 !" && exit 1
}
# check file
check_filePath(){
	[[ ! -d $1 ]] && echo -e "${1}-资源目录没有找到，请检查 !" && exit 1
}
# check simpleFilePath
check_simpleFilePath(){
	if [[ ! -d $1 ]]; then
			echo -e "开始创建：  ${1}"
			mkdir $1
			[[ ! -d $1 ]] && echo -e "${1}-简体目录创建失败，请检查 !" && exit 1
	fi
}


# main()
chinese_t2s(){
	check_opencc
	check_config_source
    echo -e `date '+%Y-%m-%d %H:%M:%S'`"  开始转换：" > ${logFile}
    for i in ${chineseNames[*]}
	do
	filePath=${sourcePath}${i}"/"
	check_filePath $filePath
	simpleFilePath=${simpleSourcePath}${i}"/"
	check_simpleFilePath $simpleFilePath
	cd $filePath
		for fileName in $(ls *.json)
		do
		 opencc -i ${filePath}${fileName} -o ${simpleFilePath}${fileName} -c $openccConfig >> ${logFile} 2>&1
		 echo -e `date '+%Y-%m-%d %H:%M:%S'`"  "${filePath}${fileName}"  "${simpleFilePath}${fileName} >> ${logFile}
		done
	done
	echo -e `date '+%Y-%m-%d %H:%M:%S'`"  结束转换！" >> ${logFile}
}
# call chinese traditional convert simple function
chinese_t2s



