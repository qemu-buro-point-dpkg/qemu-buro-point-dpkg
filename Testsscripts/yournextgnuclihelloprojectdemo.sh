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

#a template code start: array, for and if
a="1 2 3";for i in $a; do if [ 1 -lt "$i" ] && [ "2" == "$i" ]; then echo "huhu" ;fi; done; a=($a);echo ${a[1]} >/dev/null
#find syntax figures in bash manual and denominate it
#bash show case: shell, bourne, bash:
#bash.txt: the "(" 3.2.4.3 Grouping Commands 3.2.3 Lists of Commands, from 3.2 Shell Commands, from 3 Basic Shell Features: a) Placing a list of commands between parentheses causes a subshell environment to be created
 #bash.text: ">" 3.6 Redirections, 3.6.2 Redirecting Output

#bash.txt: the "if" 3.2.4.2 Conditional Constructs :if "TESt-COMMANDS"; "[  ... ]" 6.4 Bash Conditional Expressions, with binary expressions with string and numeric operators;  
 #with "&&":2 Definitions 'control operator', 3.2.3 Lists of Commands of 4.1 Bourne Shell Builtins: command test "["

#bash.txt: the "for " 3.2.4.1 Looping Constructs are 3.2.4 Compound Commands: "in $a": expanded words (2 Definitions)
 #expansion:3.5 Shell Expansions from 3.5.7 Word Splitting '$IFS' as a delimiter; 2 Definitions:" resulting fields are used as the command name and arguments" ; 3.1.1 Shell Operation: Performs in a list step 4; 

 #bash.txt#a=" 3 Basic Shell Features;3.1 Shell Syntax;3.1.2 Quoting;3.1.2.3 Double Quotes  preserves from word splitting expansion)
#bash.txt: the "($a" 6.7 Arrays assigned, from 6 Bash Features; referenced using '${NAME[SUBSCRIPT]}

#tbi: integrate functions definition and call into the snippet# 3.3 Shell Functions
#tbi: emulate two dimensional array with (built-in ugly rexexed 10.8 Optional Features) 3.5.3 Shell Parameter Expansion, "parameter substitution operators"





#hack does not work out of box: sorry
# # #we fill the logs of a def test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example(self):
# # #Builidungstage one 
# # cd $tmpdir 
# # logs=$tmpdir"logs"
# # originaltmpdir=$tmpdir
# # 
# # #multiple dirs layer start
# # inc=0
# # for toenter_or_tocreate in ${releasedirs//\|/ }; 
# # do
# #     toenter_or_tocreate=${toenter_or_tocreate/§\%/} #??: This is the trick to run the code passage just once as if nothing, when not in releasedir mode, there might be cleaner solution though, ..${toenter_or_tocreate/§\%/} is void, so it acts on the tempdir as if nothing within brackets.
# #     nottocreate=$(find $originaltmpdir |grep "$toenter_or_tocreate"|wc -l)
# #     tmpdir="$originaltmpdir""$toenter_or_tocreate""/" 
# #     if [ "$nottocreate" == "0" ];  #|| [ "$toenter_or_tocreate" != "" ]; 
# #     then 
# #         echo "create and enter" >> "$logs"; 
# #         mkdir $tmpdir
# #         cd $tmpdir 
# #     else
# #         echo "not create and enter " >> "$logs"; 
# #         cd $tmpdir 
# #     fi;
# # #Builidungstage one end
# # 
# #     #a template code start: array, for and if
# #     a="1 2 3";for i in $a; do if [ 1 -lt "$i" ] && [ "2" == "$i" ]; then echo "huhu">/dev/null;fi; done;
# # 
# #     let nrand=$RANDOM/1000
# #     fp_production_vaults=( ${fp_production_vaults//\|/" "/} )
# # 
# #     a=$(cat ${fp_production_vaults[$inc]}) 
# #     let inc=+1
# #     a1=${a:$nand:$nrand}
# #     echo " ""${a:$nand:$nrand}" >>"$tmpdir""output1"".txt"
# # 
# #     echo -e "$(date)"" firstoutput">>"$tmpdir""output1"".txt"
# #     echo -e "$(date)"" reportoutput">>"$tmpdir""report"".txt"
# #     echo -e "$(date)"" secondoutput">>"$tmpdir""output2"".txt"
# #     echo -e "" >>file
# # 
# #     echo tmpdir$tmpdir releasedirs$releasedirs toenter_or_tocreate $toenter_or_tocreate stage1batchmode$stage1batchmode Slot$Slot startstage$startstage >> "$logs"
# # 
# #     #Building stage 10
# #     #qa time
# #     #is output a good file? with more than a 13 might be.
# #     outputfile="$tmpdir""output1"".txt"
# #     reportfile="$tmpdir""report"".txt"
# # 
# #     # a bash builin in
# #     linenumber=$(cat $outputfile|wc -c)
# #     leastlinesboarder=13
# #     if [ "$linenumber" -gt $leastlinesboarder ]; then
# #         line="file is not empty:ok"
# #         echo "$line">>$reportfile
# #     else
# #         echo ${line/"not"//}>>$reportfile
# # fi
# # done
# # #Building stage 10 end
# # 
# # #declare -p|grep "\-\-"|grep "[a-z].*"
# # 
# # 
