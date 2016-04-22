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

#pretest:scanimage capable?
[ `scanimage -L|grep device|wc -l` -gt 3 ]||(echo "scan device for user found";exit)




#Part I inserting leafs
PPool="$HOME/Downloads"
RANGE=1 # staple number
dup=2 # duplex=2 else 1, beidseitig
stage1batchmode="0"
Slot="--source ADF"



RANGE=${1:-$RANGE}   
dup=${2:-$dup}  
PPool=${3:-$PPool}  
stage1batchmode=${4:-$stage1batchmode}
[[ "$5" != "nonadf" ]]||Slot=""
echo $Slot"  "$5
DATE=`date +%y%m%d`
ocrmypdf="/usr/local/bin/ocrmypdf"


cd $PPool #work dir for scans here!
rm -f *doctemp* #cleaning # clean old 
for (( i=1; i != $RANGE*$dup+1; i++ )) #continue by messing this
  do
  echo $i ". insert and press enter paper"
  [[ "$stage1batchmode" = "1" ]]||read;
    let ii=i+10000
    time scanimage $Slot -v  -b --resolution 300 -l 0 -t 0 -x 210.00 -y 290.00 --format=tiff  --batch=doctemp${ii:2:3}-p%03d.tiff --batch-start=1 >> log.txt 2>&1
#doctemp2-p001.tiff #-y 355.6 -x 215.9: big black bar below, - and without x,y too
#-y 297 -x 210 little black bar
#-x 210.00 -y 290.00 ok without bar: but is this optimal?
    #scanimage --help|grep eso
#(T)Problem: after slot empty aborts, error catching?
#(T) one stable unquestioned
  ls -rtl|tail >> log.txt 2>&1
done 

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
okular doctempbundlesandw1.pdf &# 
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
