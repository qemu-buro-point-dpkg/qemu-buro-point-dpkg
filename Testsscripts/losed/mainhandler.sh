#layout of code: this
###globals
###hoursoccultism
### production 
### tt write
### gallerying

#default Policies collected meanwhile
# 46:#db read at start, a policy
# 108:#k Release-Clustering Policy I future_shop events, ease Policy:simply 1 month shift
# 282:    #snap Policy 2: default: if found a release of same month as presnaps, take found date for datestamp
# 297:#tbi/Policy respect user defaults of nextreleasedirs.. everything, when used
# 399:# presmear defaults policy,Generate 8 numbers pattern for presnapping: policy 4
#default Policies collected meanwhile



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

tmpdir="/tmp/qemuburotest/"
ns="000000000"
timetablefullpath="" #just a default for test

#db read at start, a policy
confroots="$Qemuburo_install_dir ""/tmp/qemuburotest/ ""$HOME/ ""$private_of_qemu ";
ramsh1=""
for confroot1 in $confroots; 
do 
ramsh="$confroot1"".ttconfig/tmpini.sh"; 
#echo $ramsh; 
[ -f "$ramsh" ] && ramsh1=$ramsh; 
done;
. "$ramsh1";
#db read at start

###globals
echo -e \
"Programmname ""$(basename $0)" \
"#### FUNCNAME ""#""${FUNCNAME[*]}" \
>>"$tmpdir""logs"

outpath="/tmp/qemuburotest/"
logs="logs"

mydemog="mydemogreeter" #mydemogreeter_releasedirectory150313
exe="yournextgnuclihelloprojectdemo.sh"
datestamps_presnap="150323 150424 150525"
datestamps="" #prepared to stamp tt
datestamps_found="150319 150418" #of found release dirs on disk ,defaults for test

usertimewindowutcstart="now" #default now, unused
intervallsbetween=2; # cycle for ever: a nsutc

# unused scheme: space of time 
na=0
nmon=3
betweenmonths=$na*12+$nmon
utcdate_nextbetweenmonth=""
nw=0
w=7
nd=0
d=0
nh=0
h=0
nmin=0
min=0
nsec=0
sec=0
utcweeksbetween=$nw*$w+$nd*$d+$nh*$h+$nmin*$min+$nsec*$sec


# used scheme: middlemonth, space of time 
let chapters=4*12 #the average of a months
let fouryearsseconds=(365*4+1)*24*60*60
let secondsdurationsofintervall=$fouryearsseconds/$chapters

vaultsdir="voults/" #hopefully ordered accourding to shop's sequencing scheme
fpvaultsdir="$tmpdir""$vaultsdir"
dirname_str="_releasedirectory"
ttentries_future="tt ttp ttentryp"
current_time_table_entries_utc_trigger_time="1508875620234121950"

ttentries="" #found ttentries of shop
current_time_table_entries="" 
current_time_table_entries_utc_trigger_time="" # central imput parameter for cluster stamps time calculations , the youngest sorted , probably among the opened"
#k Release-Clustering Policy I future_shop events, ease Policy:simply 1 month shift
#tbi customsmearstamp="$relativedate""_collection"
# pre_smeared__gallery_fp_target_dir
# -o 
#tbi ttentries right date
#
#presnap_gallery_this_month_next_month_strips

releasedirs="§% fgs aad" #optionally defined by user

userconfigpath=$tmpdir #user configs default: read from output path

conffile="mainhandler.userconfig.sh" #userconfigs 
nextreleasedirs="mydemogreeter_releasedirectory150313/ mydemogreeter_releasedirectory150412/ mydemogreeter_releasedirectory150512/"
found_releasedirs=""


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
        --releasedirs)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                releasedirs=$2
                shift
            fi
            ;;
        --conffile)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                conffile=$2
                shift
            fi
            ;;
        --userconfigpath)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                userconfigpath=$2
                shift
            fi
            ;;
        --mydemog)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                mydemog=$2
                shift
            fi
            ;;
        --exe)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                exe=$2
                shift
            fi
            ;;
        --mydemog)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                mydemog=$2
                shift
            fi
            ;;
        --fpvaultsdir)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                fpvaultsdir=$2
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

for a in $userconfigpath;
    do test -f $a$conffile && source $a$conffile $tmpdir
done 


