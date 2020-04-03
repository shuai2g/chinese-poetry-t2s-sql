# chinese-poetry-t2s-sql
chinese-poetry 繁体转简体、生成mysql sql文件的shell

## 说明

- t2s.sh 繁体转简体的shell。幽梦影、五代·花间集、五代·南唐二主词，没做处理。【幽梦影】在原仓库中已为简体，【五代...】和唐宋诗词有重复，没有处理。
如果有需要可以自行修改。
-  mksql.sh 将chinese-poetry相关数据生成导入mysql的sql文件。尝试用jq解析json 写成sql 连接数据库然后导入，运行效果和效率都不太好，中途放弃了。建议还是用动态脚本 php、python来处理这块比较好。



## 参考
- [chinese-poetry](https://github.com/chinese-poetry/chinese-poetry)
- [chinese-poetry-mysql](https://github.com/KomaBeyond/chinese-poetry-mysql)