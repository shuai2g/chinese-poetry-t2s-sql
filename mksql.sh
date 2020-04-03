 #!/bin/bash
#----------------------------------------------------------
# Description：chinese poetry mysql sql
# Author：author@shuaigg.cn
# Source：https://github.com/chinese-poetry/chinese-poetry
# Explain：depend on jq library
#----------------------------------------------------------

#source path
poetryBasePath="/Users/shuaigg/opensource/chinese-poetry-master/simple"
poetryDataPath=$poetryBasePath"/json"
poemsDataPath=$poetryBasePath"/ci"
lunyuDataPath=$poetryBasePath"/lunyu"
shijingDataPath=$poetryBasePath"/shijing"

#database config
db_host="127.0.0.1";
db_port=3306;
db_username="root";
db_password="root";
db_poetryDb="anthology";

function mkPoetAuthor() {
	dynasty=$1
    poet=""
    if [[ "$dynasty" = "T" ]];then 
    	poet="tang"
    	echo -e "tang 类型数据处理!"
    elif [[ "$dynasty" = "S" ]];then	
    	poet="song"
    	echo -e "song 类型数据处理!"
	fi
	echo -e $dynasty
    [[ -z "$poet" ]] && echo -e "类型异常，请检查 !" && exit 1	

    poetAuthorJson=${poetryDataPath}"/authors."${poet}".json"
    count=$(cat $poetAuthorJson | jq ". | length")
    printf "Json %s author total num: %d\n" "$poet" $count
    sql="insert into poetry_author_s(uuid, name, intro, dynasty) values "
    value="";
    for (( i = 0; i < $count; i++ ));
    do
    	uuid=$(cat $poetAuthorJson | jq ".[${i}].id")
    	name=$(cat $poetAuthorJson | jq ".[${i}].name")
    	desc=$(cat $poetAuthorJson | jq ".[${i}].desc")

    	v="(${uuid},${name},${desc},\"${dynasty}\")"
        value=$([ "$value" == "" ] && echo "$v" || echo "$value,$v")
        unset uuid
        unset name
        unset desc
        unset v
    done
    echo $sql$value >> anthology.sql
    unset sql
    unset value
}

function mkSQL() {
    #生成唐宋诗作者数据
    mkPoetAuthor "T" 
    mkPoetAuthor "S" 

    #生成唐宋诗数据
    #mkPoetData("T")
    #mkPoetData("S")

    #生成宋词作者数据
    #mkPoemsAuthor();
    #生成宋词数据
    #mkPoemsData();

    #生成论语数据
    #mkLunyuData();

    #生成诗经数据
    #mkShijingData();
}

mkSQL
