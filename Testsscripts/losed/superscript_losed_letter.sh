#snipped according
#/abs-guide.html#STANDARD-OPTIONS
#G.1. Standard Command-Line Options

#Do not worry about the naming, it is just for demoing here.
tmp_dir="/tmp/qemuburotest/"
input0file="emptyodttemplate"

#multiline input 1 with backslash
address_complete="Don Quijote\nLugar de que no me quiero recordar 56\n12345 de la mancha\n\nSancho Panza\nde muy poca sal en la mollera 78 \n90123 vecino\n"
losedpy=""


#title logic
#addressed human: a) Senior in line, then whole line, if not Seniora, take hole line, if not, take: dear Sirs 
#sexindicator="Senior "
#tbi 
addressee=$(head -n1 $tmp_dir"5.tmp")

addressee0=$(cat  $tmp_dir"5.tmp"|sed 's/$/\\n/' | tr -d '\n')

sender=$(head -n1 $tmp_dir"1.tmp")
sender0=$(cat $tmp_dir"1.tmp"|sed 's/$/\\n/' | tr -d '\n' )
#Senior Sancho Panza
subject=$(head -n1 $tmp_dir"3.tmp")
textblock=$(cat $tmp_dir"4.tmp"|sed 's/$/\\n/' | tr -d '\n')

date_string=$(head -n1 $tmp_dir"2.tmp")
#Salutation logic, tbi
salutationline=""
salutation="Buenos dias "
generic_salutation="Buenos dias senioras y Seniores "
if [ "$addressee" == "" ] ; then salutation=$generic_salutation; fi


endsalutation="Saludos"
#outfileext=".pdf"
outfileext=".odt"
outfile=$tmp_dir"$(echo $addressee|tr " " "_")""_""$date_string""$outfileext"



#2 without backslash
#address_complete='Don 
#Quijote'
#address_complete="${address_complete//$'\n'/\\\n}" #$'address_complete'
#3 #from file
#address_complete='Don 
#Quijote'
# echo "$address_complete" >/tmp/qemuburotest/1
# address_complete=$(cat /tmp/qemuburotest/1)
# address_complete="${address_complete//$'\n'/\\\n}"
#
conffile=$Qemuburo_install_dir"losed/superscript_losed_letter.userconfig.sh" 

RANGE=1 # number of staples 
dup=2 # duplex=2 else 1, beidseitig
stage1batchmode="0" #run one paper staple in without questioning user
Slot="--source ADF" #take papers not from flatbed
startstage="startstage1" #do not scan! Take images from path

while :; do
    case $1 in
        -h|-\?|--help)   # Call a "show_help" function to display a synopsis, 
            #then exit.
            exit
            ;;
        -i|--input_file)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                input_file=$2
                shift
            fi
            ;;
        -t|--tmp_dir)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                tmp_dir=$2
                shift
            fi
            ;;
       --losedpy)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                losedpy=$2
                shift
            fi
            ;;
        --conffile)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                $conffile=$2
                shift
            fi
            ;;
        --outfile)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                outfile=$2
                shift
            fi
            ;;
        --endsalutation)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                endsalutation=$2
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

test -f $conffile && source $conffile


ls $tmp_dir
#we fill the logs of a def test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example(self):
#echo PPool$PPool RANGE$RANGE dup$dup stage1batchmode$stage1batchmode Slot$Slot startstage$startstage > $tmp_dir"logs"

inc=1

binput_file="$tmp_dir""$input0file"
insertline=3
#insertstring=$address_complete
insertstring=$sender0$addressee0
# incedent=5
# insert="k\nj" #string to be inserted for or appended 
# absoluteUrlstr="/tmp/qemuburotest/Buildingdemon/b/e/i/"
#command2=""
#echo -e $address_complete 
command0=' --searchSearchString ^.'
command1=' --insert '$(echo $insertstring|tr " " "|")
command2=' --filetype4b=tmpfile'`expr $inc + 1`".odt"
command3=' --incedent '$insertline
command="python3 $losedpy --loadComponentFromabsoluteURL $binput_file.odt \
    --tmpdir $tmp_dir \
$command0$command1$command2$command3"
#    --absoluteUrltxt /tmp/qemuburotest/test1.txt
echo -e $command

