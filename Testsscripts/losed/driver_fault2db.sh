#scrap from voult spezification see stamp to db format
#echo "hello "$Qemuburo_install_dir"Testsscripts/losed/""driver_fault2db.sh"
tmpdir="/tmp/qemuburotest/"
cd "$tmpdir"
#tbi
voultfilename="twgc_plain_gnu_jobboerse.arbeitsagentur.de_Elekroingenieur_Berlin_10_takes_rambo_style_5_2016" #twgc-format

voultfile=$tmpdir$voultfilename
#echo "hello $voultfile"


#Rückfragen und Bewerbungen an

token="ückfrage"
#qRückfragen und Bewerbungen an
tokenend="Bewerbungsarten"
tokenend=[0-9][0-9][0-9][0-9][0-9]
###1
#cat $voultfile|sed -n "/$token/,/$tokenend p"
i1nc1+=0
# for (( expr1 ; expr2 ; expr3 )) ; do list ; done
for ((inc=0;inc<10;inc++)); do
   #echo  
   cat $voultfile|sed -n "/###$inc/,/###`expr $inc + 1`/p" >tmpfile$inc 
   #echo $inc
   #addressee seperate
   cat tmpfile$inc|grep "^Herr\|^Frau"|head -1>tmpfile$inc"addressee"
   #email seperated, there is email in format
   cat tmpfile$inc|grep "@"|head -1>tmpfile$inc"adds"
   #promis snipped window
   cat tmpfile$inc|grep "ID[-: ]\|[0-9]\{8,\}-" |head -1>tmpfile$inc"subjectads"
   cat tmpfile$inc|sed -n "/$token/,/$tokenend/p">tmpfile_$inc
   # 4 line above postal with window
   cat tmpfile_$inc|grep "[0-9][0-9][0-9][0-9][0-9]" -B 4 |grep -v ück>tmpfile$inc"address"
   #vaultstatusreportword_fulladdressqualityok="0111000101"
   #adresse
   #cat tmpfile_$inc|grep "[0-9][0-9][0-9][0-9][0-9]" -B 4 |grep -v ück
   #email?
   a=$(wc -l <tmpfile$inc"address") 
   b=$(wc -l <tmpfile$inc"addressee")
   c=$(wc -l <tmpfile$inc"adds")
   #if contact from voult gets email, 3 lines address and sexualized addressee
   #echo $a " b" $b
   if [ "$a" -gt "2" ] && [ "$b" == "1" ]  && [ "$c" == "1" ]; 
   then 
   #echo "hello a3 b1"; 
   cp tmpfile$inc"addressee" "tmpfile""$i1nc1""__addressee"
   cp tmpfile$inc"address" tmpfile"$i1nc1"__"address"
   cp tmpfile$inc"adds" tmpfile"$i1nc1"__"adds"   
   cp tmpfile$inc"subjectads" tmpfile"$i1nc1"__"subjectads" 
   let i1nc1+=1
   echo $inc1>>"$tmpdir"'logs'driver
   #cat logsdriver
   fi;
   done; 
   
   #ls -l tmpfile[0-9]_*
   #wc tmpfile*
#Format such as
# Rückfragen und Bewerbungen an
# sCobbbtion GmbH 
# Herr Webb
# Mahbr Str. 61b 
# 15366 Hobn (Mark) 
# Hönow 
# Brandenburg 
# Deutschland
# E-Mail
# info@scobomExterner Link
# Gewünschte Bewerbungsarten
# tmpfile_0 (END)#

