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

#pretest:scanimage capable?
[ `scanimage -L|grep device|wc -l` -gt 0 ]||(echo "scan device for user found";exit)






# RANGE=${1:-$RANGE}   
# dup=${2:-$dup}  
# PPool=${3:-$PPool}  
# stage1batchmode=${4:-$stage1batchmode}
# [[ "$5" != "nonadf" ]]||Slot=""
# [[ "$6" != "startstage2" ]]||startstage="startstage2"
#Part I inserting leafs
#default
PPool="$HOME/Downloads"
RANGE=1 # number of staples 
dup=2 # duplex=2 else 1, beidseitig
stage1batchmode="0" #run one paper staple in without questioning user
Slot="--source ADF" #take papers not from flatbed
startstage="startstage1" #do not scan! Take images from path
outfile=""
#http://mywiki.wooledge.org/BashFAQ/035  Manual loop
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
        --startstage)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                startstage="startstage2"
                shift
            fi
            ;;

        -o|--output)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                outfile=$2
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

echo PPool$PPool RANGE$RANGE dup$dup stage1batchmode$stage1batchmode Slot$Slot startstage$startstage





echo $Slot"  "$5
DATE=`date +%y%m%d`
ocrmypdf="/usr/local/bin/ocrmypdf"

cd $PPool #work dir for scans here!

if [ "$startstage" == "startstage1" ]
  then
    rm -f *doctemp* #cleaning # clean old 
    echo "startstage1"
    for (( i=1; i != $RANGE*$dup+1; i++ )) #continue by messing this
    do
    echo $i ". insert and press enter paper"
    [[ "$stage1batchmode" = "1" ]]||read;
	echo "process paper .."
	let ii=i+10000
	time scanimage $Slot -v  -b --resolution 300 -l 0 -t 0 -x 210.00 -y 290.00 --format=tiff  --batch=doctemp${ii:2:3}-p%03d.tiff --batch-start=1 >> log.txt 2>&1
    #doctemp2-p001.tiff #-y 355.6 -x 215.9: big black bar below, - and without x,y too
    #-y 297 -x 210 little black bar
    #-x 210.00 -y 290.00 ok without bar: but is this optimal?
	#scanimage --help|grep eso
    #(T)Problem: after slot empty aborts, error catching?
    #(T) one stable unquestioned
    ls -rtl|tail >> log.txt 2>&1
    done disc
fi


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

time $ocrmypdf -f -l deu ./doctempbundle.pdf doctempbundlesandw1.pdf >> log.txt 2>&1
pdftotext doctempbundlesandw1.pdf - |tail -5 >> log.txt 2>&1
ls -l doctempbundlesandw1.pdf >> log.txt 2>&1
okular --geometry 300x400+20+30 doctempbundlesandw1.pdf & 
sleep 3;kill `ps aux|grep okular|grep doctempbundlesand|cut -c 10-15`

echo "   1OO "$outfile 
if [ "$outfile" != "" ]
  then
  cp doctempbundlesandw1.pdf $outfile
  ls $outfile
  echo "   OOO "$outfile 
fi


# #Part III
# #distribute
# 
# #uff wie got some Problems big black bars below, this: 
# #pdfcrop --margins '0 0 0 -189' --clip doctempbundlesandw1.pdf  doctempoutput.pdf
# #mv doctempoutput.pdf doctempbundlesandw1.pdf
# 
# #extract 1 leave copy
# 
# #extracts1

#...
#extracts1
mkdir -p Bescheide/Verwaltungsakte/Vereinbarung/DialektikderAufklaerung/Undinger/bedingungslosesgrundeinkommenfueralleMenschenaufderweltjetzt/oderderboeseonkelkantkommtauchnoch/oderderliebeonkelsade/

#Pstore=$PPool"/allpathes/thatyoucan/imagine"
Pstore=$PPool"Bescheide/Verwaltungsakte/Vereinbarung/DialektikderAufklaerung/Undinger/bedingungslosesgrundeinkommenfueralleMenschenaufderweltjetzt/oderderboeseonkelkantkommtauchnoch/oderderliebeonkelsade/"

Nstore=$DATE"Gliedi.pdf"
Nstore="Gliedi.pdf"

let Nstart=5
let Nend=6

pdftk A=doctempbundlesandw1.pdf cat A$Nstart-$Nend output $Pstore$Nstore
pdfinfo $Pstore$Nstore |grep Pages >> log.txt 2>&1
pdftotext $Pstore$Nstore - |head -125|tail >> log.txt 2>&1
ls -l $Pstore$Nstore >> log.txt 2>&1
#k
#extracts1 end

#extracts2
Pstore=$PPool

Nstore=$DATE"Gliedi.pdf"
##...
