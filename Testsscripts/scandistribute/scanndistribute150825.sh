#     <one line to give the program's name and a brief idea of what it does.>
#    hardware indepedent config-way script for copy and paste in the console. You can use it to scan paper stacks and distribute it into documents
#     Copyright (C) 2015  Tom Blecher
# 
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.

# usage: case 1: 1 page front page: as below case2, take first part 1 then part 2
# usage: case 2: multi slot staple, duplex: ie. 2 staples (RANGE=2), first 2 fronts, then rear reverse order staple wise (for fitting scanners slots, about 15 leafs); after that, they are again in original order, where stapel 1 gets stapel 4 and vice versa
# use physical snippet 1-4 to mark each staple
# usage: console 1: c&p partI first, then PartII and PartIII to console, console 2:  less +F log.txt , script in Kate split view, where one window you select and c&p, on the other you manipulate code
# improvements: -sophisticated cl interfaces, time messurement in console, -pop up log in konsole
# tests: qual/size/speed vector
#have distributed files as dropbox links, or other url, search|request



#default
tmpdir="/tmp/qemuburotest/"
PPool="$HOME/Downloads"
PPool=$tmpdir
RANGE=1 # number of leafs staples 
dup=2 # "duplex" (paper leaf printed with text on both sides) =2 else 1
stage1batchmode="0" #run one paper staple in without questioning user
Slot="--source ADF" #take papers not from hardware flatbed
startstage_="startstage1" #do not scan! Take images from path
outfile="" #arbitrary name for output files
conffile="$HOME/.qemuburo/""scandistribute.conf"
conffile2="$HOME/.qemuburo/""scandistribute2.conf.sh"
#You got an application with two conf-files. The second is for 
#distributing snippeds to disk locations, meanwhile the first one is generic. 

endstage=2560000
stagepointer=0
startstage=0

DATE=`date +%y%m%d`
ocrmypdf="/usr/local/bin/ocrmypdf"
pdfviewer="/usr/bin/okular"

resolution="300"
istart=1 #after cancel with which paper staple number to begin
leafstart=1 #after cancel with which paper leaf number of staple number to begin
printout=0 #no printing at stage 400 by default
#http://mywiki.wooledge.org/BashFAQ/035  Manual loop
rmdoctemp=0; #flag do not remove the previous run's temp files
display_time=3 # the pdfview is hold 3 seconds up: ok for tests
while :; do
    case $1 in
        -h|-\?|--help)   # Call a "show_help" function to display a synopsis, then exit.
            exit
            ;;
        -t|--tmpdir)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                PPool=$2
                shift
            fi
            ;;
        --nstaples)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                RANGE=$2
                shift
            fi
            ;;
        --config)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                conffile=$2
                shift
            fi
            ;;
        --config2)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                conffile2=$2
                shift
            fi
            ;;
        --duplex)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                dup=$2
                shift
            fi
            ;;
        --stage1batchmode)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                stage1batchmode=$2
                shift
            fi
            ;;
        --slot)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                Slot=""
                shift
            fi
            ;;
        --startstage_)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                startstage_="startstage2"
                shift
            fi
            ;;
        --startstage)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                startstage=$2
                shift
            fi
            ;;

        --endstage)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                endstage=$2
                shift
            fi
            ;;

        
        -o|--output)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                outfile=$2
                shift
            fi
            ;;

        --istart)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                istart=$2
                shift
            fi
            ;;

        --leafstart)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                leafstart=$2
                shift
            fi
            ;;

        --printout)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                printout=$2
                shift
            fi
            ;;

        --display_time)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                display_time=$2
                shift
            fi
            ;;

        --rmdoctemp)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                rmdoctemp=$2
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

echo PPool$PPool RANGE$RANGE dup$dup stage1batchmode$stage1batchmode Slot$Slot startstage$startstage_
echo $Slot"  "$5


stagepointer=200; 

cd $PPool #work dir for scans here!

if [ $endstage -lt $stagepointer ]; then echo "out before"$stagepointer; exit; else echo -n " "; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo  "(re)read config $stagepointer";


if [ $rmdoctemp -gt 0 ]; then echo "flag set: rm *doctemp*.pdf # clean old scans here!"; rm doctemp*; else echo  "no removal mode"; fi
#on flag rm *doctemp*.pdf #cleaning # clean old scans here!
#config file read priorities, search path policy: 1. command line, if not user .qemuburo, else take defaults hardcoded 
time test -e $conffile && source $conffile 
#tbi
echo "tbi time scanimage -L #real    0m5.309s
"
#time scanimage -L
echo "scanimage -L|grep device|wc -l#real    0m5.309s *2"
#scanimage -L|grep device|wc -l
#[ `scanimage -L|grep device|wc -l` -gt 0 ]||(echo "scan device for user found";exit)