###hoursoccultism on
# #template measured inline sed
# a finer time?
# ns time elapsed n5:1551204
# ns time elapsed n6:3130579
# 
# name='joshua'
# 
# n1=$(date +%s%N)   
# 
# echo "$name"|sed -e "s/\([ao].*\)\([oa]\)/X\1X\2/"
# 
# n2=$(date +%s%N)
# 
# let n6=$n2-$n1
# echo "ns time elapsed n6:""$n6">>"$tmpdir""logs"
# 
# n3=$(date +%s%N)
# [[ $name =~ ([ao].*)([oa]) ]] && \
#      echo ${name/$BASH_REMATCH/X${BASH_REMATCH[1]}X${BASH_REMATCH[2]}}
# n4=$(date +%s%N)
# let n5=$n4-$n3
# echo "ns time elapsed n5:""$n5">>"$tmpdir""logs"
# 




##snap attempt 1
#strap cenral input parameter
ttentries=$(cat $timetablefullpath|grep "^[0-9]"|grep "$mydemog"|uniq|sort -r)
# echo $ttentries"=ttentries" #>>$outpath$logs
# echo "$timetablefullpath""=timetablefullpath" #>>$outpath$logs
#cat $timetablefullpath|grep "^[0-9]"|grep "$mydemog"
ttentrie_h=$(cat $timetablefullpath|grep "^[0-9]"|grep "$mydemog"|uniq|sort -r|head)
[[ $ttentrie_h =~ .*(^[0-9][0-9][0-9][0-9][0-9][0-9]*).* ]] && \
     current_time_table_entries_utc_trigger_time=${BASH_REMATCH[1]}

i3=$current_time_table_entries_utc_trigger_time 
utc_datestamps_presnap=$i3
for (( i=0; i < $intervallsbetween; i++ )) 
do
    let i3+="$secondsdurationsofintervall""$ns"
    utc_datestamps_presnap+=" $i3"
done 

datestamps_presnap=""
for ticket_utc in $utc_datestamps_presnap; do
#ticket_utc="150887562023415219500"
converted_hrdf_ns=$(utc_ns2hrdf_ns "$ticket_utc""$ns") # ...??
datestamps_presnap+=" ""${converted_hrdf_ns:0:8}"
done


#attemps strap file 1
name1="$mydemog""$dirname_str"
path=$tmpdir
found_releasedirs=$(find $tmpdir -maxdepth 1 -name "*$name1*")

datestamps_found=""
for frd in $found_releasedirs; do
# [[ $frd =~ .*([0-9]\{8\}).* ]] && \
#      datestamps_found+=" ""${BASH_REMATCH[1]}"
[[ $frd =~ .*([0-9]{8}).* ]] && \
     datestamps_found+=" ""${BASH_REMATCH[1]}"
done;

