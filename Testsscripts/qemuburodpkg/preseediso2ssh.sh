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

# usage: case 1: 

echo hello>/tmp/qemuburotest/world; exit
#https://gist.github.com/mkuron/9724783
#https://wiki.debian.org/DebianInstaller/Preseed/EditIso
#Part I inserting leafs
PPool="$HOME/Downloads/mini.iso"
PPool="$HOME/Downloads/debian-8.6.0-amd64-netinst.iso" 
RANGE=1 # number of staples 
dup=2 # duplex=2 else 1, beidseitig
#stage1batchmode="$HOME/Downloads/preseed.cfg" 
stage1batchmode="$HOME/Downloads/preseed_test0.cfg"

#run one paper staple in without questioning user
Slot="--source ADF" #take papers not from flatbed
startstage="home/kubuntu/Downloads/debian_squeeze_amd64_standard.qcow2" #do not scan! Take images from path
workdir="$HOME/Downloads/"
loopdir=$workdir"loopdir/"
tmpdir="/tmp/loopdir/"
#problem: cp partition costy
#mount root
#$HOME
#dummy variables change
#pretest iso image qemu boot
#mini.iso bootet nicht von qemu?
#temp dir layout mit test
#umziehen dropbox, helper files, 
#tutorials auf debian preseed qemu cl uns cfg
tmpinitdir="/tmp/initdir/"
outputiso="/tmp/test.iso"
qcow2img="/tmp/debian.qcow"
qemu=qemu-system-x86_64
arch=powerpc
ram=256
dist=jessie
mirror='http://ftp.de.debian.org/debian'
disk=debian-$dist-$arch.qcow2


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

echo PPool$PPool RANGE$RANGE dup$dup stage1batchmode$stage1batchmode Slot$Slot startstage$startstage

#miniurl=http://ftp.de.debian.org/debian/dists/jessie/main/installer-amd64/current/images/netboot/mini.iso
#wget $miniurl -o $PPool

#http://d-i.alioth.debian.org/doc/internals/ch02.html#id318524
#mini.iso bootet nicht von qemu?
#netinst CD
#$HOME/Downloads/mini.iso
#$HOME/Downloads/preseed.cfg
#$HOME/Downloadsdebian_squeeze_amd64_standard.qcow2
#



rm -fr $tmpinitdir
rm -fr $loopdir
rm -fr $tmpdir
rm $outputiso $qcow2img

ls $tmpinitdir $loopdir $tmpdir $outputiso $qcow2img
test -d $loopdir||mkdir $loopdir
#mount -o loop $PPool $loopdir

fuseiso $PPool $loopdir

test -d $tmpdir||mkdir $tmpdir
test -d $tmpinitdir||mkdir $tmpinitdir
cd /
cd /;rsync -a -H --exclude=TRANS.TBL $loopdir $tmpdir
#umount $loopdir
fusermount -u $loopdir
initdir=`find /tmp/loopdir/ -name "*initrd*"|head -n1`
cd $tmpinitdir
gzip -d < $initdir | cpio --extract --verbose --make-directories --no-absolute-filenames
#noisy
chmod -R u+w $tmpdir

cp $stage1batchmode $tmpinitdir"preseed.cfg"
#file is to placed a higher hierarchy order dir of initrd fs, why, who says it???

echo "sed -ie 's/PermitRootLogin .*/PermitRootLogin yes/' /target/etc/ssh/sshd_config" >>$tmpinitdir/usr/lib/finish-install.d/94save-logs
echo "sed -ie 's/PermitEmptyPasswords .*/PermitEmptyPasswords yes/' /target/etc/ssh/sshd_config" >>$tmpinitdir/usr/lib/finish-install.d/94save-logs
echo "mkdir -p /target/root/.ssh" >>$tmpinitdir/usr/lib/finish-install.d/94save-logs
echo 'echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTFJyYRUl8dQrm/tIpnxbDanjk2rgASwaZdWpK9Q+4EEjRI/1TeRRcKB4qdygbZiLXeQhZ9N7lKO8fdna/6PcWZ1ltSFMUKqD7z2WkJx0i6+I9QaVQIaggky4jNE1NIWW9y7BiCRDouY7DwNW0GvfIar12slyKPPfSy83gep8z64UA7lDk6cDknSmUI+ISMWHzSVyPqqvFnRshng73kxwtkNRQ4CMz+BjMn07RqbOg5daQ/xFUoIvJg4SsgbnPODdfz4S9X5TrPTaqJ8gFw/0CbIpiHMsXA+TgBlH/PfGDppj54kHWR95JStEAyAL81qMcxXdFQo/OtYRHMqSHC/75 root@kubuntu" > /target/root/.ssh/authorized_keys' >>$tmpinitdir/usr/lib/finish-install.d/94save-logs

