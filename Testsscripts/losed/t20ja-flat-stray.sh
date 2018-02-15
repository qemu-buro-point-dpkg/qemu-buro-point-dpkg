#filename: t20ja-flat-stray.sh

#UI
#other names: shop?
# -aka "robust daemon shop": for arbitrary building functions 
# -aka a medical tool: in a field, where human spirit touches social world entities, such as "shop". "feelings of helpless confusion",while a "our system of temporal calculation silently and persistently encourages our terror of time" according to true gnu measurement:"our system of temporal calculation silently and persistently encourages our terror of time" https://www.gnu.org/software/coreutils/manual/html_node/Date-input-formats.html#Date-input-formats 
#- a "camel rabbit" symptome simulator for preventing happening of pseudoactivity
#- Feature: To a help a maybe superstitious bahavioral mechanism: activity such as set to do for the upcoming 3 months (or minutes) to care for the upcoming 3 month, each month renewed. 
#- snapping_stampupdating_respecting_user
#-organize maintaining a that any what ever function demos "into" a "1000 and 1 Nights"-Series-Galleries 
#- registering 3. party "handler" function capable 
#- for habitual usage just skip the shop windowing scheme 
#-robust: This is an organ, that is, it is grows from grass play area effort, seen to help when in ordinary, "shops" urges, and published rather btw, thus tested for robustness arguably 


#default
#cli
# cl like user configs with private pathes
#registering our handler path into session to vartmp?Home
#registering(no) our new tt into the cookie 
#reading tt from cookie(no)
 #loading all registered handlers at prerelaunch routine, wont you
#donot0-restart lauch


#pathes?
#cookies for everybody, a) necessary? handler cood grep tt path, or why not chain for invoking dämon
#
#

logs="logs" #
tmpdir="/tmp/qemuburotest/" #path for temporary and out put data?
mkdir "/tmp/qemuburotest" 2>/dev/null

#well lets try to regulate the juggle of a) timetables and b)handlers and what? c) a pipe-kind file to best distribute a tmp ini as quasi globals.

#default 0: naked in tmpdir
#default is $HOME/.ttconfig/ttcookies/ttcookie, that is a path to a installed timetable, among
#t20ja ttcookie and tmpini.sh
#3. .ttonfig could be turned to user's central .config/ and or ttcookie/ and or the single a)b)c). ingredients.   
#This seem overwhelming we will see.
#Default0 bare in pwd the
timetablefilename="tmp_triggertimes.log" #default0
#ttcookie
confroot=$HOME/
confstring0=".ttconfig/"
confstring1="ttcookies/"
#ttcookie.t20ja 
ttcookie="ttcookie" 
ramsh="tmpini.sh" #our database aka db
ttcookie_handler_to_register_name=".ttcookie.t20ja" 
timetablefullpath=""
#registering our handler path



# complete cookies?, so we should be equiped for reading and writing stamps? no? For default 1,2,3_ok?


testdebug="0" # derault off, since huge logs
installpath=$tmpdir #no
userconfigpath=$tmpdir #user configs default: read from output path
conffile="t20ja-flat-stray.userconfig.sh" #userconfigs default file name
#tbi default home test tmp, priv conigpath

dontrestart=0
fpttcookielock="1"


handlerpath="$Qemuburo_install_dir""Testsscripts/losed/Buildingloggerdemon.userconfig_for_camel.sh" # 

Buildingloggerdemonuserconfig="Buildingloggerdemon.userconfig_for_camel.sh"
userconfigpath="$Qemuburo_install_dir""Testsscripts/losed/"

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
        --samplerate)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                samplerate=$2
                shift
            fi
            ;;
        --galleryroot)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                galleryroot=$2
                shift
            fi
            ;;
        --binaryfullpath)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                binaryfullpath=$2
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
#         --timetokenx)       # Takes an option argument, ensuring it has been specified.
#             if [ -n "$2" ]; then
#                 timetoken=$2
#                 shift
#             fi
#            ;;
        --gifts)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                gifts=$2
                shift
            fi
            ;;
        --releasestring)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                releasestring=$2
                shift
            fi
            ;;
        --testtimecompressor)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                testtimecompressor=$2
                shift
            fi
            ;;
        --confroot)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                confroot=$2
                shift
            fi
            ;;
        --binarycall)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                binarycall=$2
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
#echo userconfigpath=$userconfigpath #" "$userconfigpath
for a in $userconfigpath;
    do test -f $a$conffile && source "$a""$conffile" $tmpdir
done 
tmpdir="/tmp/qemuburotest/"
cd "$tmpdir"

#timetable defaulting: cli, else config of app default else cookie 

#[ -f $timetablefullpath ] || 
timetablefullpath="$confroot""$confstring0""$timetablefilename"


#>>reading tt from cookie eventually, if still none exists
ttcookiefp="$confroot""$confstring0""$confstring1""$ttcookie"
[ -f $timetablefullpath ] || timetablefullpath=$(head "$confroot""$confstring0""$confstring1""$ttcookie"); 

#renew cookie-registering our handler path
echo -e $handlerpath>"$confroot""$confstring0""$confstring1""$ttcookie_handler_to_register_name"

demonup=$(ps ax|grep Buildingloggerdemon|grep -v "grep\|watch"|wc -l) 

#comment
echo -e \
"\n Programmname ""$(basename $0)" \
"\n FUNCNAME ""#""${FUNCNAME[*]}" \
"\n ttcookie_handler_to_register_name? ""$ttcookie_handler_to_register_name" \
"\n ttcockie fp? ""$ttcookiefp" \
"\n handlerpath? ""$handlerpath" \
"\n demonup? ""$demonup" \
"\n fpttcookielock? ""$fpttcookielock" \
"\n fpfoundhandler_to_load? ""$fpfoundhandler_to_load" \
"\n self_unwished_pattern? ""$self_unwished_pattern" \
"\n timetablefullpath? "  "$timetablefullpath" \
>>"$tmpdir""logs"

#The last opportunity db write before launch 
[ -d "$confroot"".ttconfig/" ] || mkdir  "$confroot"".ttconfig/"
declare -p|grep "\-\-"|sed -e "s/declare -- //"|grep "=\".*\""|grep -v "declare" >"$confroot"".ttconfig/""$ramsh"

sync;

echo "declare -p|grep "\-\-"|sed -e "s/declare -- //" >"$confroot"".ttconfig/""$ramsh" #
">>"$tmpdir""logs"

if [ "$dontrestart" -eq "0" ] || [ "$demonup" -eq "0" ]; 
then 
    #kill eventual running daemon
    a=$(ps ax|grep Buildingloggerdemon|grep -v "grep\|watch"|cut -c -6)
    test "$a" != "" && kill -9 $a
    
    #date>>"$tmpdir""logs"
    echo "# date of damon (re)start $(date +'%Y-%m-%d %H:%M:%S')”">>"$tmpdir""logs"
    #tbi
    nic="nice -19"
    command=""$nic" bash ""$Qemuburo_install_dir""Testsscripts/buildingdamon/Buildingloggerdemon.sh --tmpdir /tmp/qemuburotest/ --samplerate "$samplerate" --conffile ""$Buildingloggerdemonuserconfig"" --triggertimeslogs ""$timetablefullpath"" --userconfigpath ""$userconfigpath"
    echo $command >>"$tmpdir""logs"
    $command&
else
    echo '$dontrestart" -eq "0" ] || [ "$demonup" -eq "0" ]"'"$dontrestart" -eq 0 ] || [ "$demonup" -eq "0" ]; 
fi;
       
  
 