$command


#second call insert date right 
let inc+=1
command0=' --searchSearchString ^.'
#tbi date logic
#insertstring="13.4.1435"
insertstring=$date_string
insertline=4
command1=' --insert '$(echo $insertstring|tr " " "|")
command2=' --filetype4b=tmpfile'`expr $inc + 1`".odt"
command3=' --incedent '$insertline
command4=' --loadComponentFromabsoluteUR '$tmp_dir"tmpfile"$inc".odt" 
command5=' --setPropertyValue1a ParaAdjust'
command6=' --setPropertyValue1b _i_1' 
command="python3 $losedpy  \
    --tmpdir $tmp_dir \
$command0$command1$command2$command3$command4$command5$command6"
#echo -e $command
$command

#third call insert subject bold
let inc+=1
insertstring="A la vuestra merced"
insertstring=$subject
insertline=5
command1=' --insert '$(echo $insertstring|tr " " "|")
command2=' --filetype4b=tmpfile'`expr $inc + 1`".odt"
command3=' --incedent '$insertline
command4=' --loadComponentFromabsoluteUR '$tmp_dir"tmpfile"$inc".odt" 
command5=' --setPropertyValue1a CharWeight'
command6=' --setPropertyValue1b _i_110' 

command="python3 $losedpy  \
    --tmpdir $tmp_dir \
$command0$command1$command2$command3$command4$command5$command6"
#echo -e $command
$command


#fourth call insert salutation
let inc+=1
#tbi salutation logic mf surname/surname lady and gentlement, cases? sexmarker in source? Senior/Frau? 
surname="Panza"
pref="Senior"
insertstring="\n Querido $surname $pref"
insertstring="\n $salutation$addressee"
#if insertstring="\n $salutationline"

insertline=6
command1=' --insert '$(echo $insertstring|tr " " "|")
command2=' --filetype4b=tmpfile'`expr $inc + 1`".odt"
command3=' --incedent '$insertline
command4=' --loadComponentFromabsoluteUR '$tmp_dir"tmpfile"$inc".odt" 
command5=''
command6='' 

command="python3 $losedpy  \
    --tmpdir $tmp_dir \
$command0$command1$command2$command3$command4$command5$command6"
#echo -e $command
$command

#fifth call insert salutation
let inc+=1
#tbi salutation logic mf surname/surname lady and gentlement, cases? sexmarker in source? Senior/Frau? 
insertstring="\n foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar rrrrrrr\n \n foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar foo bar "
insertstring=$textblock
insertline=7
command1=' --insert '$(echo $insertstring|tr " " "|")
command2=' --filetype4b=tmpfile'`expr $inc + 1`".odt"
command3=' --incedent '$insertline
command4=' --loadComponentFromabsoluteUR '$tmp_dir"tmpfile"$inc".odt" 
command5=''
command6='' 

command="python3 $losedpy  \
    --tmpdir $tmp_dir \
$command0$command1$command2$command3$command4$command5$command6"
#echo -e $command
$command


#six call insert salutation
let inc+=1
forename1="Don"
surname1="Quijote"
insertstring="\n   Saludos $forename1 $surname1" 
insertstring="\n   $endsalutation $sender" 
insertline=9
command1=' --insert '$(echo $insertstring|tr " " "|")
command2=' --filetype4b=tmpfile'`expr $inc + 1`".odt"
command3=' --incedent '$insertline
command4=' --loadComponentFromabsoluteUR '$tmp_dir"tmpfile"$inc".odt" 
command5=''
command6='' 

command="python3 $losedpy  \
    --tmpdir $tmp_dir \
$command0$command1$command2$command3$command4$command5$command6"
#echo -e $command
$command
#tbi torse date to 143500413: we are not file namer
basename $outfile|grep pdf>/dev/null&&cp $tmp_dir"test1.pdf" $outfile
basename $outfile|grep odt>/dev/null&&cp $tmp_dir'tmpfile'`expr $inc + 1`".odt" $outfile