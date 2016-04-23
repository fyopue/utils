#!/bin/bash
# Google Images Vacuum v1.1
# $ givac.sh [searchword]
cd /tmp/
mkdir ${1}

# 検索語エンコード
wrd=`echo ${1} | nkf -wMQ | tr = %`
# 検索ページ取得
wget "https://www.google.co.jp/search?q="${wrd}"&tbm=isch" -O ${1}.html --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0"

# ファイルURL取得
joblist=( `cat ${1}.html | sed "s/,/\n/g" | grep \"ou\"\: | sed -e "s/\"ou\"\://g" -e "s/\"//g"` )
reflist=( `cat ${1}.html | sed "s/,/\n/g" | grep \"ru\"\: | sed -e "s/\"ru\"\://g" -e "s/\"//g"` )

# ファイル取得、取得URLログ書き出し
for (( i = 0; i < ${#joblist[@]}; i++ ))
{
  wget -t 2 -P /tmp/${1} ${joblist[i]} --referer=${reflist[i]}
  echo pic : ${joblist[i]} >> /tmp/${1}/url.list
  echo url : ${reflist[i]} >> /tmp/${1}/url.list
}

# 検索ページ削除
rm ${1}.html
