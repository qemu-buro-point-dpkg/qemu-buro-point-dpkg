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
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.hi


#docs
#https://gist.github.com/mkuron/9724783
#https://wiki.debian.org/DebianInstaller/Preseed/EditIso
#http://d-i.alioth.debian.org/doc/internals/ch02.html#id318524
#https://www.debian.org/releases/stable/amd64/apbs02.html.en#preseed-loading


tmpdir="/tmp/qemuburotest/"
isourl="http://cdimage.debian.org/debian-cd/8.6.0/amd64/iso-cd/"

isourlimage="debian-8.6.0-amd64-netinst.iso" 
isoimage="debian.iso"
MD5SUMS="MD5SUMS" 
cpisofromdir="$HOME/Downloads/"
preseedcfg="preseed_test0.cfg"
p_preseedcfg=$Qemuburo_install_dir"Testresources/"$preseedcfg
loopdir="loopdir/"
targetisodir="targetisodir/"
tmpinitdir="initdir/"

isolinuxcfg="isolinux/isolinux.cfg"
isolinuxbin="isolinux/isolinux.bin" 
bootcat="isolinux/boot.cat" 
outputiso="test.iso"

bigness="4G"
ram=256
qcow2img="debian.qcow"
qemu=qemu-system-x86_64
#run one paper staple in without questioning user
qcow2_ready=$HOME"/Downloads/debian_squeeze_amd64_standard.qcow2" #do not scan! Take images from path


#mkuron debian naming scheme not used yet, because not understood
#qemu=qemu-system-x86_64
#arch=powerpc
#ram=256
#dist=jessie
#mirror='http://ftp.de.debian.org/debian'
#disk=debian-$dist-$arch.qcow2

endstage=2560000
stagepointer=0
startstage=0

UP=t
U=t
TARGETUSERHOME="/home/$U"
TARGETAUTHKEYPATH=$TARGETUSERHOME"/.ssh/authorized_keys"

redir=2222
dropacopy=0

logfile="/tmp/qemuburotest/log.txt"
conffile=$tmpdir"mudanca.conf"
test -e $conffile && source $conffile

while :; do
    case $1 in
        -h|-\?|--help)   # Call a "show_help" function to display a synopsis, then exit.
            exit
            ;;
        -t|--tmpdir)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                tmpdir=$2
                shift
            fi
            ;;
        --cpisofromdir)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                cpisofromdir=$2
                shift
            fi
            ;;
        --preseedcfg)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                preseedcfg=$2
                shift
            fi
            ;;
        --dropacopy)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                dropacopy=$2
                shift
            fi
            ;;
        --redir)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                redir=$2
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

        --qcow2img)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                qcow2img=$2
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
#
test -e /tmp/setupdone&&echo "setup there"
rm -r /tmp/setupdone/

#mkdir /tmp/qemuburotest/
# sollte dasein.



stagepointer=200; 
#echo hello>/tmp/qemuburotest/world; exit #mock
if [ $endstage -lt $stagepointer ]; then echo hello>/tmp/qemuburotest/world; exit; else echo -n "ffffffff"; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo -n "inject iso $stagepointer";
#echo hello>/tmp/qemuburotest/world; exit #mock
#Regression=1
#rm -fr $tmpinitdir
#rm -fr $loopdir
#rm -fr $tmpdir
#rm $outputiso $qcow2img

test -d $tmpdir$tmpinitdir||mkdir -p $tmpdir$tmpinitdir
test -d $tmpdir$loopdir||mkdir -p $tmpdir$loopdir
test -d $tmpdir$targetisodir||mkdir -p $tmpdir$targetisodir

#check before, if ssh key are present on the host, else generate
#rm $HOME/.ssh/id_rsa* # default use testers pub key  
test -e $HOME/.ssh/id_rsa ||echo -e  'y'|ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
#~/.ssh/id_rsa.pub.
#Next, add the contents of the public key file into ~/.ssh/authorized_keys on remote(guest)

