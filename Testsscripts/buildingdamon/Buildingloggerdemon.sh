#Name Buildingloggerdemon.sh
#Function: this is another daemon for building purposes
# It issues handled events, such as text print out on screen, in time stamping manner.

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

#########
# a "handler" function: functional demo
demogreeter () {
demo=$1; 
    echo "Layer 5 buildinhandler1 Hello "$demo
return; }
# another "handler" function: needed for tests
demogreeter1 () {
    demo=$1; 
    echo "Layer 5 buildinhandler2 Hello "$demo
return; }


greetervar=demogreeter 

tmpdir="$HOME/Downloads"

logs="logs" #
sample_run_counter=0
tmpdir="/tmp/qemuburotest/" #path for temporary and out put data?
mkdir "/tmp/qemuburotest" 2>/dev/null

timetoken="150887562023415219500"
samplerate=1 # seconds sleeping between firing (sleep builtin)

triggertimeslogs="tmp_triggertimes.log" # file name of (future) events list 

functionname="demogreeter"
comment="demogreeter0"

execution_stamp_prefix="a"$sample_run_counter"a" # to use a timetable and a program data base alike
execution_stamp_postfix="Ω"$every_offset_ns"Ω"$times1"Ω"$functionname"Ω"$comment"Ω" # 


tokenarray="" #inner variable, list of acute tokens found at sampling time
date_format="%s%N" #for date utc with nanoseconds

# "every" (tuesday)" function of a human user interface
sectonanoconverter="000000000"
every_offset_sec=360000000 #if in "every"-User-mode: alternating unending mode
#*60*60*24*7,*365 #every n days, year, not week, weekdays, month, years, 

every_offset_ns=$every_offset_sec$sectonanoconverter
times1=2 #event decrementer


nexttimetoken="" #inner, next token to set in repition mode
file_offset=0 #line number, where uncommented switches to commented,inner variable
file_length=0 #of time table inner variable

testdebug="0" # derault off, since huge logs
installpath=$tmpdir #no
userconfigpath=$tmpdir #user configs default: read from output path
conffile="Buildingloggerdemon.userconfig.sh" #userconfigs default file name

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
        --samplerate)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                samplerate=$2
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
       --conffile)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                conffile=$2
                shift
            fi
            ;;
        --userconfigpath)
        # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                userconfigpath=$2
                shift
            fi
            ;;
       --triggertimeslogs)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                triggertimeslogs=$2
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
#userconfigpath=$userconfigpath" "$userconfigpath
  for a in $userconfigpath;
      do time test -f $a$conffile && source $a$conffile $tmpdir
  done 
#source /tmp/qemuburotest/Buildingloggerdemon.userconfig.sh 
#echo "Layer 0 sample_run_counter userconfigpath "
#mydemogreeter "skoll" 

#echo "Layer 0 sample_run_counter userconfigpath "$userconfigpath "conffile "$a$conffile #`test -e $conffile`
cd $tmpdir

#initialize db databas with options and timetoken
#echo "Layer 0 sample_run_counter $sample_run_counter before "$(cat $triggertimeslogs) |tr " " "\n"
execution_stamp_postfix="Ω"$every_offset_ns"Ω"$times1"Ω"$functionname"Ω"$comment"Ω" #"Iamanoption"
echo "echo "$timetoken""$execution_stamp_postfix">>$triggertimeslogs"
echo "$timetoken""$execution_stamp_postfix">>$triggertimeslogs
sort -n $triggertimeslogs>tmp.1
mv tmp.1 $triggertimeslogs


#echo "Layer 0 sample_run_counter $sample_run_counter #adds to logs as requested  ""timetoken""  execution_stamp_postfix""$timetoken""$execution_stamp_postfix"
#echo "Layer 0 sample_run_counter $sample_run_counter "$(cat $triggertimeslogs) |tr " " "\n"

