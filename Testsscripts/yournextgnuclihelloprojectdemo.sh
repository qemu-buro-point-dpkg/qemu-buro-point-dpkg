#Function: template or demo bash file
#Features: cli, configs, non default, multiple directories
#adds a line in an output file

#snipped according
#/abs-guide.html#STANDARD-OPTIONS
#G.1. Standard Command-Line Options

#Do not worry about the naming, it is just for demoing here.
PPool="$HOME/Downloads"
RANGE=1 # number of staples 
dup=2 # duplex=2 else 1, beidseitig
stage1batchmode="0" #run one paper staple in without questioning user
Slot="--source ADF" #take papers not from flatbed
startstage="startstage1" #do not scan! Take images from path

tmpdir="/tmp/qemuburotest/"
releasedirs="§%" #default to ignore enterandcreateifnecessarymode

userconfigpath=$tmpdir #user configs default: read from output path

conffile="yournextgnuclihelloprojectdemo.userconfig.sh" #userconfigs 

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
        --fp_production_vaults)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                fp_production_vaults=$2
                shift
            fi
            ;;
        --startstage)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                startstage="startstage2"
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

#we fill the logs of a def test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example(self):
#Builidungstage one 
cd $tmpdir 
logs=$tmpdir"logs"
originaltmpdir=$tmpdir

#multiple dirs layer start
inc=0
for toenter_or_tocreate in ${releasedirs//\|/ }; 
do
    toenter_or_tocreate=${toenter_or_tocreate/§\%/} #??: This is the trick to run the code passage just once as if nothing, when not in releasedir mode, there might be cleaner solution though, ..${toenter_or_tocreate/§\%/} is void, so it acts on the tempdir as if nothing within brackets.
    nottocreate=$(find $originaltmpdir |grep "$toenter_or_tocreate"|wc -l)
    tmpdir="$originaltmpdir""$toenter_or_tocreate""/" 
    if [ "$nottocreate" == "0" ];  #|| [ "$toenter_or_tocreate" != "" ]; 
    then 
        echo "create and enter" >> "$logs"; 
        mkdir $tmpdir
        cd $tmpdir 
    else
        echo "not create and enter " >> "$logs"; 
        cd $tmpdir 
    fi;
#Builidungstage one end

    #a template code start: array, for and if
    a="1 2 3";for i in $a; do if [ 1 -lt "$i" ] && [ "2" == "$i" ]; then echo "huhu">/dev/null;fi; done;

    let nrand=$RANDOM/1000
    fp_production_vaults=( ${fp_production_vaults//\|/" "/} )

    a=$(cat ${fp_production_vaults[$inc]}) 
    let inc=+1
    a1=${a:$nand:$nrand}
    echo " ""${a:$nand:$nrand}" >>"$tmpdir""output1"".txt"

    echo -e "$(date)"" firstoutput">>"$tmpdir""output1"".txt"
    echo -e "$(date)"" reportoutput">>"$tmpdir""report"".txt"
    echo -e "$(date)"" secondoutput">>"$tmpdir""output2"".txt"
    echo -e "" >>file

    echo tmpdir$tmpdir releasedirs$releasedirs toenter_or_tocreate $toenter_or_tocreate stage1batchmode$stage1batchmode Slot$Slot startstage$startstage >> "$logs"

    #Building stage 10
    #qa time
    #is output a good file? with more than a 13 might be.
    outputfile="$tmpdir""output1"".txt"
    reportfile="$tmpdir""report"".txt"

    # a bash builin in
    linenumber=$(cat $outputfile|wc -c)
    leastlinesboarder=13
    if [ "$linenumber" -gt $leastlinesboarder ]; then
        line="file is not empty:ok"
        echo "$line">>$reportfile
    else
        echo ${line/"not"//}>>$reportfile
fi
done
#Building stage 10 end

#declare -p|grep "\-\-"|grep "[a-z].*"


