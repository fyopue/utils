#!/bin/bash
#引数でasxファイルを渡してやるとmimmsで/tmpにダウンロードしてくれる
#WEBラジオダラダラ聞ける
cd /tmp/
fln=( ${@} )
for (( i = 0; i < ${#}; i++ ))
{
  mimms `cat ${fln[i]} | grep HREF | grep -o \"[@-~].*\" | sed "s/\"//g"`
}
