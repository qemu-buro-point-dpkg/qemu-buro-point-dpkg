#useradd -m -p t -s /bin/bash t
#su t
cd;
whoami;
ls /home


# echo "yes"|apt-get install -y qemu genisoimage wodim  fuseiso whois git
# echo "yes"|apt-get install -y fuseiso 
# 
# #as user!
# cd;rm -rf qemu-buro-point-dpkg/
# git clone https://github.com/qemu-buro-point-dpkg/qemu-buro-point-dpkg
# export Qemuburo_install_dir=`pwd`/qemu-buro-point-dpkg/
# cd qemu-buro-point-dpkg/qemuburo/
# #short test, if unittest is set up: Ran 1 test in 0.112s OK
# python -m unittest Testqemuburo.qemuburoTestCase.test_all_preseediso2ssh&
#