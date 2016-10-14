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


#docs
#https://gist.github.com/mkuron/9724783
#https://wiki.debian.org/DebianInstaller/Preseed/EditIso
#http://d-i.alioth.debian.org/doc/internals/ch02.html#id318524
#https://www.debian.org/releases/stable/amd64/apbs02.html.en#preseed-loading

#Part I inserting leafs
tmpdir="/tmp/qemuburotest/"
isourl="http://cdimage.debian.org/debian-cd/8.6.0/amd64/iso-cd/"

isoimage="debian-8.6.0-amd64-netinst.iso" 
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

ram=256
qcow2img="debian.qcow"
qemu=qemu-system-x86_64
#run one paper staple in without questioning user
qcow2_ready=$HOME"/Downloads/debian_squeeze_amd64_standard.qcow2" #do not scan! Take images from path


#templates
# RANGE=1 # number of staples 
# dup=2 # duplex=2 else 1, beidseitig
# #Slot="--source ADF" #take papers not from flatbed
# stage1batchmode="$HOME/Downloads/preseed.cfg" 

#mkuron debian naming scheme not used yet, because not understood
#qemu=qemu-system-x86_64
#arch=powerpc
#ram=256
#dist=jessie
#mirror='http://ftp.de.debian.org/debian'
#disk=debian-$dist-$arch.qcow2


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
        --stage1batchmode)       # Takes an option argument, ensuring it has been specified.
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

rm -fr $tmpinitdir
rm -fr $loopdir
#rm -fr $tmpdir
rm $outputiso $qcow2img

test -d $tmpdir$tmpinitdir||mkdir -p $tmpdir$tmpinitdir
test -d $tmpdir$loopdir||mkdir -p $tmpdir$loopdir
test -d $tmpdir$targetisodir||mkdir -p $tmpdir$targetisodir

#check before, if ssh key are present on the host, else generate
test -e $HOME/.ssh/id_rsa ||echo -e  'y'|ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
#~/.ssh/id_rsa.pub.
#Next, add the contents of the public key file into ~/.ssh/authorized_keys on remote(guest)

cd $tmpdir
if test -e $cpisofromdir$isoimage; then cp $cpisofromdir$isoimage .; else wget $isourl$isoimage -O $tmpdir$isoimage; fi
wget $isourl$MD5SUMS -O $tmpdir$MD5SUMS
echo $(grep $isoimage $MD5SUMS|cut -f1 -d" ")"  "$isoimage | md5sum -c|grep OK||exit

#ls $tmpinitdir $loopdir $tmpdir $outputiso $qcow2img
#user-mount, cp iso unwritable content to targetisodir, unmount $loopdir
fuseiso $tmpdir$isoimage $tmpdir$loopdir
cd / #rsync bugs
rsync -a -H --exclude=TRANS.TBL $tmpdir$loopdir $tmpdir$targetisodir
fusermount -u $tmpdir$loopdir

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
echo 'echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTFJyYRUl8dQrm/tIpnxbDanjk2rgASwaZdWpK9Q+4EEjRI/1TeRRcKB4qdygbZiLXeQhZ9N7lKO8fdna/6PcWZ1ltSFMUKqD7z2WkJx0i6+I9QaVQIaggky4jNE1NIWW9y7BiCRDouY7DwNW0GvfIar12slyKPPfSy83gep8z64UA7lDk6cDknSmUI+ISMWHzSVyPqqvFnRshng73kxwtkNRQ4CMz+BjMn07RqbOg5daQ/xFUoIvJg4SsgbnPODdfz4S9X5TrPTaqJ8gFw/0CbIpiHMsXA+TgBlH/PfGDppj54kHWR95JStEAyAL81qMcxXdFQo/OtYRHMqSHC/75 root@kubuntu" > /target/root/.ssh/authorized_keys' >>$tmpdir$tmpinitdir/usr/lib/finish-install.d/94save-logs

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


qemu-img create -f qcow2 $qcow2img 2G
ls $tmpinitdir $loopdir $tmpdir; ls -l $outputiso $qcow2img

$qemu -hda $qcow2img -cdrom $outputiso -boot d -m $ram  

# debugging: for early logs, but seems not to be working: after first connect no fs sync.. ??
# umount /dev/nbd0p1 
# qemu-nbd --disconnect /dev/nbd0
# mount /dev/nbd0p1 
# qemu-nbd --connect=/dev/nbd0 /tmp/debian.qcow

$qemu -m $ram -hda $qcow2img -boot order=c -redir tcp:2222::22 &
# time out
#40 s on 4 kernel host
sleep 100 #wait till what?

ssh-keygen -f "$HOME/.ssh/known_hosts" -R [localhost]:2222

#ssh -vvv -o 'StrictHostKeyChecking no' -p 2222 root@localhost
ssh -q -o 'StrictHostKeyChecking no' -p 2222 root@localhost "cat /world">/tmp/qemuburotest/world
cat /tmp/qemuburotest/world
#echo hello>/tmp/qemuburotest/world; exit #mock
# cdrecord -dev /dev/hd? test.iso

