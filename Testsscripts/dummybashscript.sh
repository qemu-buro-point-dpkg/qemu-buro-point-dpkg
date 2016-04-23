[ `scanimage -L|grep device|wc -l` -gt 3 ]||(echo "scan device for user found";exit)



RANGE=1 # staple number
dup=2 # duplex=2 else 1, beidseitig
PPool="$HOME/Downloads"
stage1batchmode="0"

RANGE=${1:-$RANGE}   # Defaults to /tmp dir.
dup=${2:-$dup}  
PPool=${3:-$PPool}  
stage1batchmode=${4:-$stage1batchmode}
# Default value is 1.

# echo "range"$RANGE
# echo "dup"$dup
# echo "dir"$PPool
# echo $stage1batchmode
# echo "rt"$rt

for (( i=1; i <= 3; i++ )) #continue by messing this
  do
  echo $i ". insert and press enter" 
  done