#echo "Layer 0 sample_run_counter $sample_run_counter #server runs"
while true; do echo "helo">/dev/null 

    let sample_run_counter+=1
    #echo "Layer 1 sample_run_counter $sample_run_counter ########new samplerate run "$sample_run_counter

    #a data base read of a few lines
    tokenarray=`sort -n $triggertimeslogs|tee tmp.1|grep "^[1-9]"`
    echo "$tokenarray">>"testdb"$sample_run_counter"_""tokenarray"
    #echo "Layer 1 sample_run_counter $sample_run_counter we got tokenarray "$tokenarray 
    l1_incr=0
    for dbtoken in $tokenarray;  # logical Layer 2 sample_run_counter $sample_run_counter: open tickets
        do 
        let l1_incr=+1  
        
        timetoken=`echo $dbtoken|sed -e "s/\(^[1-9].*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω/\1/"`
        every_offset_ns=`echo $dbtoken|sed -e "s/\(^[1-9].*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω/\2/"`
        times1=""
        times1=`echo $dbtoken|sed -e "s/\(^[1-9].*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω/\3/"`
        functionname=`echo $dbtoken|sed -e "s/\(^[1-9].*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω/\4/"`
        comment=`echo $dbtoken|sed -e "s/\(^[1-9].*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω\(.*\)Ω/\5/"`
        #echo "Layer 2 sample_run_counter $sample_run_counter times1 every_offset_ns  timetoken functionname comment "$times1 $every_offset_ns  $timetoken $functionname $comment
        
        a=$timetoken    
        b=$(date +$date_format)
        #echo "Layer 2 sample_run_counter $sample_run_counter asked for time token a $a lesser than  now b $b   every_offset_ns $every_offset_ns times1 $times1" 
        if [ "$a" -lt "$b" ]; then  # logical Layer 3 sample_run_counter $sample_run_counter: search first acute among Tickets
            #echo "Layer 3 sample_run_counter $sample_run_counter $a -lt $b \# lesser than";   
            #echo "Layer 3 sample_run_counter $sample_run_counter #(lesser than in an arithmetic comparison happening)"; 
            #echo "Layer 3 sample_run_counter $sample_run_counter in this case register ticket's expiring"
            #echo "Layer 3 sample_run_counter $sample_run_counter cat triggertimeslogs before an register"; cat $triggertimeslogs
            
            #$greetervar "skoll"; #echo skoll
            $functionname "skoll" $comment
            #Project timetable sorting policy (obsoleted itsself, )
            #file_offset=0;file_offset=$(cat tmp_triggertimes.log |grep -n "^[1-9]"|head -n1|cut -d":" -f1);
            #echo $file_offset
            # what does this "spell"? "comment uppest uncommented!"
            #stamp execution of obsoleting timetoken, case at it very timetable data base place: it gets a prefix
            execution_stamp_prefix="a"$sample_run_counter"a" #$timetoken # to use a timetable and a program data base alike
            execution_stamp_postfix="Ω"$every_offset_ns"Ω"$times1"Ω"$functionname"Ω"$comment"Ω" # 
            
            timetable_line_format="$timetoken""$execution_stamp_postfix"
            sed -i $triggertimeslogs -e "s/\($timetable_line_format\)/$execution_stamp_prefix$timetoken$execution_stamp_postfix/"
            #echo "Layer 3 sample_run_counter $sample_run_counter cat triggertimeslogs after an register"; cat $triggertimeslogs
            
            if [ "$times1" != "" ] && [ $times1 -ne 0 ]; then ## logical Layer 4 sample_run_counter $sample_run_counter: are their renewal option for to stay present in the timetable ? Whileforifif
            #abs-guide.html: logical (boolean) operators for "Compound Condition Tests Using"

                let nexttimetoken=$timetoken+$every_offset_ns
                #echo "Layer 4 sample_run_counter $sample_run_counter ******** add the next ticket to the wait loop nexttimetoken=timetoken+every_offset_ns "$nexttimetoken"="$timetoken"+"$every_offset_ns"  "$times1
                let times1-=1
                #echo "Layer 4 sample_run_counter $sample_run_counter "$times1
                
                ##            echo "Layer 4 sample_run_counter $sample_run_counter next time token: 0:10 "${nexttimetoken:0:10}"  :10:9 "${nexttimetoken:10:9}"  {#"${#nexttimetoken}
                #tbi enhance nothing very old, too old: hi 
                #echo "Layer 4 sample_run_counter $sample_run_counter cat triggertimeslogs"; cat $triggertimeslogs
                
                execution_stamp_postfix="Ω"$every_offset_ns"Ω""$times1""Ω"$functionname"Ω"$comment"Ω"
                echo "$nexttimetoken""$execution_stamp_postfix">>$triggertimeslogs
                sort -n $triggertimeslogs>tmp.1
                mv tmp.1 $triggertimeslogs
            fi
        fi

    done;
    # f1509699543
    # f2508690543

    if [ "$testdebug" = "1" ]; then
        # # # "Test mode Layer 1 sample_run_counter $sample_run_counter result vector to logs"
        echo "sample_run_counter "$sample_run_counter"  b:"$b>>$logs
        #tbi switched of in non --testverbose mode
    fi

    sleep $samplerate; 
done
