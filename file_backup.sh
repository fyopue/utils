#!/bin/bash

cd "/home/usrdir/logdir/"
dt=`date +%Y%m%d%H`
#以下は任意のコマンドで読み替え
/usr/bin/crontab -l > "tablog${dt}.txt"
fl=`ls | wc -l`
#保存するファイル数上限
fn="6"
if [ ${fl} -gt ${fn} ]
then
    rmf=$(( ${fl} - ${fn} ))
    rm `ls | head -${rmf}`
fi