##debugging
echo "echo hello>/target/world" >>$tmpinitdir/usr/lib/finish-install.d/94save-logs

# umount /dev/nbd0p1 
# qemu-nbd --disconnect /dev/nbd0
# mount /dev/nbd0p1 
# qemu-nbd --connect=/dev/nbd0 /tmp/debian.qcow
# for early logs, but seems not to be working: after first connect no syncing..

#change set -e in set -x in any init script
for i in `find $tmpinitdir -name "[0-9]*"|grep -v "rules\|kernel/drivers\|.ktb"`; do echo _--$i; sed -ie 's/set -e/set -x/' $i; done

#do a set -x under any shebang
#?
debconf-set-selections -c $stage1batchmode 2>&1|grep -v "ds.dat\|warning"&& (echo "Syntax error preseed.cfg"; exit)
#apt install debconf-utils

##debugging end
find . | cpio -H newc --create --verbose | \
        gzip -9 > $initdir
cd ../
#rm -fr $tmpinitdir
#Fix md5sum's


cd $tmpdir
md5sum `find -follow -type f` > md5sum.txt
cd ..

isolinuxcfg=$tmpdir"isolinux/isolinux.cfg"
isolinuxbin=isolinux/isolinux.bin 
bootcat=isolinux/boot.cat 
#todo find
chmod -R 744 $tmpdir"isolinux/"
sed -ie 's/timeout 0/timeout 1/' $isolinuxcfg

genisoimage -o $outputiso -r -J -no-emul-boot -boot-load-size 4  -boot-info-table -b $isolinuxbin -c $bootcat $tmpdir

cd $tmpdir
qemu-img create -f qcow2 $qcow2img 2G
ls $tmpinitdir $loopdir $tmpdir; ls -l $outputiso $qcow2img

qemu-system-x86_64 -hda $qcow2img -cdrom $outputiso -boot d -m 256  #fail
# fail mo network card found
#qemu-system-x86_64  -net user -cdrom $PPool #fail
#timeout boot prompt
#sda error?? mounting mount sda to media?
#debug, early logs, 
#early out, late in: stufen
#fragt nacg ip?? preseeding geht nicht? oder file nicht gut?
#hw beschleuniger aktiv?
#install grub boot loader on a hard disk
#unabele to install GRUB in /dev/vda
#grub-install /dev/vda failed 
#d-i grub-installer/bootdev string /dev/vda against d-i grub-installer/bootdev string default, was ist vda??
#reboot?last question installation complete ! 

$qemu -m $ram -hda $qcow2img -boot order=c -redir tcp:2222::22 &
# time out
sleep 100
#wait till what?

test -e $HOME/.ssh/id_rsa ||echo -e  'y'|ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
#~/.ssh/id_rsa.pub.
#Next, add the contents of the public key file into ~/.ssh/authorized_keys on remote(guest)
#BLOCK: open instances of qemu window

ssh-keygen -f "$HOME/.ssh/known_hosts" -R [localhost]:2222

#ssh -vvv -o 'StrictHostKeyChecking no' -p 2222 root@localhost
ssh -q -o 'StrictHostKeyChecking no' -p 2222 root@localhost "cat /world"

#PermitRootLogin yes
#PermitEmptyPassword yes BLOCK auf guest
#log?
#Password authentication is disabled
# The authenticity of host '[localhost]:2222 ([127.0.0.1]:2222)' can't be established.
# ECDSA key fingerprint is SHA256:540TKj/Vm17r+GxX4q/dltooWEQ2WSuTNpg7JrN5/04.
# Are you sure you want to continue connecting (yes/no)? yes
# Warning: Permanently added '[localhost]:2222' (ECDSA) to the list of known hosts.