cd $tmpdir
if test -e $cpisofromdir$isoimage; then cp $cpisofromdir$isoimage .; else wget $isourl$isourlimage -O $tmpdir$isoimage; fi
wget $isourl$MD5SUMS -O $tmpdir$MD5SUMS
echo $(grep $isourlimage $MD5SUMS|cut -f1 -d" ")"  "$isoimage |grep OK||exit

#ls $tmpinitdir $loopdir $tmpdir $outputiso $qcow2img
#user-mount, cp iso unwritable content to targetisodir, unmount $loopdir
if test -e /usr/bin/fuseiso; then fuseiso=/usr/bin/fuseiso;else 
echo "no fuseiso found"; 
mount /tmp/qemuburotest/loopdir
fi

$fuseiso $tmpdir$isoimage $tmpdir$loopdir
cd / #rsync bugs
rsync -a -H --exclude=TRANS.TBL $tmpdir$loopdir $tmpdir$targetisodir

fusermount -u $tmpdir$loopdir
umount /tmp/qemuburotest/loopdir

initdir=`find $tmpdir$targetisodir -name "*initrd*"|head -n1`
cd $tmpdir$tmpinitdir
gzip -d < $initdir | cpio --extract --verbose --make-directories --no-absolute-filenames
#noisy
chmod -R u+w $tmpdir$tmpinitdir  $tmpdir$targetisodir


cp $p_preseedcfg $tmpdir$tmpinitdir"preseed.cfg"
#file is to placed a higher hierarchy order dir of initrd fs, why, who says it?https://www.debian.org/releases/stable/amd64/apbs02.html.en#preseed-loading first paragraph

debconf-set-selections -c $tmpdir$tmpinitdir"preseed.cfg" 2>&1|grep -v "ds.dat\|warning"&& (echo "Syntax error preseed.cfg"; exit)
#apt install debconf-utils
#some code injections, work around or better choice than preseed late intarget commands
echo "sed -ie 's/PermitRootLogin .*/PermitRootLogin yes/' /target/etc/ssh/sshd_config" >>$tmpdir$tmpinitdir/usr/lib/finish-install.d/94save-logs
echo "sed -ie 's/PermitEmptyPasswords .*/PermitEmptyPasswords yes/' /target/etc/ssh/sshd_config" >>$tmpdir$tmpinitdir/usr/lib/finish-install.d/94save-logs
echo "mkdir -p /target/root/.ssh" >>$tmpdir$tmpinitdir/usr/lib/finish-install.d/94save-logs
pubkeyhostuser=$(cat $HOME/.ssh/id_rsa.pub)
echo 'echo "'$pubkeyhostuser'" > /target/root/.ssh/authorized_keys' >>$tmpdir$tmpinitdir/usr/lib/finish-install.d/94save-logs

##debugging
echo "echo hello>/target/world" >>$tmpdir$tmpinitdir/usr/lib/finish-install.d/94save-logs


#change set -e in set -x in any init script
#for i in `find $tmpinitdir -name "[0-9]*"|grep -v "rules\|kernel/drivers\|.ktb"`; do echo _--$i; sed -ie 's/set -e/set -x/' $i; done

#do a set -x under any shebang
#?

##debugging end

find . | cpio -H newc --create --verbose | \
        gzip -9 > $initdir
cd ../
#rm -fr $tmpinitdir
#Fix md5sum's


cd $tmpdir$targetisodir
md5sum `find -follow -type f` > md5sum.txt
cd ..

#todo find
chmod -R 744 $tmpdir$targetisodir"isolinux/"
sed -ie 's/timeout 0/timeout 1/' $tmpdir$targetisodir$isolinuxcfg #timeout boot prompt

cd $tmpdir
ls $tmpdir$targetisodir$bootcat $tmpdir$targetisodir$isolinuxbin $tmpdir$targetisodir$isolinuxcfg
genisoimage -o $outputiso -r -J -no-emul-boot -boot-load-size 4  -boot-info-table -b $isolinuxbin -c $bootcat $targetisodir

fi;stagepointer=300; #iso remastered
if [ $endstage -lt $stagepointer ]; then echo hello>/tmp/qemuburotest/world; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo -n "create qcow $stagepointer";

