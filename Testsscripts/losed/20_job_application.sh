#we product n shippable s"job-applications", letter-files ready in a Dir waiting for to be send. eg. by mail.
#from a db read
#-plus an optional report on creation, last modification and probable, intended shipping shipping time for legal assurance


#conditioned by flag call of another script bash
tmpdir="/tmp/qemuburotest/"
cd $tmpdir
bash $Qemuburo_install_dir"Testsscripts/losed/""driver_fault2db.sh"
ls -l /tmp/qemuburotest/Johann_Peter_Eckermann_Gespraeche_mit_Goethe_in_den_letzten_Jahren_seines_Lebens18_10_1827.txt >>/tmp/qemuburotest/logs
#1839

incmax=$(cat "$tmpdir""logsdriver"|wc -l )
echo "ss""$tmpdir""logsdriver""sss""$incmax"
for ((inc=0;inc<$incmax;inc++)); do
   #echo  
   a=4 #$(wc -l <tmpfile$inc"address") 
   b=1 #1$(wc -l <tmpfile$inc"addressee")
   c=1 #$(wc -l <tmpfile$inc"adds")
#He wishes the address block as: person, enterprise, street, postal
# first grep person out, and put it above, a file,

    cat tmpfile"$inc"__address|grep -v "Frau\|Herr"> 1a.tmp1
    cat tmpfile"$inc"__addressee> tmpfile"$inc"__address #_5
    cat 1a.tmp1>> tmpfile"$inc"__address 
    cat tmpfile"$inc"__address > tmpfile"$inc"__x.address_5

    echo -e "Johann Eckermann\nStraße 23\n45678 Berlin\n">tmpfile"$inc"__x.sender0_1
    echo -e "18.10.1827">tmpfile"$inc"__x.date_2
    subjecttext="Bewerbung als Ingenieur"
    echo -e $subjecttext>tmpfile"$inc"__x.subject_3
    cat Johann_Peter_Eckermann_Gespraeche_mit_Goethe_in_den_letzten_Jahren_seines_Lebens18_10_1827.txt >tmpfile"$inc"__x.textblock_4
    
    cat tmpfile"$inc"__x.sender0_1>1.tmp
    cat tmpfile"$inc"__x.date_2> 2.tmp
    cat tmpfile"$inc"__x.subject_3> 3.tmp
    cat tmpfile"$inc"__x.textblock_4> 4.tmp
    cat tmpfile"$inc"__x.address_5> 5.tmp

    command="bash "$Qemuburo_install_dir"Testsscripts/losed/""superscript_losed_letter.sh --losedpy "$Qemuburo_install_dir"Testsscripts/losed/"losed.py  
    $command

 
    
   if [ "$a" -gt "2" ] && [ "$b" == "1" ]  && [ "$c" == "1" ]; 
   then echo "hello a3 b1"; 
   fi;
   done; 

   #command= "bash "+self.testsscripts+"losed/superscript_losed_letter.sh  "  +" --losedpy "+self.testsscripts+"losed/losed.py " #\

   command="bash "$Qemuburo_install_dir"Testsscripts/losed/""superscript_losed_letter.sh --losedpy "$Qemuburo_install_dir"Testsscripts/losed/"losed.py  

   
   echo $command
   #$command
   
#tmpfile7__9adds
#tmpfile7__9subjectads
#1.tmp

# addressee=$(head -n1 $tmp_dir"5.tmp")
# 
# addressee0=$(cat  $tmp_dir"5.tmp"|sed 's/$/\\n/' | tr -d '\n')
# 
# sender=$(head -n1 $tmp_dir"1.tmp")
# sender0=$(cat $tmp_dir"1.tmp"|sed 's/$/\\n/' | tr -d '\n' )
# #Senior Sancho Panza
# subject=$(head -n1 $tmp_dir"3.tmp")
# textblock=$(cat $tmp_dir"4.tmp"|sed 's/$/\\n/' | tr -d '\n')
# 
# date_string=$(head -n1 $tmp_dir"2.tmp")
