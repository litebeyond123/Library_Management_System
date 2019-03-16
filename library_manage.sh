#!/bin/bash

a34-Cover(){
clear
printf "\033[33m\n\n\n\n\n%23sPersonal Library Management System \033[0m\n\n"
printf "%34sVersion: 0.1\n\n"
printf "\033[32m %30sokhellokky@gmail.com \033[0m\n\n"
printf "%35s2018-04-23\n\n"
printf "\033[34m\n\n\n\n\n%27sPress ENTER to continue... \033[0m"
read m
case $m in
*)a34-Menu;;
esac
}
a34-Menu(){
if [ -f book.db ];then
sort -t '%' -k8 book.db > cache | mv cache book.db
clear
printf "\033[33m\n\n\n\n\n%35sMain Menu\n\n\033[0m"
printf "%20s1: show books\n\n"
printf "%20s2: find books\n\n"
printf "%20s3: add books\n\n"
printf "%20s4: edit books\n\n"
printf "%20s5: check out books\n\n"
printf "%20s6: check in books\n\n"
printf "%20s7: delete books\n\n"
printf "%20sq: Exit\n\n"
printf "\033[34m%23splease type your choose[1-7 or q]: \033[0m"
read c
case $c in
1) a34-Show;;
2) a34-Find;;
3) a34-Add;;
4) a34-Edit;;
5) a34-Check-Out;;
6) a34-Check-In;;
7) a34-Delete;;
q) exit;;
*) a34-Menu;;
esac
else
touch book.db
fi
}
#feature 1
a34-Show(){
test -e book.db
if [ $? = true ];then
touch book.db
else
clear
a34-Show-Menu
fi
}
a34-Show-Menu(){
clear
printf "\033[33m\n\n\n\n\n%35sShow books\n\n\033[0m"
printf "%20s1: Sort by ID\n\n"
printf "%20s2: Sort by Title\n\n"
printf "%20s3: Sort by Author\n\n"
printf "%20sq: Return Main Menu\n\n"
printf "\033[34m\n\n\n\n\n%26sEnter your choice[1-3 or q]: \033[0m"
read d
case $d in
1)a34-Sort-Id;;
2)a34-Sort-Title;;
3)a34-Sort-Author;;
q)a34-Menu;;
*)a34-Show;;
esac
}
a34-Sort-Id(){
clear
sort -t '%' -k8 book.db | a34-Result |less
a34-Show-Menu
}
a34-Sort-Title(){
clear
sort -t '%' -k2.1 book.db | a34-Result |less 
a34-Show-Menu
}
a34-Sort-Author(){
clear
sort -t '%' -k3.1 book.db | a34-Result |less
a34-Show-Menu
}
#feature 2
a34-Find(){
a34-Find-Menu
}
a34-Find-Menu(){
clear
declare -a a
printf "\033[33m\n\n\n\n\n%35sFind books\n\n\033[0m"
printf "\033[35m%27sID:\033[0m"
printf "\033[35m\n\n%24sTitle:\033[0m "
printf "\033[35m\n\n%23sAuthor:\033[0m "
printf "\033[35m\n\n%25sTags:\033[0m "
printf "\033[35m\n\n%23sin/out:\033[0m "
printf "\033[35m\n\n%21sBorrower:\033[0m "
tput cup 7 30
read a[0]
declare c=${#a[0]}
declare b="0"
for((i=0;i<5-$c;i++))
do
a[0]="$b${a[0]}"
done
tput cup 9 30
read a[1]
tput cup 11 30
read a[2]
tput cup 13 30
read a[3]
tput cup 15 30
read a[4]
tput cup 17 30
read a[5]
printf "\033[34m\n\n%22sAre you sure? [y(es)/n(o)/c(ancel)]:\033[0m "
read e
case $e in
y)a34-Find-Condition;;
n)a34-Find-Menu;;
c)a34-Menu;;
*)a34-Find;;
esac
a34-Find-Conti
}
a34-Find-Conti(){
printf "\033[34m\n%31sAny book to find? [y/n]:\033[0m "
read f
case $f in
y)a34-Find;;
n)a34-Menu;;
*)a34-Find-Conti;;
esac
}
a34-Find-Condition(){
cut -b 4- book.db | awk -F "%" '$1~/'"${a[0]}"'/&&$2~/'"${a[1]}"'/&&$3~/'"${a[2]}"'/&&$4~/'"${a[3]}"'/&&$5~/'"${a[4]}"'/&&$6~/'"${a[5]}"'/{print "         ID: a34"$1,"\n      Title: "$2,"\n     Author: "$3,"\n       Tags: "$4,"\n     Status: "$5"\n"}'| less
}
#feature 3
a34-Add(){
a34-Add-List
}
a34-Generate-Id(){
g=`sort -t "%" -k1 book.db | sed -n '$p' | cut -c5-9`
k=$((10#$g))
declare n=0
let k++
let m=$k
while [ $k -gt 0 ];do
 let n++
 let k=$k/10
done
printf "a34-"
for((j=0;j<5-$n;j++))
do
 printf "0" 
done
printf $m
}
a34-Add-List(){
clear
printf "\033[33m\n\n\n\n\n%35sAdd books\n\n\033[0m"
printf "\033[35m%27sID:\033[0m "
a34-Generate-Id
printf "\033[35m\n\n%24sTitle:\033[0m "
printf "\033[35m\n\n%23sAuthor:\033[0m "
printf "\033[35m\n\n%25sTags:\033[0m "
tput cup 9 30
read t
tput cup 11 30
read a
tput cup 13 30
read b
a34-Add-Ctrl
}
a34-Add-Ctrl(){
printf "\033[35m\n\n\n\n\n%22sAre you sure? [y(es)/n(o)/c(ancel)]:\033[0m "
read h
case $h in
y)a34-Add-Result;;
n)a34-Add-List;;
c)a34-Menu;;
*)a34-Add-Ctrl;;
esac
}
a34-Add-Result(){
a34-Generate-Id >> book.db
echo -e "%"$t"%"$a"%"$b"%%%" >>book.db
printf "\033[35m\n\n%24sSuccess, any book to add? [y/n]:\033[0m "
read l
case $l in
y)a34-Add;;
n)a34-Menu;;
*)a34-Add-Result;;
esac
}
#feature 4
a34-Edit(){
a34-Edit-Form
}
a34-Edit-Form(){
clear
printf "\033[33m\n\n\n%27sEdit information of books\033[0m"
printf "\033[35m\n\n%26sID:\033[0m"
printf "\033[35m\n\n%23sTitle:\033[0m "
printf "\033[35m\n\n%22sAuthor:\033[0m "
printf "\033[35m\n\n%24sTags:\033[0m "
printf "\033[35m\n\n%22sin/out:\033[0m "
printf "\033[35m\n\n%20sBorrower:\033[0m "
printf "\033[35m\n\n%21soutTime:\033[0m "
tput cup 5 29
read o
declare q="0"
declare r=${#o}
for((i=0;i<5-$r;i++))
do
o="$q$o"
done
p=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{print 1}' `
if [[ $p = 1 ]];then
a34-Edit-Find
else
a34-Edit-Not
fi
}
a34-Edit-Not(){
clear 
printf "\033[34m\n%24sThe book you searched is not in\n\033[0m"
printf "\033[34m\n%24sContinue to search? [y(es)/n(o)]:\033[0m "
read u
case $u in
y)a34-Edit;;
n)a34-Menu;;
*)a34-Edit-Not;;
esac
}
a34-Edit-Find(){
clear
declare -a b
printf "\033[33m\n\n\n%27sEdit information of books\033[0m"
printf "\033[35m\n\n%26sID:\033[0m a34-"
cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $1}'
printf "\033[35m\n\n%23sTitle:\033[0m "
a1=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $2}'`
echo -e $a1" \033[34m==>\033[0m \c"
printf "\033[35m\n\n%22sAuthor:\033[0m "
a2=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $3}'`
echo -e $a2" \033[34m==>\033[0m \c"
printf "\033[35m\n\n%24sTags:\033[0m "
a3=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $4}'`
echo -e $a3" \033[34m==>\033[0m \c"
printf "\033[35m\n\n%22sin/out:\033[0m "
a4=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $5}'`
echo -e $a4" \033[34m==>\033[0m \c"
printf "\033[35m\n\n%20sBorrower:\033[0m "
a5=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $6}'`
echo -e $a5" \033[34m==>\033[0m \c"
printf "\033[35m\n\n%21soutTime:\033[0m "
a6=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $7}'`
echo -e $a6" \033[34m==>\033[0m \c"
let b1=29+${#a1}+5
tput cup 7 $b1
read b[0]
let b2=29+${#a2}+5
tput cup 9 $b2
read b[1]
let b3=29+${#a3}+5
tput cup 11 $b3
read b[2]
let b4=29+${#a4}+5
tput cup 13 $b4
read b[3]
let b5=29+${#a5}+5
tput cup 15 $b5
read b[4]
let b6=29+${#a6}+5
tput cup 17 $b6
read b[5]
a34-Edit-Ctrl
a34-Edit-Continue
}
a34-Edit-Ctrl(){
printf "\033[34m\n\n%21sAre you sure? [y(es)/n(o)/c(ancel)]:\033[0m "
read p
case $p in
y)a34-Edit-Result;;
n)a34-Edit-Form;;
c)a34-Menu;;
*)a34-Edit-Ctrl;;
esac
}
a34-Edit-Continue(){
printf "\033[34m\n\n%20sSuccess, any more book to edit? [y/n]:\033[0m "
read q
case $q in
y)a34-Edit-Form;;
n)a34-Menu;;
*)a34-Edit-Continue;;
esac
}
a34-Edit-Result(){
if [ "${b[0]}" == "" ];then
printf ""
else
bx=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%"$6"%"$7}'`
bw=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%'"${b[0]}"'%"$3"%"$4"%"$5"%"$6"%"$7}'`
sed -i "s/$bx/$bw/" book.db
fi
if [ "${b[1]}" == "" ];then
printf ""
else
ax=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%"$6"%"$7}'`
aw=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%'"${b[1]}"'%"$4"%"$5"%"$6"%"$7}'`
sed -i "s/$ax/$aw/" book.db
fi
if [ "${b[2]}" == "" ];then
printf ""
else
cx=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%"$6"%"$7}'`
cw=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%'"${b[2]}"'%"$5"%"$6"%"$7}'`
sed -i "s/$cx/$cw/" book.db
fi
if [ "${b[3]}" == "" ];then
printf ""
else
dx=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%"$6"%"$7}'`
dw=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%'"${b[3]}"'%"$6"%"$7}'`
sed -i "s/$dx/$dw/" book.db
fi
if [ "${b[4]}" == "" ];then
printf ""
else
ex=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%"$6"%"$7}'`
ew=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%'"${b[4]}"'%"$7}'`
sed -i "s/$ex/$ew/" book.db
fi
if [ "${b[5]}" == "" ];then
printf ""
else
fx=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%"$6"%"$7}'`
fw=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%"$6"%"'${b[5]}'}'`
sed -i "s/$fx/$fw/" book.db
fi
}
#feature 5
a34-Check-Out(){
a34-Check-Form
}
a34-Check-Form(){
clear
printf "\033[33m\n\n\n%23sCheck out books\033[0m"
a34-Check-Item
tput cup 5 22
read o
declare k=${#o}
declare y="0"
for((i=0;i<5-$k;i++))
do
o="$y$o"
done
p=`cut -b 4- book.db | awk -F "%" '$1~/'"$o"'/{print 1}' ` 
if [[ $p = 1 ]];then
a34-Check-Refreash
a34-Check-Find
else
a34-Check-Notin
fi
}
a34-Check-Notin(){
clear
printf "\033[34m\n%24sThe book you searched is not in the database\033[0m\n"
printf "\033[34m\n%24sContinue to search? [y(es)/n(o)]:\033[0m "
read u
case $u in
y)a34-Check-Out;;
n)a34-Menu;;
*)a34-Check-Notin;;
esac
}
a34-Check-Find(){
clear
a34-Form-Info
printf "\033[35m\n\n%14sin/out:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $5}'
printf "\033[35m\n\n%12sBorrower:\033[0m "
printf "\033[35m\n\n%13soutTime:\033[0m "
tput cup 15 22
read w
a34-Check-Sure
a34-Check-Continue
}
a34-Check-Sure(){
printf "\033[34m\n\n\n%17sAre you sure? [y(es)/n(o)/c(ancel)]:\033[0m "
read y
case $y in
y)a34-Check-Result;;
n)a34-Check-Find;;
c)a34-Check-Out;;
*)a34-Check-Sure;;
esac
}
a34-Check-Continue(){
printf "\033[34m\n\n%18sSuccess, any more books to check out? [y/n]:\033[0m "
read z
case $z in
y)a34-Check-Out;;
n)a34-Menu;;
*)a34-Check-Continue;;
esac
}
a34-Form-Info(){
clear
printf "\033[33m\n\n\n%23sCheck out books\033[0m"
printf "\033[35m\n\n%18sID:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $1}'
printf "\033[35m\n\n%15sTitle:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $2}'
printf "\033[35m\n\n%14sAuthor:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $3}'
printf "\033[35m\n\n%16sTags:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $4}'
}
a34-Check-Refreash(){
p=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $5}'`
if [ "$p" == "in" ];then
printf ""
else
a34-Check-Lend
fi
}
a34-Check-Lend(){
clear
printf "\033[34m\n\n\n\n\n%30sthe book is lend out\033[0m"
printf "\033[34m\n%19sContinue to search? [y(es)/n(o)]:\033[0m "
read m
case $m in
y)a34-Check-Out;;
n)a34-Menu;;
*)a34-Check-Lend;;
esac
}
a34-Check-Result(){
if [ "$w" == "" ];then
printf ""
else
k=`date +%Y-%m-%d`
ay=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%"$6"%"$7}'`
az=`cut -b 5- book.db|awk -F "%" '$1~/'"$o"'/{print "a34-"$1"%"$2"%"$3"%"$4"%out""%'"$w"'%"}'`
ak="$az$k"
sed -i "s/$ay/$ak/" book.db
fi
a34-Form-Info
printf "\033[35m\n\n%14sin/out:\033[0m "
b=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $5}'`
printf "\033[34m$b\033[0m"
printf "\033[35m\n\n%12sBorrower:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $6}'
printf "\033[35m\n\n%13soutTime:\033[0m "
a=`cut -b 5- book.db | awk -F "%" '$1~/'"$o"'/{printf $7}'`
printf "\033[34m$a\033[0m"
#printf "\033[34m\n\n%18sSuccess, any more books to check out? [y/n]:\033[0m "
}
a34-Check-Item(){
printf "\033[35m\n\n%18sID:\033[0m "
printf "\033[35m\n\n%15sTitle:\033[0m "
printf "\033[35m\n\n%14sAuthor:\033[0m "
printf "\033[35m\n\n%16sTags:\033[0m "
printf "\033[35m\n\n%14sin/out:\033[0m "
printf "\033[35m\n\n%12sBorrower:\033[0m "
printf "\033[35m\n\n%13soutTime:\033[0m "
}
#feature 6
a34-Check-In(){
a34-Check-Fun
}
a34-Check-Fun(){
clear
printf "\033[33m\n\n\n%23sCheck in books\033[0m"
a34-Check-Item
tput cup 5 22
read a
declare k=${#a}
declare y="0"
for ((i=0;i<5-$k;i++))
do
a="$y$a"
done
b=`cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print 1}'`
if [[ $b == 1 ]];then
c=`cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print $5}'`
if [ "$c" == "out" ];then
#a34-CheckIn-Result
clear
printf "\033[33m\n\n\n%23sCheck in books\033[0m"
a34-CheckIn-Value
a34-CheckIn-Sure
else
a34-CheckIn-Back
fi
else
a34-CheckIn-NotF
fi
}
a34-CheckIn-NotF(){
clear
printf "\033[34m\n\n%28sDid not found the book\n\n\033[0m"
printf "\033[34m\n\n%28sContinue to search?[y(es)/n(o)]:\033[0m"
read k
case $k in
y)a34-Check-In;;
n)a34-Menu;;
*)a34-CheckIn-NotF;;
esac
}
a34-CheckIn-Sure(){
printf "\033[34m\n\n\n%17sAre you sure? [y(es)/n(o)/c(ancel)]:\033[0m "
read e
case $e in
y)a34-CheckIn-Result;;
n)a34-Menu;;
*)a34-CheckIn-Sure;;
esac
}
a34-CheckIn-Back(){
clear
printf "\033[34m\n\n%20sThe book is backed\033[0m"
printf "\033[34m\n\n%18sDo you want to back other books?(y/n):\033[0m "
read d 
case $d in
y)a34-Check-In;;
n)a34-Menu;;
*)a34-CheckIn-Back;;
esac
}
a34-CheckIn-Value(){
printf "\033[35m\n\n%18sID:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print "a34-"$1}'
printf "\033[35m\n\n%15sTitle:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print $2}'
printf "\033[35m\n\n%14sAuthor:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print $3}'
printf "\033[35m\n\n%16sTags:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print $4}'
printf "\033[35m\n\n%14sin/out:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print $5}'
printf "\033[35m\n\n%12sBorrower:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print $6}'
printf "\033[35m\n\n%13soutTime:\033[0m "
cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print $7}'
}
a34-CheckIn-Result(){
k=`cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print "a34-"$1"%"$2"%"$3"%"$4"%"$5"%"$6"%"$7}'`
y=`cut -b 5- book.db | awk -F "%" '$1~/'"$a"'/{print "a34-"$1"%"$2"%"$3"%"$4"%in""%%%"}'`
sed -i "s/$k/$y/" book.db
clear
a34-CheckIn-Value
printf "\033[34m\n\n%22sDo you want to back other books? [y/n]:\033[0m"
read b
case $b in
y)a34-Check-In;;
n)a34-Menu;;
*)a34-CheckIn-Result;;
esac
}
#feature 7
a34-Delete(){
a34-Delete-Ctrl
}
a34-Delete-Ctrl(){
clear
printf "\033[33m\n\n\n%33sDelete books\033[0m"
a34-Check-Item
tput cup 5 22
read o
declare k=${#o}
declare y="0"
for((i=0;i<5-$k;i++))
do
o="$y$o"
done
p=`cut -b 4- book.db | awk -F "%" '$1~/'"$o"'/{print 1}' ` 
if [[ $p = 1 ]];then
a34-Delete-Exec
else
a34-CheckIn-Notin
fi
}
a34-CheckIn-Notin(){
clear
printf "\033[34m\n%20sThe book you searched is not in the database\033[0m\n"
printf "\033[34m\n%27sContinue to search? [y(es)/n(o)]:\033[0m "
read u
case $u in
y)a34-Delete;;
n)a34-Menu;;
*)a34-CheckIn-Notin;;
esac
}
a34-Delete-Exec(){
clear
printf "\033[33m\n\n\n%34sDelete books\033[0m"
a=$o
a34-CheckIn-Value
printf "\033[34m\n\n%27sAre you sure ?[y(es)/n(o)]\033[0m"
read x
case $x in
y)a34-Delete-Result;;
n)a34-Delete;;
*)a34-Delete-Exec;;
esac
}
a34-Delete-Result(){
sed -i '/'"$a"'/d' book.db
printf "\033[34m\n\n%22sSuccess,any more books to delete?(y/n)\033[0m"
read f
case $f in
y)a34-Delete;;
n)a34-Menu;;
*)a34-Delete-Result;;
esac
}
#transfer by feature "Show books" and "Find books"
a34-Result(){
awk -F "%" '{print "         ID: "$1,"\n      Title: "$2,"\n     Author: "$3,"\n       Tags: "$4,"\n     Status: "$5"\n"}'
}
a34-Cover