cd $tmpdir
qemu-img create -f qcow2 $qcow2img $bigness
ls $tmpinitdir $loopdir $tmpdir; ls -l $outputiso $qcow2img

fi;stagepointer=400; 
if [ $endstage -lt $stagepointer ]; then echo hello>/tmp/qemuburotest/world; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo -n "stage launch install $stagepointer";

#killall qemu-system-x86_64
cd $tmpdir
$qemu -hda $qcow2img -cdrom $outputiso -boot d -m $ram  

fi;stagepointer=500; 
if [ $endstage -lt $stagepointer ]; then echo hello>/tmp/qemuburotest/world; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo -n "stage $stagepointer laumch clean install";

# debugging: for early logs, but seems not to be working: after first connect no fs sync.. ??
# umount /dev/nbd0p1 
# qemu-nbd --disconnect /dev/nbd0
# mount /dev/nbd0p1 
# qemu-nbd --connect=/dev/nbd0 /tmp/debian.qcow
cd $tmpdir
echo $redir::22
$qemu -m $ram -hda $qcow2img -boot order=c -redir tcp:$redir::22 &

fi;stagepointer=600; 
if [ $endstage -lt $stagepointer ]; then echo hello>/tmp/qemuburotest/world; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo "stage ssh_ready_runnable $stagepointer";

# time out
#40 s on 4 kernel host
cd $tmpdir
sleep 100 #wait till what?
ssh-keygen -f "$HOME/.ssh/known_hosts" -R [localhost]:$redir

ssh -o 'StrictHostKeyChecking no' -p $redir root@localhost "useradd -m -p "$U" -s /bin/bash t"
####
# U=t
# TARGETUSERHOME="/home/$U"
# TARGETAUTHKEYPATH=$TARGETUSERHOME"/.ssh/authorized_keys"
#unlock ssh
echo $TARGETAUTHKEYPATH
cat $HOME/.ssh/id_rsa.pub |ssh -q -o 'StrictHostKeyChecking no' -p $redir root@localhost "mkdir -p $TARGETUSERHOME/.ssh && cat >> $TARGETAUTHKEYPATH"


ssh -q -o 'StrictHostKeyChecking no' -p $redir root@localhost "ssh-keygen -f '/root/.ssh/known_hosts' -R [localhost]:$redir"
#ssh -vvv -o 'StrictHostKeyChecking no' -p $redir root@localhost
ssh -q -o 'StrictHostKeyChecking no' -p $redir $U@localhost "cat /world">/tmp/qemuburotest/world
cat /tmp/qemuburotest/world

[ $dropacopy -eq "1" ] && cp $qcow2img $qcow2img"ssh_ready_runnable"$stagepointer #real	1m27.453s



fi;stagepointer=700; 
if [ $endstage -lt $stagepointer ]; then echo hello>/tmp/qemuburotest/world; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo  "stage lightdm icewm $stagepointer";
#now we got a ssh ready machine but for a usecase of soft user migragtion to other hardware, we need a pachage list, wie found 1 4 Ways: 1 0extract from history, 2 extract it from log (1 und 2 name: 77lastaptgetinstalls), 3 dump it, 4 metapackage such icewm install
cd $tmpdir
echo $stagepointer
#scp -P$redir ./77lastaptgetinstalls root@localhost:/root/
#ssh -q -o 'StrictHostKeyChecking no' -p $redir root@localhost "a=`cat 77lastaptgetinstalls`; apt-get install $a"#>/tmp/qemuburotest/world bugs, ..
ssh -q -o 'StrictHostKeyChecking no' -p $redir root@localhost "DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install xserver-common xinit icewm xterm screen nmap lightdm dillo" #>/tmp/qemuburotest/world
#add user and unlock for him
ssh -q -o 'StrictHostKeyChecking no' -p $redir root@localhost "DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install whois" #>/
ssh -o 'StrictHostKeyChecking no' -p $redir root@localhost "useradd -m -p t -s /bin/bash t"
####
# U=t
# TARGETUSERHOME="/home/$U"
# TARGETAUTHKEYPATH=$TARGETUSERHOME"/.ssh/authorized_keys"
#unlock ssh
echo $TARGETAUTHKEYPATH
cat $HOME/.ssh/id_rsa.pub |ssh -q -o 'StrictHostKeyChecking no' -p $redir root@localhost "mkdir -p $TARGETUSERHOME/.ssh && cat >> $TARGETAUTHKEYPATH"
#as root unlock light dem
ssh -q -o 'StrictHostKeyChecking no' -p $redir root@localhost "cp -a /etc/lightdm/ /etc/lightdmbk; cp /etc/lightdmbk/lightdm.conf /etc/lightdm/;sed -ie 's/#autologin-user=/autologin-user=t/' /etc/lightdm/lightdm.conf;sed -ie 's/#autologin-user-timeout/autologin-user-timeout/' /etc/lightdm/lightdm.conf;cat /etc/lightdm/lightdm.conf|grep autol" #; echo "hello"
echo "above command exits here shell, when pasted in console"
echo "hello2"

