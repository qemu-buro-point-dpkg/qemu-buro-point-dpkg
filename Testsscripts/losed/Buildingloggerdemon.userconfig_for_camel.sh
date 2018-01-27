#### two converter functions:
utc_ns2hrdf_ns () {
#date +%Y%m%d%H%S%N--%u-%V # hrdf human readable date format of a now
ticket_utc=$1; 
#echo $ticket_utc
ticket_utc_sec=${ticket_utc:0:10} #in seconds' form
#echo $ticket_utc_sec
ticket_utc_ns=${ticket_utc:10:9} #in nanoseconds'form
#echo $ticket_utc_ns
converted_hrdf_sec=$(date -d @$ticket_utc_sec +%Y%m%d%H%M%S)
#echo "converted_hrdf_sec:" $converted_hrdf_sec
converted_hrdf_ns=$converted_hrdf_sec$ticket_utc_ns
#echo "converted_hrdf_ns:" $converted_hrdf_ns
echo $converted_hrdf_ns;
}

# ticket_utc="150887562023415219500"
# converted_hrdf_ns=utc_ns2hrdf_ns $ticket_utc
# echo "converted_hrdf_ns:" $converted_hrdf_ns
# echo "ticket_utc:" $ticket_utc

########
hrdf_ns2utc_ns () {
ticket_hrdf=$1; #`date +%Y%m%d%H%M%S%N`; #
#echo $ticket_hrdf
ticket_hrdf_sec=${ticket_hrdf:0:14} #till seconds
#echo $ticket_hrdf_sec
ticket_hrdf_ns=${ticket_hrdf:14:9}
#echo $ticket_hrdf_ns
date=${tichet_hrdf_sec:0:8}
time=${tichet_hrdf_sec:8:4}
#echo "$date $time"
converted_utc_min=$(date -d "$date $time" +%s)
converted_utc_sec=$converted_utc_min${tichet_hrdf_sec:12:2}
converted_utc_ns=$converted_utc_sec$ticket_hrdf_ns
echo $converted_utc_ns;
}

# ticket_hrdf="20171024220700234152195"
# converted_utc_ns=hrdf_ns2utc_ns $ticket_hrdf
# echo "converted_utc_ns:" $converted_utc_ns
# #########
# # greetervar=demogreeter 
# # 
# # tmpdir="$HOME/Downloads"
# # 
# # logs="logs" #
# # sample_run_counter=0
# # tmpdir="/tmp/qemuburotest/" #path for temporary and out put data?
# # mkdir "/tmp/qemuburotest" 2>/dev/null
# # 
# # timetoken="150887562023415219500"
# # samplerate=1 # seconds sleeping between firing (sleep builtin)
# # 
# # triggertimeslogs="tmp_triggertimes.log" # file name of (future) events list 
# # 
# # execution_stamp_prefix="a"$sample_run_counter"a" # to use a timetable and a program data base alike
# # execution_stamp_postfix="Ω"$every_offset_ns"Ω"$times1"Ω" # 
# # 
# # 
# # tokenarray="" #inner variable, list of acute tokens found at sampling time
# # date_format="%s%N" #for date utc with nanoseconds
# # 
# # # "every" (tuesday)" function of a human user interface
# # sectonanoconverter="000000000"
# # every_offset_sec=360000000 #if in "every"-User-mode: alternating unending mode
# # #*60*60*24*7,*365 #every n days, year, not week, weekdays, month, years, 
# # 
# # every_offset_ns=$every_offset_sec$sectonanoconverter
# # times1=2 #event decrementer
# # 
# # 
# # nexttimetoken="" #inner, next token to set in repition mode
# # file_offset=0 #line number, where uncommented switches to commented,inner variable
# # file_length=0 #of time table inner variable
# # 
# # testdebug="0" # derault off, since huge logs
# # installpath=$tmpdir
# # conffile=$tmpdir"Buildingloggerdemon.userconfig.sh"

#user interface:
#timetoken="150887562023415219500"
ticket_hrdf="20171024220700234152195"
#user interface note: the line date_format="%s%N" #for date utc with nanoseconds
# sets the machine format: nanoseconds ns since 1970, called in date manual language "utc", there are several more human-like formats iso, rfc, we choose our own. It goes a days' format as if: 20171024, hour, minutes, seconds: 220700 plus a 9 place long number of nanoseconds, all arbitrary. This is the 24.th of Oktober, ten a clock pm we are speeking of

