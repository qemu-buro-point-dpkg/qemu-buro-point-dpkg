#!/usr/bin/env python
# -*- coding: utf-8 -*-
# unittest 
# Author: 
# 
# License: GPL 
# Version: 04/13/2015


#usage: 
#2)python Testqemuburo.py
#3)~/github_qemuburo/qemuburo$ python -m unittest Testqemuburo.qemuburoTestCase.test_pre_and_post_instalaion_tests_from_qemu_generation_to_ready_use_image

#.
#----------------------------------------------------------------------
#Ran 1 test in 0.063s

#OK

import sys
import os
import shutil
#print "update loaded modules"
#sys.path.append("/home/kubuntu/freecad/lib/")
# There is existing a environment variable from the set from the installer user: 1) search for python modules there! 
# Structure: If not set, add application dirs of project. 
if str(sys.path).rfind(os.environ["Qemuburo_install_dir"]+"qemuburo")<1:
    sys.path.append(os.environ["Qemuburo_install_dir"]+"qemuburo")
    sys.path.append(os.environ["Qemuburo_install_dir"]+"Testsscripts/bebo/")
    sys.path.append(os.environ["Qemuburo_install_dir"]+"Testsscripts/scandistribute/")

#print str(sys.path).rfind(os.environ["Qemuburo_install_dir"]+"qemuburo")
#print str(sys.path)
import unittest
#reload
#del sys.modules["qemuburo"]
#import qemuburo
import logging
#import bebo_report_engine

