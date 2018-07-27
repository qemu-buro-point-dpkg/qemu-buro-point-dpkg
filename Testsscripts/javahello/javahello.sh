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
userconfigpath=$tmpdir #user configs default: read from output path
userconfigpath2=$tmpdir

conffile="sophokleskrösos.userconfig.sh" #userconfigs default file name
driveroptions=""
conffile2="sophokleskrösos.userconfig2_laterconfig_qa_checklists.sh"
#snipped according
#/abs-guide.html#STANDARD-OPTIONS
#G.1. Standard Command-Line Options
userconfigpath=$tmpdir #user configs default: read from output path
userconfigpath2=$tmpdir

conffile="yournextgnuclihelloprojectdemo.userconfig.sh" #userconfigs default file name
driveroptions=""
#snipped according
#/abs-guide.html#STANDARD-OPTIONS
#G.1. Standard Command-Line Options
tmpdir="/tmp/qemuburotest/"
codefile="HelloWorld.java"
binaryfile="HelloWorld"
outputdir=$tmpdir
inputdir="$Qemuburo_install_dir""Testsscripts/javahello/"

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
        --codefile)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                codefile=$2
                shift
            fi
            ;;
        --binaryfile)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                binaryfile=$2
                shift
            fi
            ;;
        --inputdir)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                stage1batchmode=$2
                shift
            fi
            ;;
        --slot)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                Slot=$2
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

#read a userconfig default from output dir, tb completed to a debian standard
cd $tmpdir
#userconfigpath=$userconfigpath" "$userconfigpath
for a in $userconfigpath;
    do test -f $a$conffile && source $a$conffile $tmpdir
done 

echo "hello new test template"
echo $tmpdir"logs"
#we fill the logs of a def test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example(self):
echo PPool$PPool RANGE$RANGE dup$dup stage1batchmode$stage1batchmode Slot$Slot startstage$startstage > $tmpdir"logs"

#javac HelloWorld.java
#java HelloWorld


cd $inputdir;

javac -d $tmpdir "$codefile"; 

cd $outputdir;
java "$binaryfile"&
sleep 0.02
wmctrl -l|grep "Hello World">> $tmpdir"logs"



#a template code start: array, for and if
#(a="1 2 3";for i in $a; do if [ 1 -lt "$i" ] && [ "2" == "$i" ]; 
then echo "huhu" ;fi; done;) > /dev/null; a=($a);echo ${a[1]}
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

