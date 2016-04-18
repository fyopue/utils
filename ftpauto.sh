#!/bin/bash
#自動更新用スクリプト

#作業ディレクトリ設定
workdir=

#アップロード先設定
userid=
password=
hostname=
hostdir=

#アップロード対象ディレクトリ抽出
dirlist=( `find ${workdir}/ | grep -v "\." | sed "s%${workdir}%%g"` )
for (( i = 0; i < ${#dirlist[@]}; i++ ))
{
  #ディレクトリ末尾にスラッシュあるか確認
  echo ${dirlist[i]} | grep /$ || dirlist[i]=${dirlist[i]}/
  #ファイルリスト抽出
  filelist=( `ls ${workdir}${dirlist[i]} | grep "\."` )
  for (( j = 0; j < ${#filelist[@]}; j++ ))
  {
    #アップロード
    /usr/bin/curl -T ${workdir}${dirlist[i]}${filelist[j]} -u ${userid}:${password} --ftp-create-dirs ftp://${hostname}:${hostdir}${dirlist[i]}
  }
}