class qemuburoTestCase(unittest.TestCase):
    def setUp(self):
	#print "prepare some stuff in order to run the test"
	import glob
	self.testpath = '/tmp/qemuburotest/' #Space for tests execution
	self.testsscripts = os.environ["Qemuburo_install_dir"]+"Testsscripts/"
	self.testpathressources= os.environ["Qemuburo_install_dir"]+"Testresources/"
	#code to be tested
	self.debugflag=100000
	try:
	    self.testbebo_profile=os.environ["Qemuburo_bebo_profile"]
	except:
	    pass

	try:
	    self.regession=os.environ["Regression"]
	except:
            self.regession=""
            #print "noregression"
	    pass

	if not os.path.exists(self.testpath):	    
	    try:
		os.makedirs(self.testpath)
	    except:
		pass
	line=self.regession
	parts = line.split(" ")
	self.stripped=[i.split("=") for i in parts]
	self.regessionnr="0" #clean full run
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="Regression":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.regessionnr=self.stripped[i2][1]
                

	line=self.regession

	if self.regessionnr=="1":
            #print "postregression no cleaning"
            pass
        else:
            #print "cleaning tmp"
            #clean for new test
            filelist = glob.glob(self.testpath+"*")
            for f in filelist:
                #print f
                try:os.remove(f)
                except:pass
                try:shutil.rmtree(f)
                except:pass
	
	from argparse import ArgumentParser
		
	parser = ArgumentParser(description=__doc__)
	group = parser.add_mutually_exclusive_group()
	group.add_argument('-v', '--log', help='Verbose (debug) logging', action='store_const', const=logging.DEBUG,
			dest='loglevel')
	group.add_argument('-q', '--quiet', help='Silent mode, only log warnings', action='store_const',
			const=logging.WARN, dest='loglevel')
	parser.add_argument('--dry-run', help='Noop, do not write anything', action='store_true')
	parser.add_argument('file', nargs='+', help='Files to overwrite with FOOBAR')
	args = parser.parse_args()

	
	args = parser.parse_args()
	#print args
	if "args"!="":
	    level=args.loglevel
	else:
	    level=logging.ERROR

	#CRITICAL	50
	#ERROR	40
	##WARNING	30
	#INFO	20
	#DEBUG	10
	#NOTSET	0 or logging.INF
  


	
	
	logging.basicConfig(format='%(levelname)s:%(message)s', level=args.loglevel)
	#logging.info('Doing something')
	#print action
	if not os.path.exists("/tmp/setupdone"):
            os.makedirs("/tmp/setupdone")
	#msec	  
	#logging.Formatter(fmt='%(asctime)s.%(msecs)03d',datefmt='%Y-%m-%d,%H:%M:%S') 
	#from http://stackoverflow.com/questions/6290739/python-logging-use-milliseconds-in-time-format
	#for one file


    def test_template(self):
	filelist=[\
	    "doctemp001-p002.tiff",\
	    "doctemp001-p002.tiff",\
	    "doctemp001-p002.tiff"]



	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   

	#Oracle:
	#16804 Mär  9 18:29 tmp_graph_1.eps
	self.failUnless(os.stat(self.testpath+"doctemp001-p002.tiff").st_size>1804)

    def test_all_preseediso2ssh(self):
	'''
	regression test (overall test preseediso2ss)
	'''
	filelist=["preseed_test0.cfg"]



	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   

	#print "self.regession "+self.regession
	self.startstage="000" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="startstage":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.startstage=self.stripped[i2][1]
                
        self.endstage="10000" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="endstage":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.endstage=self.stripped[i2][1]
                
        self.dropacopy="1" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="dropacopy":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.dropacopy=self.stripped[i2][1]
                
        self.redir="2222" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="redir":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.redir=self.stripped[i2][1]
                
        #print self.endstage + self.startstage
        
	command= "bash "+self.testsscripts+"qemuburodpkg/preseediso2ssh.sh "+"--tmpdir " + self.testpath +" --endstage " + self.endstage+" --startstage " + self.startstage + " --dropacopy " + self.dropacopy +" --redir " + self.redir +">>"+self.testpath+"log.txt 2>&1"
	#--nstaples 2 --duplex 2 --slot nonadf --startstage startstage2
        print command
	os.system(command)
	#oracle: return ok, if X is up and if ssh is up
	self.failUnless(os.stat(self.testpath+"world").st_size>4)
	self.failUnless(os.stat(self.testpath+"worldXup").st_size>50)
	

    def test_install_on_local_maschine_preseediso2ssh(self):
	'''
	postregression install test on vm installs mudanca project and run to stage 400 
	'''
	#print "self.regession "+self.regession
	self.startstage="500" #default                
        self.endstage="500" #default                               
        self.redir="2224" #default
        self.qcow2img="debian.qcower_icewm_lightdm_dillo700"
                
 	command='pkill -f "qemu.*-redir tcp:"'+self.redir
        #print command
	os.system(command)

 	command='cp '+ self.testpath + self.qcow2img + ' '+ self.testpath+self.qcow2img+'_'
        #print command + " >> "+self.testpath+"log.txt 2>&1"
	os.system(command)
	#make a copy pls
 	
 	#fire up that one machine
 	command= "bash "+self.testsscripts+"qemuburodpkg/preseediso2ssh.sh "+"--tmpdir " + self.testpath + " --endstage " + self.endstage+" --startstage " + self.startstage + " --qcow2img " + self.qcow2img +"_ --redir " + self.redir +">>"+self.testpath+"log.txt 2>&1"
	#--nstaples 2 --duplex 2 --slot nonadf --startstage startstage2
        print command
	os.system(command)
	
        ##scp install_on_local_maschine_preseediso2ssh to 2224
        ## sleep 100; login, copy local script
        sleep="sleep 100;"
        command= sleep + "(cat " + self.testsscripts + "qemuburodpkg/install_on_local_maschine.sh | ssh -q -o 'StrictHostKeyChecking no' -p " + self.redir + " root@localhost 'cat >install_on_local_maschine.sh')" +">>"+self.testpath+"log.txt 2>&1"
        
        print command
	os.system(command)
	
	#run local script
        command= "ssh -q -o 'StrictHostKeyChecking no' -p " + self.redir + " root@localhost bash install_on_local_maschine.sh"+">>"+self.testpath+"log.txt 2>&1"
        
        #print command
	os.system(command)
	
	#at the end fetch the oracle
	command= "ssh -q -o 'StrictHostKeyChecking no' -p " + self.redir + " root@localhost ls /tmp/qemuburotest/test.iso"+">>"+self.testpath+"worldvminstallinvm 2>&1"
        #print command
	os.system(command)

	
        #oracle: return ok, if tests.iso (stage 3 output) is found
	self.failUnless(os.stat(self.testpath+"worldvminstallinvm").st_size>8)
	#"ls /tmp/qemuburotest/test.iso">/tmp/qemuburotest/worldvminstallinvm


    def test_stage2_multistaple_duplex_orc_scanning_to_distributed_pdfs_scanndistribute150825(self):
	'''
	Ran 1 test in 82.374s OK one page through all stages
	#multistaple,duplex,stage2, stage 3 distributing
	does not touch physical scanner device, stage1 skipped
	'''
		#print "self.regession "+self.regession
	self.startstage="000" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="startstage":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.startstage=self.stripped[i2][1]
                
        self.endstage="10000" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="endstage":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.endstage=self.stripped[i2][1]
 
	filelist=[\
	    "doctemp001-p002.tiff",\
	    "doctemp001-p001.tiff",\
	    "doctemp002-p001.tiff",\
	    "doctemp003-p001.tiff",\
	    "doctemp004-p002.tiff",\
	    "scandistribute.conf",\
	    "scandistribute2.conf.sh",\
	    "doctemp004-p001.tiff"]



	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   

	#from mudanca
	#command= "bash "+self.testsscripts+"qemuburodpkg/preseediso2ssh.sh "+"--tmpdir " + self.testpath +" --endstage " + self.endstage+" --startstage " + self.startstage + " --dropacopy " + self.dropacopy +" --redir " + self.redir +">>"+self.testpath+"log.txt 2>&1"
	
	command= "bash "+self.testsscripts+"scandistribute/scanndistribute150825.sh  " +" --tmpdir "+ self.testpath \
	+" --config "+ self.testpath + "scandistribute.conf"\
	+" --config2 "+ self.testpath +"scandistribute2.conf.sh"\
	+" --endstage " + self.endstage+" --startstage " + self.startstage + " --nstaples 2 --duplex 2 --slot nonadf --startstage_  startstage2 >> "+self.testpath+"log.txt 2>&1"
	print command
	os.system(command)
	

        #oracle 1: pdf-bound-t0-65M test, cumulative file size
        #command= 
        self.failUnless(os.stat(self.testpath+"doctempbundle.pdf").st_size>20000008)
        # doctempbundle.pdf
        
        #oracle 2: ocr-to-0.6M-pdf-okular-up-test, cumulative file size
	#command=
	 	
        if int(self.endstage)>=400:
            self.failUnless(os.stat(self.testpath+"doctempbundlesandw1.pdf").st_size>300000)
            #todo: + search for string + "tail durch ihr Verhalten verhindern" logs,
            #todo: + seach ps ax|grep "okular|sandw1"|
            
            #oracle 3: sade-path test
            #command= "bash "+self.testsscripts+"scanndistribute150825.sh  " +" 2 2 "+ self.testpath + " 1 nonadf  startstage2  >> "+self.testpath+"log.txt 2>&1"
            #oracle 3
            self.failUnless(os.stat(self.testpath+"Bescheide/Verwaltungsakte/Vereinbarung/DialektikderAufklaerung/Undinger/bedingungslosesgrundeinkommenfueralleMenschenaufderweltjetzt/oderderboeseonkelkantkommtauchnoch/oderderliebeonkelsade/Gliedi.pdf").st_size>16804)

	#print self.testpath+"doctemp004-p001.tiff"

    def test_is_flatbad_one_page_orc_scanning_to_pdf_scanndistribute150825(self):
	'''
	Ran 1 test in 25.923s OK one page through all stages
	touches  physical scanner device
	#non_multistaple,nonduplex,non_adf, (adf)
	to be done: -second_stage,multistaple,nonduplex
	-adf tests_all_stages
	-hide all the output on screen to log
	-distrubutioncode, stage 3 too
	-scanimage capaple user?, everything installed? myocrpdf, okular, scanimage, pdftk
	'''
	
	#command= "bash "+self.testsscripts+"dummybashscript.sh  " +" 2 4 "+ self.testpath + " 1 1"
	#print command 
	#os.system(command)

	
	#command= "bash "+self.testsscripts+"scanndistribute150825.sh  " +" 1 1 "+ self.testpath + " 1 nonadf >> "+self.testpath+"log.txt 2>&1"
	command= "bash "+self.testsscripts+"scandistribute/scanndistribute150825.sh  " +" --tmpdir "+ self.testpath + " --nstaples 1 --duplex 1 --slot nonadf --stage1batchmode 1 >> "+self.testpath+"log.txt 2>&1"
	print command 
	os.system(command)
	#Oracle:
	self.failUnless(os.stat(self.testpath+"doctempbundlesandw1.pdf").st_size>16804)
	#as we do not know, if on the paper original is any text, we are happy that there is a pdf with the name and some contents in.
 
	#print command
	#knows problems logs:
	#okular: cannot connect to X server :0 # use first ubuntu user #k
	#I/O Error: Permission denied.#k ?__?: use first ubuntu user for execution #k
	#scanimage: no SANE devices found, was installed?
	# am I  scanimage capaple user?k
	#scanimage: sane_start: Document feeder out of documents
	#  how do I check if feeder is filled?__? o
	#bash: /opt/OCRmyPDF-2.2-stable/OCRmyPDF.sh: not found? k
	# ?__? Annoying me that scanner is not mute, beepsk at display k
	#
    
    def test_qa_ui_hw_1_staple_leafs_and_slots_non_interactively_through_all_stages(self):
	'''
	Tests for hw:1 staple in slot non interactivly (feature ui, hw)
              for overall usage (qa)
	'''
		#print "self.regession "+self.regession
	self.startstage="000" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="startstage":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.startstage=self.stripped[i2][1]
                
        self.endstage="10000" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="endstage":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.endstage=self.stripped[i2][1]
 
	filelist=[\
	    #"doctemp001-p002.tiff",\
	    #"doctemp001-p001.tiff",\
	    #"doctemp002-p001.tiff",\
	    #"doctemp003-p001.tiff",\
	    #"doctemp004-p002.tiff",\
	    "scandistribute.conf",\
	    "scandistribute2.conf.sh"]



	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   

	#from mudanca
	#command= "bash "+self.testsscripts+"qemuburodpkg/preseediso2ssh.sh "+"--tmpdir " + self.testpath +" --endstage " + self.endstage+" --startstage " + self.startstage + " --dropacopy " + self.dropacopy +" --redir " + self.redir +">>"+self.testpath+"log.txt 2>&1"
	
	command= "bash "+self.testsscripts+"scandistribute/scanndistribute150825.sh  " +" --tmpdir "+ self.testpath \
	+" --config "+ self.testpath + "scandistribute.conf_donotread"\
	+" --config2 "+ self.testpath +"scandistribute2.conf.sh"\
	+" --endstage " + self.endstage+" --startstage " + self.startstage + " --nstaples 1 --duplex 1 --rmdoctemp 1 --stage1batchmode 1 >> "+self.testpath+"log.txt 2>&1"
	print command
	os.system(command)
	

        #oracle 1: case 1 staple non duplex test: is on 1 read file of . tiff and naming and size there?
        #command= 
        self.failUnless(os.stat(self.testpath+"doctemp001-p001.tiff").st_size>64130)
        #1064130 Nov 18 22:52 doctemp001-p001.tiff

        
        # doctempbundle.pdf
        
        #oracle 2: ocr-to-0.6M-pdf-okular-up-test, cumulative file size
	#command=
	if int(self.endstage)>=400:
            self.failUnless(os.stat(self.testpath+"doctempbundlesandw1.pdf").st_size>100000)
            #todo: + search for string + "tail durch ihr Verhalten verhindern" logs,
            #todo: + seach ps ax|grep "okular|sandw1"|
            #oracle 3: sade-path test
            #command= "bash "+self.testsscripts+"scanndistribute150825.sh  " +" 2 2 "+ self.testpath + " 1 nonadf  startstage2  >> "+self.testpath+"log.txt 2>&1"
            #oracle 3
            self.failUnless(os.stat(self.testpath+"Bescheide/Verwaltungsakte/Vereinbarung/DialektikderAufklaerung/Undinger/bedingungslosesgrundeinkommenfueralleMenschenaufderweltjetzt/oderderboeseonkelkantkommtauchnoch/oderderliebeonkelsade/Gliedi.pdf").st_size>16804)

	#print self.testpath+"doctemp004-p001.tiff"

    def test_at_number_157_after_physical_paper_feeding_error_to_be_continued_non_interactively_through_all_stages(self):
	'''
	Tests for hw:1 staple in slot non interactivly (feature ui, hw)
              for overall usage (qa)
	'''
		#print "self.regession "+self.regession
	self.startstage="000" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="startstage":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.startstage=self.stripped[i2][1]
                
        self.endstage="10000" #default
	for i2 in range(len (self.stripped)):
            if self.stripped[i2][0]=="endstage":
                #print self.stripped[i2][1]
                #print self.stripped[i2][0]
                self.endstage=self.stripped[i2][1]
 
	filelist=[\
	    #"doctemp001-p002.tiff",\
	    "doctemp001-p001.tiff",\
	    #"doctemp002-p001.tiff",\
	    #"doctemp003-p001.tiff",\
	    #"doctemp004-p002.tiff",\
	    "scandistribute.conf",\
	    "scandistribute2.conf.sh"\
                ]



	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   

	#from mudanca
	#command= "bash "+self.testsscripts+"qemuburodpkg/preseediso2ssh.sh "+"--tmpdir " + self.testpath +" --endstage " + self.endstage+" --startstage " + self.startstage + " --dropacopy " + self.dropacopy +" --redir " + self.redir +">>"+self.testpath+"log.txt 2>&1"
	
	command= "bash "+self.testsscripts+"scandistribute/scanndistribute150825.sh  " +" --tmpdir "+ self.testpath \
	+" --config "+ self.testpath + "scandistribute.conf_donotread"\
	+" --config2 "+ self.testpath +"scandistribute2.conf.sh"\
	+" --endstage " + self.endstage+" --startstage " + self.startstage + " --nstaples 1 --duplex 1 --stage1batchmode 1 --istart 1 --leafstart 2 --display_time 36000 --printout 1 >> "+self.testpath+"log.txt 2>&1"
	print command
	os.system(command)
	

        #oracle 1: case 1 staple non duplex test: is on 1 read file of . tiff and naming and size there?
        #command= 
        self.failUnless(os.stat(self.testpath+"doctemp001-p001.tiff").st_size>64130)
        #1064130 Nov 18 22:52 doctemp001-p001.tiff

        
        # doctempbundle.pdf
 	if int(self.endstage)>=400:
            #oracle 2: ocr-to-0.6M-pdf-okular-up-test, cumulative file size
            #command=
            self.failUnless(os.stat(self.testpath+"doctempbundlesandw1.pdf").st_size>100000)
            #todo: + search for string + "tail durch ihr Verhalten verhindern" logs,
            #todo: + seach ps ax|grep "okular|sandw1"|
            
            #oracle 3: sade-path test
            #command= "bash "+self.testsscripts+"scanndistribute150825.sh  " +" 2 2 "+ self.testpath + " 1 nonadf  startstage2  >> "+self.testpath+"log.txt 2>&1"
            #oracle 3
            self.failUnless(os.stat(self.testpath+"Bescheide/Verwaltungsakte/Vereinbarung/DialektikderAufklaerung/Undinger/bedingungslosesgrundeinkommenfueralleMenschenaufderweltjetzt/oderderboeseonkelkantkommtauchnoch/oderderliebeonkelsade/Gliedi.pdf").st_size>16804)

	#print self.testpath+"doctemp004-p001.tiff"
    
    #def test_qa_print_it_as_ordinary_copy_maschine(self):

    def test_pre_and_post_instalaion_tests_from_qemu_generation_to_ready_use_image(self):
	pass
	return
    

    
    def test_prepares_preeseeded_install(self):
	pass
	return
	#preeseeded_install(self.latexpdf)
	#Oracle:	self.failUnless(os.stat(self.testpath+"Readmeqemuburu.txt").st_size==60723)


    def test_bebo_report_engine_valid_pdf_from_text_bricks_and_addresses(self):
	filelist=[\
	    "pic_2_report_piece1_valid_direct_complete.png",\
	    "pic_1_report_piece1_valid_direct_complete.png"]



	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   

	self.report_table_tex=[[['2D heat conduction analysis with elmer-gmsh-python tool chain', ''], ['quadrangles and treshold mesh size at vertices', ''], ['There has been found over mesh size converging plateau. The results are therefore: usable', ''], ['', ''], ["['flux-elmer', 'gmsh-minsize', 'gmsh-maxsize', 'nodes-el-bnd', 'T min', 'T at A', 'T at b', 'T at c', 'T at d', 'T at e', 'T at f', 'T at g', 'T at h', 'T at i']", "[-9.514125896996, '0.000134846556315', '5.3938622526', '279    271    52   ', '2.737317717687E+002', '2.800945438183E+002', '-3.000312954969E-001', '-1.617285991924E-002', '-1.268605172516E+001', '1.406335645152E-002', '1.103134932622E+001', '0.000000000000E+000', '0.000000000000E+000', '0.000000000000E+000']"], ['Kelvin Boundary 1-2 ', '273.0 - 293.0'], ['Rsi,e  Km\xc2\xb2/W', '0.06 - 0.11'], ['[lambda, material] /body  ', "[[1.15, u'Beton'], [0.12, u'Holz'], [0.029, u'Waermedaemung'], [230.0, u'Aluminium']]"], ['S3prepgeo3', 0], ['S4msh', -0.0], ['S4.1cert', -7.587], ['S5solv', -0.124], ['S6rdsavesc', -0.6], ['s7end', -0.0005]], [['2D heat conduction analysis with elmer-gmsh-python tool chain', ''], ['Triangle and tplan mesh size at vertices', ''], ['There has been found over mesh size converging plateau. The results are therefore: usable', ''], ['', ''], ['S3prepgeo3', 0], ['S4msh', -0.0], ['S4.1cert', 'testdata'], ['S5solv', -0.037], ['S6rdsavesc', -0.35], ['s7end', -0.0006]]]
	self.texpics=['pic_1_report_piece1_valid_direct_complete.png', 'pic_2_report_piece1_valid_direct_complete.png']
	
    #def bebo_report_engine.prepares_filelist_valid_cummulative_tex(self.report_table_tex, self.texpics, self.testpath, debug=1001):
        #''' #6901 Mär  1 00:49 pic_2_report_piece1_valid_direct_complete.png
        ##6901 Mär  1 00:49 pic_1_report_piece1_valid_direct_complete.png
        ##16804 Mär  9 19:00 tmp_graph_1.eps
        ##2201 Mär  9 19:00 cumulative1.tex
        ##self.failUnless(os.stat(self.testpath+"cumulative1.tex").st_size==2201)'''
        #latexpdf="/usr/bin/pdflatex"
        #self.cumulativetex_file="cumulative1.tex"
        #bebo_report_engine.prepares_pdf_cummulativ_tex_and_latexpdf(latexpdf, self.cumulativetex_file, self.testpath, debug=1000)	
        #self.failUnless(1200< os.stat(self.testpath+"cumulative1.pdf").st_size <60400)

        #pass
        ##Oracle:	self.failUnless(os.stat(self.testpath+"Readmeqemuburu.txt").st_size==60723
        #return
    
    def test_multiple_AzAeA_lcgsp_ready_for_mailing(self):
	pass
	#Oracleself.failUnless(os.stat(self.testpath+"Readmeqemuburu.pdf, interim report files ").st_size==60723
	return
    
    def test_twgc_plain_gnu_to_guest_AzAeA(self):
	filelist=[\
	    "twgc_plain_gnu_jobboerse.arbeitsagentur.de_Elekroingenieur_Berlin_10_takes_rambo_style_5_2016"]



	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   
	#pass
	#print "hell"
	self.pathtovoult=self.testpath+f
	#print "the voult Test" +self.pathtovoult
	
	AzAeAL=bebo_report_engine.twgc_plain_gnu_to_guest_AzAeA(self.pathtovoult, self.testpath, debug=1000)	
	
	#Oracle
	self.failUnless(os.stat(self.testpath+"guest_AzAeA").st_size==1079)
	
	profile_dir=self.testbebo_profile+"local_profiles/local_profile1/"
	asprm_file=""
	bebo_report_engine.multiple_AzAeA_lcgsp_ready_for_mailing(self.testpath+"guest_AzAeA", self.testpath,AzAeAL,profile_dir,"", debug=1000)
	
	self.failUnless(os.stat(self.testpath+"guest_AzAeA").st_size==1079)

	return

    def test_twgc_plain_gnu_2_mailing_pdf(self):
	pass
	#Oracleself.failUnless(os.stat(self.testpath+"Readmeqemuburu.AzAeA ").st_size==60723
	return
 
    def test_buildingdamon_say_hello(self):
	pass
        filelist=[\
	    #"doctemp001-p002.tiff",\
	    "Buildingloggerdemon.userconfig.sh",\
	    "tmp_triggertimes.log"] 
            #program timetables
        command= "cp -r " + self.testpathressources + "/Buildingdemon "+ self.testpath 
                
        ##''' how populated the test dirs 
        ##urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ##wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ##let n=0
        ##let abase=1000
        ##let bbase=1000
        ##let incrementor=5 #lines
        ##mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ##find a/ -name "**" -type d|tee 1
        ##for i in `cat 1`; 
            ##do let n+=1; 
            ##let abase=bbase
            ##let bbase=abase+incrementor
            ##s=`cat 2|sed -n "$abase,$bbase"p`
            
            ##echo "$s">$i.txt; 
            ##echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ##done

        ##'''
        ### how to prepare user config to call a (libreoffice)-greeter
        #patch the 
        ###
        
        print("Layer -1 "+command)
	os.system(command)
	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)  
	self.timetoken=1234567890 #seconds from now
	ratio=40.0 #it is tune a time test window of demon running that we got a eight time slots in a 200 a ms from its samples.
	timetoken_from_now_offset=13.4/ratio# for python test runtime window #
	timetoken_from_now_offset2_sec=1 #for to place a ticket from now
	timetoken_from_now_offset2_ns=1000000000
        self.samplerate=(0.20/ratio) # +ratio in seconds, in gnu coreutils sleep
        a=1;b=2.0;c=a/b; print(c)
        print("Layer -1 + self.samplerate "+str(self.samplerate)+"  c "+str(c))
	
	runtime_window=(timetoken_from_now_offset+self.samplerate*1.1)
        #2,2 s
	import subprocess
	nowdateinseconds = subprocess.check_output(['date', "+%s%N"])
	#os.system('date')
	
	self.timetoken=int(nowdateinseconds)+int(timetoken_from_now_offset2_sec*timetoken_from_now_offset2_ns/ratio) #last a second to event
        print("Layer -1 nowdatei ns econds"+nowdateinseconds+" timetoken "+str(self.timetoken))
	self.testdebug="1" #on, huge logs non defaults
	self.every=int(self.samplerate*1000000000) #frequence intervall, length in ns, here as long as a step is: 1 second, but reclaimed in nano
	self.times="1" #periods admitted
        
        a=""
        if self.regession!="":
            a=" --userconfigpath "+ str(self.regession)
            
        command= "bash "+self.testsscripts+"/buildingdamon/Buildingloggerdemon.sh  " +" --tmpdir "+ self.testpath \
            +" --samplerate "+ str(self.samplerate) \
            +" --timetoken "+ str(self.timetoken) \
            +" --every "+ str(self.every) \
            +" --times "+ str(self.times) \
            +" --testdebug "+ str(self.testdebug) \
            + a +" &"
        print("Layer -1 "+command)
	os.system(command)
	import time
	#test runtime window
        time.sleep(runtime_window)
	
	#clean from global process list 
        command= "date; ps ax|grep Buildingloggerdemon.sh|grep -v grep;kill $(ps ax|grep Build|cut -c -6)" # > /dev/null 2"
        print("Layer -1 kill: "+command)
	os.system(command)
        
        #command= "grep 'a' "+self.testpath+"tmp_triggertimes.log > "+self.testpath+"tmp_first_and_second_beat_hit.test"
        #print("Layer -1: "+command)
	#os.system(command)
		
	#Oracle:
	#16804 Mär  9 18:29 tmp_graph_1.eps
	self.failUnless(os.stat(self.testpath+"/Buildingdemon/a/e.txt").st_size>334)
        #self.failUnless(False)
	#self.failUnless(os.stat(self.testpath+"tmp_first_and_second_beat_hit.test").st_size>9)
        #Test_five_times_every tuesday execute_a_greeter_using_user_greeter_utc_2_hrdf_project_interface_basing_on_a_stampable_time_table
	##Test_go_once_a_year_fill_the_# implement frequency and phase offset, in table as postfix
	self.failUnless(os.stat(self.testpath+"tmp_triggertimes.log").st_size>267)
	return

    def test_soffice_uno_raw(self):
	pass
        filelist=[\
	    #"doctemp001-p002.tiff",\
	    #"doctemp001-p002.tiff",\
	    "doctemp004-p003.tiff"]
        command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ##'''
        ##urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ##wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ##let n=0
        ##let abase=1000
        ##let bbase=1000
        ##let incrementor=5 #lines
        ##mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ##find a/ -name "**" -type d|tee 1
        ##for i in `cat 1`; 
            ##do let n+=1; 
            ##let abase=bbase
            ##let bbase=abase+incrementor
            ##s=`cat 2|sed -n "$abase,$bbase"p`
            
            ##echo "$s">$i.txt; 
            ##echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ##done

        ##'''
        #u="pwd"
        #print(u)
        print(command)
	os.system(command)
	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   

        a=""
        if self.regession!="":
            a=" --config_file "+ str(self.regession)
        else:
            a=" --config_file "+self.testsscripts+"losed/losed_config.py" 
            
        command= "python3 "+self.testsscripts+"losed/losed.py " +" --loadComponentFromabsoluteURL "+ self.testpath +"Buildingdemon/b/e/i/test1.doc"\
            + a 
        
        print(command)
	os.system(command)
	
	#Oracle:
	self.failUnless(os.stat(self.testpath+"logs").st_size>21)
	return

    def test_superscript_losed_letter(self):
	#invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	pass
        filelist=[\
	    "1.tmp",\
	    "2.tmp",\
	    "3.tmp",\
	    "4.tmp",\
	    "5.tmp",\
	    "emptyodttemplate.odt"]
	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   
        command= "bash "+self.testsscripts+"losed/superscript_losed_letter.sh  "  +" --losedpy "+self.testsscripts+"losed/losed.py " #\
            #" --insert "+self.testsscripts+"losed/losed.py "
        print(command)
	os.system(command)
	
	#Oracle:
	self.failUnless(os.stat(self.testpath+"tmpfile7.odt").st_size>10258)
	return

    def test_10_viable_job_applications(self):
        #todo: touch driver_fault2db.sh 20_job_application.sh 30 private_tasks_storage_script.sh 
	#invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	pass
        filelist=[\
            "emptyodttemplate.odt",\
            "Buildingdemon/a/g/h/Johann_Peter_Eckermann_Gespraeche_mit_Goethe_in_den_letzten_Jahren_seines_Lebens18_10_1827.txt",\
	    "twgc_plain_gnu_jobboerse.arbeitsagentur.de_Elekroingenieur_Berlin_10_takes_rambo_style_5_2016"]
        
	import shutil
	for f in filelist:
	    f1=os.path.basename(f)
	    dst=self.testpath+f1 #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   

        command= "bash "+self.testsscripts+"losed/20_job_application.sh  "
        print(command)
	os.system(command)
	
	#Oracle:
	self.failUnless(os.stat(self.testpath+"logsdriver").st_size>6) #more than 6 hits(reliable input interfaces of a letter)?ok	
	#self.failUnless(os.stat(self.testpath+"Herr_Weachy_18.10.1827.pdf").st_size>17200)
	return

    #def test_t20ja-flat(self):
	##invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	#pass
        #filelist=[\
	    ##"doctemp001-p002.tiff",\
	    ##"doctemp001-p002.tiff",\
	    #"doctemp004-p003.tiff"]
        #command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ###'''
        ###urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ###wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ###let n=0
        ###let abase=1000
        ###let bbase=1000
        ###let incrementor=5 #lines
        ###mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ###find a/ -name "**" -type d|tee 1
        ###for i in `cat 1`; 
            ###do let n+=1; 
            ###let abase=bbase
            ###let bbase=abase+incrementor
            ###s=`cat 2|sed -n "$abase,$bbase"p`
            
            ###echo "$s">$i.txt; 
            ###echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ###done

        ###'''
        ##u="pwd"
        ##print(u)
        #print(command)
	#os.system(command)
	#import shutil
	#for f in filelist:
	    #dst=self.testpath+f #
	    #src=self.testpathressources+f
	    ##print dst,src
	    #shutil.copyfile(src,dst)   
        #command= "bash "+self.testsscripts+"yournextgnuclihelloprojectdemo.sh  " +" --tmpdir "+ self.testpath 
        #print(command)
	#os.system(command)
	
	##Oracle:
	#self.failUnless(os.stat(self.testpath+"logs").st_size>91)
	#return

    def test_testslogger(self):
	#invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	pass
        self.testpath="/tmp/qemuburotestlog/"
        filelist=[\
	    #"doctemp001-p002.tiff",\
	    #"doctemp001-p002.tiff",\
	    "doctemp004-p003.tiff"]
        command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ##'''
        ##urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ##wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ##let n=0
        ##let abase=1000
        ##let bbase=1000
        ##let incrementor=5 #lines
        ##mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ##find a/ -name "**" -type d|tee 1
        ##for i in `cat 1`; 
            ##do let n+=1; 
            ##let abase=bbase
            ##let bbase=abase+incrementor
            ##s=`cat 2|sed -n "$abase,$bbase"p`
            
            ##echo "$s">$i.txt; 
            ##echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ##done

        ##'''
        #u="pwd"
        #print(u)
        print(command)
	os.system(command)
	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src 
	    shutil.copyfile(src,dst)   
        command= "bash "+self.testsscripts+"release/testlogger.sh  " +" --tmpdir "+ self.testpath 
        print(command)
	os.system(command)
	
	#Oracle:
	self.failUnless(os.stat(self.testpath+"logs").st_size>9)
	return

    #def test_20ja_bleeding_edge_test_sikuli_wohnungs_webifdb_prototyp_to_CAD-programmers-juggling_textsnipped(self):
	##invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	#pass
        #filelist=[\
	    ##"doctemp001-p002.tiff",\
	    ##"doctemp001-p002.tiff",\
	    #"doctemp004-p003.tiff"]
        #command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ###'''
        ###urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ###wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ###let n=0
        ###let abase=1000
        ###let bbase=1000
        ###let incrementor=5 #lines
        ###mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ###find a/ -name "**" -type d|tee 1
        ###for i in `cat 1`; 
            ###do let n+=1; 
            ###let abase=bbase
            ###let bbase=abase+incrementor
            ###s=`cat 2|sed -n "$abase,$bbase"p`
            
            ###echo "$s">$i.txt; 
            ###echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ###done

        ###'''
        ##u="pwd"
        ##print(u)
        #print(command)
	#os.system(command)
	#import shutil
	#for f in filelist:
	    #dst=self.testpath+f #
	    #src=self.testpathressources+f
	    ##print dst,src
	    #shutil.copyfile(src,dst)   
        #command= "bash "+self.testsscripts+"yournextgnuclihelloprojectdemo.sh  " +" --tmpdir "+ self.testpath 
        #print(command)
	#os.system(command)
	
	##Oracle:
	#self.failUnless(os.stat(self.testpath+"logs").st_size>91)
	#return

    def test_beantrager(self):
	#invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	
	pass
        filelist=[\
	    #"doctemp001-p002.tiff",\
	    #"doctemp001-p002.tiff",\
	    "foo.pdf"]
        command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ##'''
        ##urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ##wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ##let n=0
        ##let abase=1000
        ##let bbase=1000
        ##let incrementor=5 #lines
        ##mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ##find a/ -name "**" -type d|tee 1
        ##for i in `cat 1`; 
            ##do let n+=1; 
            ##let abase=bbase
            ##let bbase=abase+incrementor
            ##s=`cat 2|sed -n "$abase,$bbase"p`
            
            ##echo "$s">$i.txt; 
            ##echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ##done

        ##'''
        #u="pwd"
        #print(u)
        
        
        
        a=""
        if self.regession!="":
            a=" --userconfigpath "+ str(self.regession)
            
        #print(command)
	#os.system(command)
	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   
        command= "bash "+self.testsscripts+"beantrager/beantrager.sh  " +" --tmpdir "+ self.testpath \
            + a +" #&"
        print(command)
	os.system(command)
	
        ###command= "bash "+self.testsscripts+"/buildingdamon/Buildingloggerdemon.sh  " +" --tmpdir "+ self.testpath \
            ###+" --samplerate "+ str(self.samplerate) \
            ###+" --timetoken "+ str(self.timetoken) \
            ###+" --every "+ str(self.every) \
            ###+" --times "+ str(self.times) \
            ###+" --testdebug "+ str(self.testdebug) \
            ###+ a +" &"
        ###print("Layer -1 "+command)

	
	
	#Oracle:
	#self.failUnless(os.stat(self.testpath+"antragxy").st_size>91)
	#test_fdf_patch_a_pdf_corsett_ok
	self.failUnless(os.stat(self.testpath+"filled.pdf").st_size>1)
	#self.failUnless(os.stat(self.testpath+"greppedWeber.log").st_size>1)
	
	#self.failUnless(os.stat(self.testpath+"logs").st_size>91)
	return        

    def test_sedformpdf(self):
	#invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	
	pass
        filelist=[\
	    #"doctemp001-p002.tiff",\
	    #"doctemp001-p002.tiff",\
	    "foo.pdf"]
        command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ##'''
        ##urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ##wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ##let n=0
        ##let abase=1000
        ##let bbase=1000
        ##let incrementor=5 #lines
        ##mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ##find a/ -name "**" -type d|tee 1
        ##for i in `cat 1`; 
            ##do let n+=1; 
            ##let abase=bbase
            ##let bbase=abase+incrementor
            ##s=`cat 2|sed -n "$abase,$bbase"p`
            
            ##echo "$s">$i.txt; 
            ##echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ##done

        ##'''
        #u="pwd"
        #print(u)
        
        
        
        a=""
        if self.regession!="":
            a=" --userconfigpath "+ str(self.regession)
            
        #print(command)
	#os.system(command)
	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   
        command= "bash "+self.testsscripts+"beantrager/driver_fdf_in_out_pdf_in_out_foopl.sh  " +" --tmpdir "+ self.testpath \
            + a +" #&"
        print(command)
	os.system(command)
	
        ###command= "bash "+self.testsscripts+"/buildingdamon/Buildingloggerdemon.sh  " +" --tmpdir "+ self.testpath \
            ###+" --samplerate "+ str(self.samplerate) \
            ###+" --timetoken "+ str(self.timetoken) \
            ###+" --every "+ str(self.every) \
            ###+" --times "+ str(self.times) \
            ###+" --testdebug "+ str(self.testdebug) \
            ###+ a +" &"
        ###print("Layer -1 "+command)

	
	
	#Oracle:
	#self.failUnless(os.stat(self.testpath+"antragxy").st_size>91)
	#test_fdf_patch_a_pdf_corsett_ok
	self.failUnless(os.stat(self.testpath+"filled.pdf").st_size>1)
	self.failUnless(os.stat(self.testpath+"greppedWeber.log").st_size>1)
	
	#self.failUnless(os.stat(self.testpath+"logs").st_size>91)
	return        

    #def Test_release_all2releaselogs(self):
	##invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	#pass
        #filelist=[\
	    ##"doctemp001-p002.tiff",\
	    ##"doctemp001-p002.tiff",\
	    #"doctemp004-p003.tiff"]
        #command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ###'''
        ###urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ###wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ###let n=0
        ###let abase=1000
        ###let bbase=1000
        ###let incrementor=5 #lines
        ###mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ###find a/ -name "**" -type d|tee 1
        ###for i in `cat 1`; 
            ###do let n+=1; 
            ###let abase=bbase
            ###let bbase=abase+incrementor
            ###s=`cat 2|sed -n "$abase,$bbase"p`
            
            ###echo "$s">$i.txt; 
            ###echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ###done

        ###'''
        ##u="pwd"
        ##print(u)
        #print(command)
	#os.system(command)
	#import shutil
	#for f in filelist:
	    #dst=self.testpath+f #
	    #src=self.testpathressources+f
	    ##print dst,src
	    #shutil.copyfile(src,dst)   
        #command= "bash "+self.testsscripts+"yournextgnuclihelloprojectdemo.sh  " +" --tmpdir "+ self.testpath 
        #print(command)
	#os.system(command)
	
	##Oracle:
	#self.failUnless(os.stat(self.testpath+"logs").st_size>91)
	#return

    def test_t20jaflatstray(self):
	#invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	pass
        filelist=[\
	    #"doctemp001-p002.tiff",\
	    #"doctemp001-p002.tiff",\
	    "doctemp004-p003.tiff"]
        command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ##'''
        ##urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ##wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ##let n=0
        ##let abase=1000
        ##let bbase=1000
        ##let incrementor=5 #lines
        ##mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ##find a/ -name "**" -type d|tee 1
        ##for i in `cat 1`; 
            ##do let n+=1; 
            ##let abase=bbase
            ##let bbase=abase+incrementor
            ##s=`cat 2|sed -n "$abase,$bbase"p`
            
            ##echo "$s">$i.txt; 
            ##echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ##done

        ##'''
        #u="pwd"
        #print(u)
        print(command)
	os.system(command)
	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   
        command= "bash "+self.testsscripts+"losed/t20ja-flat-stray.sh " +" --tmpdir "+ self.testpath 
        print(command)
	os.system(command)
	
	#Oracle:
	self.failUnless(os.stat(self.testpath+"logs").st_size>9)
	return
    
    def test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example(self):
	#invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	pass
        filelist=[\
	    #"doctemp001-p002.tiff",\
	    #"doctemp001-p002.tiff",\
	    "doctemp004-p003.tiff"]
        command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ##'''
        ##urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ##wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ##let n=0
        ##let abase=1000
        ##let bbase=1000
        ##let incrementor=5 #lines
        ##mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ##find a/ -name "**" -type d|tee 1
        ##for i in `cat 1`; 
            ##do let n+=1; 
            ##let abase=bbase
            ##let bbase=abase+incrementor
            ##s=`cat 2|sed -n "$abase,$bbase"p`
            
            ##echo "$s">$i.txt; 
            ##echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ##done

        ##'''
        #u="pwd"
        #print(u)
        print(command)
	os.system(command)
	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   
        command= "bash "+self.testsscripts+"yournextgnuclihelloprojectdemo.sh  " +" --tmpdir "+ self.testpath 
        print(command)
	os.system(command)
	
	#Oracle:
	self.failUnless(os.stat(self.testpath+"logs").st_size>91)
	return

    def test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example(self):
	#invole: (cd $Qemuburo_install_dir"qemuburo/"; python -m unittest Testqemuburo.qemuburoTestCase.test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example)
	pass
        filelist=[\
	    #"doctemp001-p002.tiff",\
	    #"doctemp001-p002.tiff",\
	    "doctemp004-p003.tiff"]
        command= "cp -r " + self.testpathressources + "Buildingdemon "+ self.testpath 
                ##'''
        ##urldq=http://www.gutenberg.org/cache/epub/2000/pg2000.txt
        ##wget -cq -O- $urldq|tee 2|grep -C5 -a  Capit

        ##let n=0
        ##let abase=1000
        ##let bbase=1000
        ##let incrementor=5 #lines
        ##mkdir -p {a,b}/{e,f,g}/{h,i,j}
        ##find a/ -name "**" -type d|tee 1
        ##for i in `cat 1`; 
            ##do let n+=1; 
            ##let abase=bbase
            ##let bbase=abase+incrementor
            ##s=`cat 2|sed -n "$abase,$bbase"p`
            
            ##echo "$s">$i.txt; 
            ##echo "sinabase      "$s"  "$i" "$n" "$abase; 
        ##done

        ##'''
        #u="pwd"
        #print(u)
        print(command)
	os.system(command)
	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   
        command= "bash "+self.testsscripts+"yournextgnuclihelloprojectdemo.sh  " +" --tmpdir "+ self.testpath 
        print(command)
	os.system(command)
	
	#Oracle:
	self.failUnless(os.stat(self.testpath+"logs").st_size>91)
	return
