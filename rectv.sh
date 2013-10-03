#!/bin/bash
# $1 -- ch_num
# $2 -- rec_min
# $3 -- title
case "${1}" in
  "103" | "910" ) sid=${1} ;;
  * ) sid=hd ;;
esac
g="grep"
dt=`date +%y%m%d%H%M%S`
mt=`echo $(( 60 * ${2} ))`
d1="hddlabel1"
d2="hddlabel2"
flag=`cat '/home/usrdir/drive.txt'`
case ${flag} in
    ${d1} ) ;;
    ${d2} ) d2=${d1}
    d1=${flag} ;;
    * ) flag=${d1} ;;
esac
if [ ! -d /media/${d1} ]
then
    d1=${d2}
    d2=${flag}
fi
u="9[6-9]%\|100%"
dck=`df -h | $g ${d1} | $g ${u} | wc -l`
case ${dck} in
	1 ) df -h | $g ${d2} | $g ${u} && exit
	dr=${d2} ;;
	* ) dr=${d1} ;;
esac
cd /media/${dr}/recdir/ || exit
/usr/local/bin/recpt1 --b25 --strip --sid ${sid} ${1} ${mt} ${1}_${3}_${dt}.ts
echo "${dr}" > '/home/usrdir/drive.txt'