outpath="/tmp/qemuburotest/"
logs="logs"
converted_utc_ns=$(hrdf_ns2utc_ns $ticket_hrdf)
timetoken=$converted_utc_ns
echo "dui converted_utc_ns: timetoken" "$converted_utc_ns"" $ticket_hrdf ""$timetoken"" $1" >>$outpath$logs
echo "Layer 5 DUser Hello init###">>$outpath$logs
#ok one thought: this is point, where the a user's galleries shops could registerer their event functions 
#run 
for i in $(cat $HOME/ttcookie.script*); 
do 
echo "Layer 5 DUser Hello $i handler ###">>$outpath$logs
test -f $i && source $i; 
done;



mydemogreeter () {
demo=$1; 
outpath="/tmp/qemuburotest/"
logs="logs"
echo "Layer 5 DUser Hello gree evenz####""$demobash $userconfigpath$Buildingloggerdemonuserconfig">>$outpath$logs
   exe="t20ja-flat-stray.sh"
   #userconfigpath=
   #echo "run demon programmer a3 b1  --flagreprogramm ""$timetablefullpath""llllkjl"
   # So if you felt certainly need foor a user such, then read it in:
   ttcookie=$HOME"/ttcookie"
   #well that it project convention: temporary private user data between evants to store
   timetablefullpath=$(head $ttcookie)
   
  command="bash "$Qemuburo_install_dir"""Testsscripts/losed/"""$exe"  --triggertimeslogs ""$timetablefullpath" 
   echo $command>>$outpath$logs
  
  #count open entries of ours
  ttentries=$(cat $timetablefullpath|grep "^[0-9]"|grep mydemog|wc -l)
  echo $ttentries"=ttentries">>$outpath$logs
  #
   # UTC
cat $timetablefullpath|grep "^[0-9]"|grep mydemog
   #tbi tt stamping pls Feature all 3 next month, that many seconds: 
let monsec=60*60*24*30
nowutc=$(date +%s) #ns? pls?
#now utc stamp?
string="ΩΩΩmydemogreeterΩ20jaΩ"
ns="000000000"
let UTC1=$nowutc
#stamped?
let UTC2=UTC1+$monsec
#stamped?
let UTC3=UTC2+$monsec

# a "camel" sequence stamping for ja demoing. User use config file to program shop daimon
   if [ "$ttentries" -eq "3" ]; 
   then 
   echo "#stampUTC3 "$UTC3"$ns""$string">>$outpath$logs
   echo ""$UTC3"$ns""$string">>$timetablefullpath
   
   
   fi

   if [ "$ttentries" -eq "2" ]; 
   then 
   echo ""$UTC2"$ns""$string">>$outpath$logs
   echo ""$UTC3"$ns""$string">>$outpath$logs
 
  echo ""$UTC2"$ns""$string">>$timetablefullpath
   echo ""$UTC3"$ns""$string">>$timetablefullpath
   
   fi

   if [ "$ttentries" -eq "0" ]  || [ "$ttentries" -eq "1" ]; 
   then 
   echo ""$UTC1"$ns""$string">>$outpath$logs
   echo ""$UTC2"$ns""$string">>$outpath$logs
   echo ""$UTC3"$ns""$string">>$outpath$logs

   echo ""$UTC1"$ns""$string">>$timetablefullpath
   echo ""$UTC2"$ns""$string">>$timetablefullpath
   echo ""$UTC3"$ns""$string">>$timetablefullpath
  
   fi
# a "camel" sequence stamping
#stamped?

  
  #$command
  
  #"tmp_triggertimes.log" " "

 #       command= "bash "+self.testsscripts+"losed/t20ja-flat-stray.sh " +" --tmpdir "+ self.testpath \
#            + " " + b + " " \
#            + a +" #&"


return 0; }

# ticket_hrdf="20171024220700234152195"
# converted_utc_ns=hrdf_ns2hrdf_ns $ticket_hrdf
# echo "converted_utc_ns:" $converted_utc_ns
# #########

