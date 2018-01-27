
# another "handler" function: needed for tests
demogreeter1 () {
    demo=$1; 
    echo "Layer 5 buildinhandler2 Hello "$demo
return; }

#fehler
greetervar=demogreeter 

tmpdir="$HOME/Downloads"

logs="logs" #
sample_run_counter=0
tmpdir="/tmp/qemuburotest/" #path for temporary and out put data?
mkdir "/tmp/qemuburotest" 2>/dev/null

# timetoken="150887562023415219500"
# samplerate=1 # seconds sleeping between firing (sleep builtin)
# 
# triggertimeslogs="tmp_triggertimes.log" # file name of (future) events list 
# 
# functionname="demogreeter"
# comment="demogreeter0"
# 
# execution_stamp_prefix="a"$sample_run_counter"a" # to use a timetable and a program data base alike
# execution_stamp_postfix="Ω"$every_offset_ns"Ω"$times1"Ω"$functionname"Ω"$comment"Ω" # 
# 
# 
# tokenarray="" #inner variable, list of acute tokens found at sampling time
# date_format="%s%N" #for date utc with nanoseconds
# 
# # "every" (tuesday)" function of a human user interface
# sectonanoconverter="000000000"
# every_offset_sec=360000000 #if in "every"-User-mode: alternating unending mode
# #*60*60*24*7,*365 #every n days, year, not week, weekdays, month, years, 
# 
# every_offset_ns=$every_offset_sec$sectonanoconverter
# times1=2 #event decrementer
# 
# 
# nexttimetoken="" #inner, next token to set in repition mode
# file_offset=0 #line number, where uncommented switches to commented,inner variable
# file_length=0 #of time table inner variable

testdebug="0" # derault off, since huge logs
installpath=$tmpdir #no
userconfigpath=$tmpdir #user configs default: read from output path
conffile="t20ja-flat-stray.userconfig.sh" #userconfigs default file name

timetablefullpath="$Qemuburo_install_dir""/Testresources/tmp_triggertimes.log"

dontrestart=0
#default, to be modified in use case
#snipped according
#/abs-guide.html#STANDARD-OPTIONS
#G.1. Standard Command-Line Options

while :; do
    case $1 in
        -h|-\?|--help)   # Call a "show_help" function to display a synopsis, 
            #then exit.
            exit
            ;;
        -t|--tmpdir)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                tmpdir=$2
                shift
            fi
            ;;
        --dontrestart)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                dontrestart=$2
                shift
            fi
            ;;
        --timetoken)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                timetoken=$2
                shift
            fi
            ;;
        --every)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                every_offset_ns=$2
                shift
            fi
            ;;
        --times)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                times1=$2
                shift
            fi
            ;;
        --testdebug)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                testdebug=$2
                shift
            fi
            ;;
        --userconfigpath)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                userconfigpath=$2
                shift
            fi
            ;;
        -v|--verbose)
            echo hello2
            verbose=$((verbose + 1)) # Each -v argument adds 1 to verbosity.
            ;;
        --)              # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)               # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done


#read a userconfig default from output dir, tb completed to a debian standard
cd $tmpdir
echo userconfigpath=$userconfigpath #" "$userconfigpath
  for a in $userconfigpath;
      do time test -f $a$conffile && source $a$conffile $tmpdir
  done 
#source /tmp/qemuburotest/Buildingloggerdemon.userconfig.sh 

#we fill the logs of a def test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example(self):
echo PPool$PPool RANGE$RANGE dup$dup stage1batchmode$stage1batchmode Slot$Slot startstage$startstage > $PPool"logs"

# #userconfigpath=$userconfigpath" "$userconfigpath
#   for a in $userconfigpath;
#       do time test -f $a$conffile && source $a$conffile $tmpdir
#   done 

#scrap from voult spezification see stamp to db format
#echo "hello "$Qemuburo_install_dir"Testsscripts/losed/""driver_fault2db.sh"
tmpdir="/tmp/qemuburotest/"
cd "$tmpdir"
#tbi
voultfilename="doctemp004-p003.tiff" #twgc-format

voultfile=$tmpdir$voultfilename
#echo "hello $voultfile"

   demonup=$(ps ax|grep Buildingloggerdemon|grep -v "grep\|watch"|wc -l) 
   b=$(wc -l <logs)
   c=$(wc -l <logs)
   
   a=4
   b=1
   c=1
   
   #c=$(wc -l <tmpfile$inc"adds")
   #if contact from voult gets email, 3 lines address and sexualized addressee
   echo $a " b" $demonup
   
   if [ "$dontrestart" -eq "0" ] || [ "$demonup" -eq "0" ]; 
   then 
   echo "restart demon   ""$timetablefullpath""ll"; 