#/etc/init.d/lightdm restart
ssh -q -o 'StrictHostKeyChecking no' -p $redir root@localhost "/etc/init.d/lightdm restart" #>/tmp/qemuburotest/world
echo "hello3/etc/init.d/lightdm restart"
#lightdm xappears at machine
sleep 10
#login through new user accaunt
ssh -q -o 'StrictHostKeyChecking no' -p $redir $U@localhost "ls -l $TARGETAUTHKEYPATH; date"


#issued by user: can from users seat = simulation: 
#open a an x-application by the users xterm, print out inspection and evoke from this shell another xterm
ssh -q -o 'StrictHostKeyChecking no' -p $redir $U@localhost 'DISPLAY=:0 xterm -title japmon -e sh -c "xterm&echo hello>2&w;nmap localhost;dillo https://wiki.debian.org/DebianMentorsFaq#What_is_the_debian-mentors_mailing_list_for.3F;bash;"'& #>/tmp/qemuburotest/world

sleep 5

echo "Go check oracle with gocr"


echo "hello stage xx: x-user-capable-ready-to-use-machine"
fi;stagepointer=800; 
if [ $endstage -lt $stagepointer ]; then echo hello>/tmp/qemuburotest/world; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo -n "stage $stagepointer prepare home dummy";

mkdir -p $HOME/Downloads/qemuhomeudir

bh=$(ah=".bashrc\|\.config\|.FreeCAD\|.gnupg\|.kde\|.dingrc"; find $HOME/ -name "\.*" -maxdepth 1 |grep $ah)
#cp -a $bh $HOME/Downloads/qemuhomeudir/ 

du -sh $HOME/Downloads/qemuhomeudir/
#285M	/home/kubuntu/Downloads/qemuhomeudir/
#echo ppa
#echo other software buro
#
# so then there is need for unittest template user dir is needed in /tmp/ strapped out to a few bits at least
#in the private usecase: to go with links then


fi;stagepointer=900; 
if [ $endstage -lt $stagepointer ]; then echo hello>/tmp/qemuburotest/world; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo -n "stage $stagepointer empty ";


fi;stagepointer=1000; 
if [ $endstage -lt $stagepointer ]; then echo hello>/tmp/qemuburotest/world; exit; else echo -n ""; fi
if [ $startstage -gt $stagepointer ]; then echo "pass stage" $stagepointer; else echo -n "stage $stagepointer chromium";
cd $tmpdir
echo $stagepointer

#ssh -q -o 'StrictHostKeyChecking no' -p $redir $U@localhost 'dpkg --configure -a' #>/tmp/
logfile="/tmp/qemuburotest/log.txt"
ao="libreoffice" 
ssh -o 'StrictHostKeyChecking no' -p $redir root@localhost "DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install $ao"  >$logfile #

ao="chromium vim kate" #"libreoffice" #"ding dolphin cryptsetup hplip kate gimp git aspell-de kate libreoffice autokey-gtk autokey-qt  xautomation uswsusp winpdb pdftk poppler-utils"
ssh -q -o 'StrictHostKeyChecking no' -p $redir root@localhost "DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install $ao"  >>"$logfile"


fi;
