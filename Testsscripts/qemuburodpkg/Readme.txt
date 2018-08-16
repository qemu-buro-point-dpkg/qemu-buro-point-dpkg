Readme:
This is alpha. A running prototype.

Usage: 
date Do 16. Aug 22:10:27 CEST 2018
#to generate images
cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_all_preseediso2ssh; 

bash /home/githubqemuburo/github_qemuburo/Testsscripts/qemuburodpkg/preseediso2ssh.sh --tmpdir /tmp/qemuburotest/ --endstage 10000 --startstage 000 --dropacopy 1 --redir 2222>>/tmp/qemuburotest/log.txt 2>&1


----------------------------------------------------------------------
Ran 1 test in 13017.042s

#to preserve a copy for caching or production:
cp -a /tmp/qemuburotest/ $HOME/Downloads/qemuburo_cache_production




Features: 
-from downloaded debian netinstall installation image 
 a qemu installation is performed, 
-keypressless (completely non-interactive), 
-ready for authenticated ssh login.
-This program provides debian flavor OSes with x, ssh etc on key press
-multi-stages processing, see files below
-cached mode possible, bandwith sparing, (just copy files manually to temporary directory)
-supporting a default preseeding interface 
-stage 800 copy persistant configs from cache
-cache debian packages downloaded: unsupported


Temporary Files: 
ls -lhrt /tmp/qemuburotest/|cut -c30-

 250M Jun 23 15:44 debian.iso # download image from mirror
 5,5K Jun 24 01:54 MD5SUMS
 3,1K Aug 16 18:14 preseed_test0.cfg
 4,0K Aug 16 18:23 loopdir
 4,0K Aug 16 18:23 targetisodir
 4,0K Aug 16 18:23 initdir
 281M Aug 16 18:23 test.iso # preseeded image
    6 Aug 16 19:34 world
 1,4G Aug 16 19:35 debian.qcowssh_ready_runnable600 # ssh log in working
 1,7G Aug 16 20:19 debian.qcower_icewm_lightdm_dillo700 # X working, stage 700, 
 
  216 Aug 16 20:21 worldXup
 178K Aug 16 21:51 log.txt
 3,0G Aug 16 22:17 debian.qcow # image being run, libreoffice installed




-Tutorial: -you can read the script as a tutorial for preseeding (compare URL pointers in code)
  -one can as well hold it as a but working (because tested) collection of command lines for such usecases


# obsolete, cause messy:

Tests: This got two q/a tested functionalities.
Tested on:
-host ubuntu 10.04, guest debian jessie 8.6


Install 
Follow the instructions and execute contents of install_on_local_maschine.sh!

Man
- see doc files packages 
-  

See examples file for commandlines and read Document Userinterface.(obsolete, messy)
-Example: 



