#!/bin/bash
# Google Images Vacuum v1
# $ givac.sh [searchword]
cd /tmp/
mkdir ${1}

wrd=`echo ${1} | nkf -wMQ | tr = %`
wget "https://www.google.co.jp/search?q="${wrd}"&tbm=isch" -O ${1}.html --user-agent="Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; Touch; rv:11.0) like Gecko"

joblist=( `cat ${1}.html | sed "s/imgres?\|&amp;/\n/g" | grep imgurl | sed "s/imgurl=//g"` )
reflist=( `cat ${1}.html | sed "s/&amp;/\n/g" | grep imgrefurl | sed "s/imgrefurl=//g"` )

for (( i = 0; i < ${#joblist[@]}; i++ ))
{
  wget -t 2 -P /tmp/${1} ${joblist[i]} --referer=${reflist[i]}
  echo pic : ${joblist[i]} >> /tmp/${1}/url.list
  echo url : ${reflist[i]} >> /tmp/${1}/url.list
}

rm ${1}.html
