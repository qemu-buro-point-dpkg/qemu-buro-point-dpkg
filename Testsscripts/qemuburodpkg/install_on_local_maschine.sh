U=t
cd;
whoami;
ls /root
/tmp/qemuburotest/debian.iso /tmp/qemuburotest/initdir iso9660 loop,ro,noauto,user 0 0
echo "yes"|apt-get install -y qemu genisoimage wodim  whois git sudo python vim

# echo "yes"|apt-get install -y fuseiso 
echo "/tmp/qemuburotest/debian.iso /tmp/qemuburotest/initdir iso9660 loop,ro,noauto,user 0 0">>/etc/fstab

# 
# #as user!
cd /home/t; rm -rf qemu-buro-point-dpkg/
sudo -H -u t bash -c 'cd;git clone https://github.com/qemu-buro-point-dpkg/qemu-buro-point-dpkg'

#su - $U -c "git clone https://github.com/qemu-buro-point-dpkg/qemu-buro-point-dpkg"
# su - $U -c " export Qemuburo_install_dir=`pwd`/qemu-buro-point-dpkg/"
sudo -H -u t bash -c "export Qemuburo_install_dir=/home/$U/qemu-buro-point-dpkg/; cd; cd qemu-buro-point-dpkg/qemuburo/; echo $Qemuburo_install_dir; ls; python -m unittest Testqemuburo.qemuburoTestCase.test_all_preseediso2ssh"


# su - $U -c "python -m unittest Testqemuburo.qemuburoTestCase.test_all_preseediso2ssh"
#