fi;stagepointer=250; 
if [ $endstage -lt $stagepointer ]; then echo "out before"$stagepointer; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo "Part I inserting leafs; hardware feeding stage $stagepointer";



cd $PPool #work dir for scans here!

if [ "$startstage_" == "startstage1" ]
  then
    let switch=$istart+$leafstart
    if [ $switch -lt 2 ]; 
        then echo "cleaning  #clean old rm -f *doctemp*"; rm -f *doctemp*; 
        else echo  "do not clean 157er mode "; 
    fi
    echo "startstage1"
    for (( i=$istart; i != $RANGE*$dup+1; i++ )) #continue by messing this
    do
    echo $i ". insert and press enter paper"
    [[ "$stage1batchmode" = "1" ]]||read;
	echo "process paper ..non interactivity:$stage1batchmode"
        stage1batchmode="0"
	let ii=i+10000
	echo "leafstart $leafstart" 
	time scanimage $Slot -v  -b --resolution 300 -l 0 -t 0 -x 210.00 -y 290.00 --format=tiff  --batch=doctemp${ii:2:3}-p%03d.tiff --batch-start=$leafstart >> log.txt 2>&1
    #doctemp2-p001.tiff #-y 355.6 -x 215.9: big black bar below, - and without x,y too
    #-y 297 -x 210 little black bar
    #-x 210.00 -y 290.00 ok without bar: but is this optimal?
	#scanimage --help|grep eso
    #(T)Problem: after slot empty aborts, error catching?
    #(T) one stable unquestioned
    echo "logs: ii: $i   i:$i"
    ls -rtl|tail >> log.txt 2>&1
    done
fi

fi;stagepointer=300; 
if [ $endstage -lt $stagepointer ]; then echo "out before"$stagepointer; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo "stage bind cumulative doctempbundle.pdf $stagepointer";

#
# as non interactive as possible from here on, Part II
for (( i=1; i < $RANGE*$dup+1; i++ )) 
  do
  echo $i >> log.txt 2>&1
  let ii=i+10000
  time convert doctemp${ii:2:3}-p*.tiff doctempconv${ii:2:3}.pdf  >> log.txt 2>&1
# bug?
  ls -rtl|tail >> log.txt 2>&1
done 
# debug
 #okular doctempconv*.pdf 

#front and rearside
for (( i=1; i < $RANGE+1; i++ ))  
do
  echo $i 
  let ii=i+10000
  mv doctempconv${ii:2:3}.pdf doctempf${ii:2:3}.pdf
done 
pdftk doctempf*.pdf cat output doctempgetherf.pdf

for (( i=$RANGE+1; i < $RANGE*$dup+1; i++ )) 
  do
  echo $i
  let ii=i+10000
  mv doctempconv${ii:2:3}.pdf doctempr${ii:2:3}.pdf 
done 
pdftk doctempr*.pdf cat output doctempgetherr.pdf

pdftk A=doctempgetherf.pdf B=doctempgetherr.pdf shuffle A Bend-1 output doctempbundle.pdf || mv doctempgetherf.pdf doctempbundle.pdf
# or if non duplex
ls -rtl|tail >> log.txt 2>&1
pdfinfo doctempbundle.pdf |grep Pages >> log.txt 2>&1
#sandwich

fi;stagepointer=400; 
if [ $endstage -lt $stagepointer ]; then echo "out before"$stagepointer; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo -n "ocr-to-small-pdf-okular-up, cumulative file size $stagepointer";


time $ocrmypdf -f -l deu ./doctempbundle.pdf doctempbundlesandw1.pdf >> log.txt 2>&1
pdftotext doctempbundlesandw1.pdf - |tail -5 >> log.txt 2>&1
ls -l doctempbundlesandw1.pdf >> log.txt 2>&1
#display_time=3
okular --geometry 300x400+20+30 doctempbundlesandw1.pdf & 
(sleep $display_time;kill `ps ax|grep okular|grep doctempbundlesand|cut -c -5`)&

echo $printout
if [ $printout -lt 1 ]; 
    then echo "not printing nothing"; 
    else echo  "print ";
    lp -o ColorModel=KGray -o fit-to-page -o outputorder=reverse doctempbundlesandw1.pdf #$Pstore$Nstore
fi



echo "   1OO "$outfile 
if [ "$outfile" != "" ]
  then
  cp doctempbundlesandw1.pdf $outfile
  ls $outfile
  echo "   OOO "$outfile 
fi

fi;stagepointer=500; 
if [ $endstage -lt $stagepointer ]; then echo "out before"$stagepointer; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo -n "stage distribute pdf $stagepointer";

bash $conffile2 
#run scandistribute2.conf.sh or other late scripts
##...
fi;