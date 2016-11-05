U=$HOME
U=t
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export Qemuburo_install_dir=/home/$U/qemu-buro-point-dpkg/

cd;
whoami;
ls /root
echo "yes"|apt-get install -y qemu genisoimage wodim  whois git sudo python vim psmisc bash-completion

echo "yes"|apt-get --yes --force-yes install fuseiso 
apt-get --yes --force-yes install sudo
if test -e /usr/bin/fuseiso; 
then echo "no fuseiso found";
else 
echo "no fuseiso found"; 
a="/tmp/qemuburotest/debian.iso /tmp/qemuburotest/loopdir auto defaults,user 0 1"
grep "$a" /etc/fstab || echo "$a">>/etc/fstab
fi

# 
# #as user!
cd /home/t; rm -rf qemu-buro-point-dpkg/
sudo -H -u t bash -c 'cd;git clone https://github.com/qemu-buro-point-dpkg/qemu-buro-point-dpkg'

#su - $U -c "git clone https://github.com/qemu-buro-point-dpkg/qemu-buro-point-dpkg"
# su - $U -c " export Qemuburo_install_dir=`pwd`/qemu-buro-point-dpkg/"
#sudo -H -u t bash -c "export Qemuburo_install_dir=/home/$U/qemu-buro-point-dpkg/; cd; cd qemu-buro-point-dpkg/qemuburo/; echo $Qemuburo_install_dir; ls; python -m unittest Testqemuburo.qemuburoTestCase.test_all_preseediso2ssh"

#Test: Does it reach to stage 400, officalal base system  
sudo -H -u t bash -c "export Qemuburo_install_dir=/home/$U/qemu-buro-point-dpkg/; cd; cd qemu-buro-point-dpkg/qemuburo/; echo $Qemuburo_install_dir; ls; Regression='startstage=0 endstage=400 dropacopy=1 redir=2223' python -m unittest Testqemuburo.qemuburoTestCase.test_all_preseediso2ssh;"

# su - $U -c "python -m unittest Testqemuburo.qemuburoTestCase.test_all_preseediso2ssh"
#