#    Layer -1 
   kill -9 $(ps ax|grep Buildingloggerdemon|grep -v "grep\|watch"|cut -c -6)
   #bash "$Qemuburo_install_dir""Testsscripts/buildingdamon/Buildingloggerdemon.sh --tmpdir /tmp/qemuburotest/ --samplerate 5.005 --timetoken 1516938449858029610 --every 5000000 --times 1  --testdebug 0 --triggertimeslogs ""$timetablefullpath"" &"
   Buildingloggerdemonuserconfig="Buildingloggerdemon.userconfig_for_camel.sh"
   userconfigpath="$Qemuburo_install_dir""Testsscripts/losed/"
   date>>"$tmpdir""logs"
   echo "date above">>"$tmpdir""logs"
   command="bash ""$Qemuburo_install_dir""Testsscripts//buildingdamon/Buildingloggerdemon.sh --tmpdir /tmp/qemuburotest/ --samplerate 5.005 --every 5000000 --times 1 --conffile ""$Buildingloggerdemonuserconfig"" --testdebug 0 --triggertimeslogs ""$timetablefullpath"" --userconfigpath ""$userconfigpath"' &'
   echo $command >>"$tmpdir""logs"
   $command&
      #
  #echo " bash "$Qemuburo_install_dir"Testsscripts//buildingdamon/Buildingloggerdemon.sh   --tmpdir /tmp/qemuburotest/ --samplerate 5.005 --timetoken 1516948599402985606 --every 5000000 --times 1 --conffile $Buildingloggerdemonuserconfig --testdebug 0 --triggertimeslogs "$timetablefullpath"" --userconfigpath ""$userconfigpath" &" >>"$tmpdir""logs"
      #
    # Layer -1 kill: date; ps ax|grep Buildingloggerdemon.sh|grep -v grep;kill $(ps ax|grep Build|cut -c -6)
   #echo $inc1>>"$tmpdir"'logs'
   #cat logsdriver
   else
      echo '$dontrestart" -eq "0" ] || [ "$demonup" -eq "0" ]"'"$dontrestart" -eq 0 ] || [ "$demonup" -eq "0" ]; 
   fi;
       
ps ax|grep Buildingloggerdemon|grep -v "grep\|watch"|tee $tmpdir"logs.testdaemonup">>"$tmpdir"'logs';
  
   
   #1508875620234121950ΩΩΩmydemogreeterΩdemogreeter4Ω

#Rückfragen und Bewerbungen an

# token="ückfrage"
# #qRückfragen und Bewerbungen an
# tokenend="Bewerbungsarten"
# tokenend=[0-9][0-9][0-9][0-9][0-9]
###1
#cat $voultfile|sed -n "/$token/,/$tokenend p"
#i1nc1+=0
# for (( expr1 ; expr2 ; expr3 )) ; do list ; done
# for ((inc=0;inc<10;inc++)); do
#    #echo  
#    cat $voultfile|sed -n "/###$inc/,/###`expr $inc + 1`/p" >tmpfile$inc 
#    #echo $inc
#    #addressee seperate
#    cat tmpfile$inc|grep "^Herr\|^Frau"|head -1>tmpfile$inc"addressee"
#    #email seperated, there is email in format
#    cat tmpfile$inc|grep "@"|head -1>tmpfile$inc"adds"
#    #promis snipped window
#    cat tmpfile$inc|grep "ID[-: ]\|[0-9]\{8,\}-" |head -1>tmpfile$inc"subjectads"
#    cat tmpfile$inc|sed -n "/$token/,/$tokenend/p">tmpfile_$inc
#    # 4 line above postal with window
#    cat tmpfile_$inc|grep "[0-9][0-9][0-9][0-9][0-9]" -B 4 |grep -v ück>tmpfile$inc"address"
#    #vaultstatusreportword_fulladdressqualityok="0111000101"
#    #adresse
#    #cat tmpfile_$inc|grep "[0-9][0-9][0-9][0-9][0-9]" -B 4 |grep -v ück
#    #email?
#    a=$(wc -l <tmpfile$inc"address") 
#    b=$(wc -l <tmpfile$inc"addressee")
#    c=$(wc -l <tmpfile$inc"adds")
#    #if contact from voult gets email, 3 lines address and sexualized addressee
#    #echo $a " b" $b
#    if [ "$a" -gt "2" ] && [ "$b" == "1" ]  && [ "$c" == "1" ]; 
#    then 
#    #echo "hello a3 b1"; 
#    cp tmpfile$inc"addressee" "tmpfile""$i1nc1""__addressee"
#    cp tmpfile$inc"address" tmpfile"$i1nc1"__"address"
#    cp tmpfile$inc"adds" tmpfile"$i1nc1"__"adds"   
#    cp tmpfile$inc"subjectads" tmpfile"$i1nc1"__"subjectads" 
#    let i1nc1+=1
#    echo $inc1>>"$tmpdir"'logs'driver
#    #cat logsdriver
#    fi;
#    done; 
   
