#!/bin/bash
#以下の書式で呼び出す。
#kabudata.sh 日数

seed="${1}"
prefix="download.aspx?p=all&download=csv&date="
url="site url"
fol="/home/userdir/kabudata/"
if [ ! -d /tmp/qtsdata ]
then
  mkdir /tmp/qtsdata
fi
while [ "${seed}" != "0" ]
do
  dt=`date -d "${seed} days ago" +%Y-%m-%d`
  wk=`date -d "${seed} days ago" +%w`
  case "${wk}" in
    [1-5] )
      sleep "5" && wget --limit-rate=100000 -P "${fol}" "${url}${prefix}${dt}"
      fn=`cut -b 1-10 "${fol}${prefix}${dt}" | head -1 | sed -e "s/-//"`
      cat "${fol}${prefix}${dt}" | sed -e "1,2d" -e "s/,-/,0/g" -e "s/^/${fn},/g" > "/tmp/qtsdata/${fn}.csv"
    ;;
    * ) : ;;
  esac
  seed=$(( ${seed} - 1 ))
done
