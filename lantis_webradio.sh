#!/bin/bash
workdir=/tmp/
cd ${workdir}
wget -P ${workdir} http://lantis-net.com/${1}index.html
if [ -n "${1}" ]
then
  seed=( `cat ${workdir}index.html | sed "s/</\n</g" | grep h.asx | grep -o \"[0-9].*\" | sed "s/\"//g"` )
else
  seed=( `cat ${workdir}index.html | sed "s/</\n</g" | grep h.asx | grep -o \"[@-~].*\" | sed "s%\"\|http://lantis-net.com/\|/[0-9].*h\.asx%%g"` )
fi
select ANS in ${seed[@]}
do
  if [ -n "${ANS}" ]
  then
    echo -n "まだ選ぶ？ (y/n) ： "
    read key
  fi
  if [ -z "${ANS}" ]
  then
    continue
  elif [ "${key}" = "y" ]
  then
    joblist+=( ${ANS} )
    continue
  else
    joblist+=( ${ANS} )
    break
  fi
done
if [ -z "${joblist}" ]
then
  joblist+=( ${ANS} )
  echo -e "これで作業するよ\n${ANS}"
else
  echo -e "これで作業するよ\n${joblist[@]}"
fi
for (( i = 0; i < ${#joblist[@]}; i++ ))
{
  if [ -n "${1}" ]
  then
    url=http://lantis-net.com/${1}${joblist[i]}
  else
    url=`cat ${workdir}index.html | sed "s/</\n</g" | grep ${joblist[i]} | grep h.asx | grep -o \"[@-~].*\" | sed "s/\"//g"`
  fi
  wget -P ${workdir} ${url}
  if [ -n "${1}" ]
  then
    fln=${joblist[i]}
  else
    fln=`echo ${url} | sed "s%http://lantis-net.com/${joblist[i]}/%%"`
  fi
  mimms `cat ${workdir}${fln} | grep HREF | grep -o \"[@-~].*\" | sed "s/\"//g"`
  rm ${workdir}${fln}
}
rm ${workdir}index.html