datestamps=$datestamps_presnap
for i_found in $datestamps_found; 
do 
    #echo "is there any element snapping to me in the other array?";
    for i_presnap in $datestamps_presnap; 
    do 
    #echo "I am any element snapping here in this other array?";
    #layout for not-month-snapping: space of time snapping still unused
    utci=""
    utci1=""
    utci1upper=""
    utci1lower=""
    
    #snap Policy 2: default: if found a release of same month as presnaps, take found date for datestamp
   
    days_humansformati=${i_presnap:4:2}
    days_humansformati1=${i_found:4:2}

    if [ "$days_humansformati" != "$days_humansformati1" ]; 
    then
    echo "he" >/dev/null
    else
        datestamps=${datestamps//$i_presnap/$i_found}
        datestamps1=${datestamps//"$i_presnap"/"$i_found"}
    fi;    
    done;
done;
#format: mydemogreeter_releasedirectory150313
#tbi/Policy respect user defaults of nextreleasedirs.. everything, when used
nextreleasedirs=""
for i in $datestamps; do
nextreleasedirs+=" $mydemog""$dirname_str""$i"
done
## Production part end

##Generation of the future tt entrys start
#first acchieve a utc row 
socket="$secondsdurationsofintervall""$ns"
n_future_entrys=2
let utc_future_datestamps_presnap=$current_time_table_entries_utc_trigger_time+$socket
firstentry=$utc_future_datestamps_presnap
for (( i=0; i < $n_future_entrys; i++ )) 
do
let firstentry+="$socket"
utc_future_datestamps_presnap+=" $firstentry"
done 

future_shop_tt_stamps=""
for i in $utc_future_datestamps_presnap; do
    # tbi :date -uct %t? or function hzui?
    i1=$(utc_ns2hrdf_ns $i)
    future_shop_tt_oddhumandate=${i1:2:12}  #171024220700
    future_shop_tt_comment="$mydemog""4-""$future_shop_tt_oddhumandate""-""Ω"
    future_shop_tt_ticket="$i""ΩΩΩ""$mydemog""Ω""$future_shop_tt_comment"
    future_shop_tt_stamps+=" ""$future_shop_tt_ticket"
done
#declare -p | grep "future_shop_tt_"
##Generation of the future tt entrys off

##voults start
#source datestamps of voults
presnap_voults_name_date=$datestamps_presnap


found_voults_names=$(find $fpvaultsdir -maxdepth 1 -name "*[a-z]*" -type f|tr "\n" " ")

found_voults_dates=""
for fvd in $found_voults_names; do
[[ $fvd =~ .*([0-9]{8}).* ]] && \
     found_voults_dates+=" ""${BASH_REMATCH[1]}"
done;


#snapping vaults now on
#template corset on
voults_name_date1=$presnap_voults_name_date

#tokenize array
for i in $voults_name_date1; do
voults_name_date+=" -""$i"
done

#controll_voults_counter
for i_found in $found_voults_dates; 
do 
    for i_presnap in $presnap_voults_name_date; 
    do 
    days_humansformati=${i_presnap:4:2}
    days_humansformati1=${i_found:4:2}
    if [ "$days_humansformati" != "$days_humansformati1" ]; 
    then
    echo "he" >/dev/null
    else
        #echo snap case"
        voults_name_date=${voults_name_date//"-"$i_presnap/$i_found}
        voults_name_date1=${voults_name_date//"-""$i_presnap"/"$i_found"}
    fi;    
    done;
done;
#template
#snapping vaults off
#find a void place, stuff it with found
vault_tocopyfrom=$(echo $voults_name_date1|tr " " "\n" |grep -v "-"|wc -l)
vault_voids=""
vault_voids=$(echo $voults_name_date1|tr " " "\n" |grep -v "-"|head -1)


if [ "$vault_tocopyfrom" != "" ]; then
voults_name_date2=$(echo $voults_name_date1|sed -e "s/-[0-9]\{8\}/$vault_voids/g")

else
    echo "warn ""no voult found"
    #exit
fi
#declare -p|grep "\-\-"|grep "vault\|voult"
#grep those of token to exit
#voultname generation output
for i in $voults_name_date2; do
    #echo $i
    fpvoult=$(echo $found_voults_names | tr " " "\n"|grep "$i"|head -1) #"
    fp_voults+=" "$fpvoult
done

#corsett of
##voults off
#declare -p|grep "\-\-"|grep "vault\|voult" #\|gallery"


##-gallery on
gallery_source_dirs="$nextreleasedirs"

# presmear defaults policy,Generate 8 numbers pattern for presnapping: policy 4

#give first of presnap and decrement
let gallery_preceding_space_of_time_utc="$current_time_table_entries_utc_trigger_time"-"$secondsdurationsofintervall""$ns"
a=$gallery_preceding_space_of_time_utc ;gallery_utcsec=${a::-9};

gallery_preceding_space_of_time_eigth_char_date=$(date -d @"$gallery_utcsec" +%Y%m%d); 


gallery_presnap_eightchardatedays="$gallery_preceding_space_of_time_eigth_char_date"" """"$datestamps_presnap"

relativedate=(passed-month this-month next-month after-next-month)

inc=0
for eightchardateday in $gallery_presnap_eightchardatedays; do  
    originalname=$mydemog
    presnapped_relativedate="upcoming" 
    #echo "${relativedate[inc]}"
    relativedate1="${relativedate[inc]}"
    #relativedate1=""
    customsmearstamp="$relativedate1""_collection"
    let inc+=1
    gallery_dir=" ""$galleryroot""$originalname"__"$customsmearstamp""__""$eightchardateday""/"
    gallery_fp_presmear_target_dirs+=$gallery_dir
    gallery_fp_target_cherryfilename1s+=" ""$gallery_dir""theoffer"
    gallery_fp_target_cherryfilename2s+=" ""$gallery_dir""productionreport.txt"
    gallery_fp_target_cherryfilename3s+=" ""$gallery_dir""1.txt"
done

for i in $gallery_source_dirs; do
    gallery_fp_source_filename1s+=" ""$tmpdir""$i""/""output1.txt"
    gallery_fp_source_filename2s+=" ""$tmpdir""$i""/""report.txt"
    gallery_fp_source_filename3s+=" ""$tmpdir""$i""/""output2.txt"
done

# there is no snapping in gallerying
##to put apart before cleaning 
#last this-month gallery dir 
fp_galery_found_ante_galery_dir=$(find $galleryroot|grep -e "${relativedate[1]}"|head -1)

#transform to array, then put 1 element to input slot
gallery_fp_presmear_target_dirs1=($gallery_fp_presmear_target_dirs)
fp_galery_presmear_ante_dir=${gallery_fp_presmear_target_dirs1[0]}

##to collect dirs for cleaning 
#prepare a grep string for command below
galerie_presmear_greprm=9797233g
for i in ${relativedate[@]:1}; do
    galerie_presmear_greprm+="\|""$i"
done

#removearray generation
fp_found_galary_presmear_to_remove_outdated_dirs=$(find $galleryroot -maxdepth 1|grep -e "$galerie_presmear_greprm"|tr "\n" " ")

#end presmearing
gallery_fp_target_dirs=$gallery_fp_presmear_target_dirs

#convert to array at last, too
gallery_fp_target_dirs1=($gallery_fp_target_dirs)
gallery_fp_target_cherryfilename3s1=($gallery_fp_target_cherryfilename3s)
gallery_fp_target_cherryfilename2s1=($gallery_fp_target_cherryfilename2s)
gallery_fp_target_cherryfilename1s1=($gallery_fp_target_cherryfilename1s)
gallery_fp_source_filename1s1=($gallery_fp_source_filename1s)
gallery_fp_source_filename2s1=($gallery_fp_source_filename2s)
gallery_fp_source_filename3s1=($gallery_fp_source_filename3s)

##-gallery off

#hoursoccultism off


# # # # #we got a signal of a shop, we need to provide a "dead rabbit run" pattern


#maintainance 1(production): feed process with vault, get vault line + releasedirs line array 2. fill with builds a shop directory structure  
# # # #    


fp_production_vaults=$fp_voults


nextreleasedirs=${nextreleasedirs//" "/"|"}
fp_production_vaults=${fp_production_vaults//" "/"|"}

#tbi prerelease work bow pointer to pathb="Testresources/" production_command1
patha="Testresources/"
#patha="Testsscripts/"


production_command1="bash "$Qemuburo_install_dir""$patha""$exe" --releasedirs ""$nextreleasedirs"" --fp_production_vaults ""$fp_production_vaults"

echo $production_command1>>$outpath$logs
nic="nice -19"
$nic $production_command1

name1="$mydemog""$dirname_str"
path=$tmpdir
found_production_dirs1=$(find $tmpdir -maxdepth 1 -name "*$name1*"|tr "\n" "|")

#maintainance 1 call end

##tt three incs:
for i in $future_shop_tt_stamps; 
do
grep "$i" $timetablefullpath>/dev/null || echo -e "$i">>$timetablefullpath

done

##tt 4 shop incs:

#gallery maintainance: save new to oldest,
mv $fp_galery_found_ante_galery_dir $fp_galery_presmear_ante_dir 2>/dev/null
#clean advertized stuff now
rm -r $fp_found_galary_presmear_to_remove_outdated_dirs 2>/dev/null


#load new gallery update from production
inc=0
for i in $gallery_source_dirs; do
let inc+=1
mkdir ${gallery_fp_target_dirs1[$inc]} 2>/dev/null
let inc0=$inc-1
#declare -- gallery_fp_target_cherryfilename3s=" /tmp/qemuburotest/mydemogreeter___collection__20180223/1.txt"

cp -f ${gallery_fp_source_filename1s1[$inc0]} ${gallery_fp_target_cherryfilename1s1[$inc]}
cp -f ${gallery_fp_source_filename2s1[$inc0]} ${gallery_fp_target_cherryfilename2s1[$inc]}
cp -f ${gallery_fp_source_filename3s1[$inc0]} ${gallery_fp_target_cherryfilename3s1[$inc]}
# 

done

#declare -p|grep "\-\-"|grep "gallery_fp" #\|gallery"
### test debug extra output

[ "$timetablefullpath" == "" ] || echo -e "d">>"$tmpdir""robusttest.extra.log"

echo "Laye"$demo"r 7""$triggertimeslogs"" gree evenz##mainhandler_hello">>$outpath$logs
