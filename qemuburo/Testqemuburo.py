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
if str(sys.path).rfind(os.environ["Qemuburo_install_dir"]+"qemuburo")<1:
    sys.path.append(os.environ["Qemuburo_install_dir"]+"qemuburo")

import unittest
#reload
#del sys.modules["qemuburo"]
#import qemuburo
import logging

class qemuburoTestCase(unittest.TestCase):
    def setUp(self):
	#print "prepare some stuff in order to run the test"
	import glob
	self.testpath = '/tmp/qemuburotest/' #Space for tests execution
	self.testsscripts = os.environ["Qemuburo_install_dir"]+"/Testsscripts/"
	#code to be tested
	self.debugflag=100000
	

	if not os.path.exists(self.testpath):
	    
	    try:
		os.makedirs(self.testpath)
	    except:
		pass
	
	
	#clean for new test
	filelist = glob.glob(self.testpath+"*")
	for f in filelist:
	    try:os.remove(f)
	    except:pass
	    #try:shutil.rmtree(f)
	    #except:pass
	
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
	
	#msec	  
	#logging.Formatter(fmt='%(asctime)s.%(msecs)03d',datefmt='%Y-%m-%d,%H:%M:%S') 
	#from http://stackoverflow.com/questions/6290739/python-logging-use-milliseconds-in-time-format
	#for one file


    def test_template(self):
	filelist=[\
	    "pic_2_report_piece1_valid_direct_complete.png",\
	    "pic_1_report_piece1_valid_direct_complete.png",\
	    "tmp_graph_1.eps"]



	import shutil
	for f in filelist:
	    dst=self.testpath+f #
	    src=self.testpathressources+f
	    #print dst,src
	    shutil.copyfile(src,dst)   

	#reportpp.template(self.report_table_tex, self.texpics, self.reportdir, debug=1001)
	#Oracle:
	#16804 Mär  9 18:29 tmp_graph_1.eps
	self.failUnless(os.stat(self.testpath+"tmp_graph_1.eps").st_size==16804)

    def test_is_flatbad_one_page_orc_scanning_to_pdf_scanndistribute150825(self):
	'''
	Ran 1 test in 25.923s OK one page through all stages
	#non_multistaple,nonduplex,non_adf, (adf)
	to be done: -second_stage,multistaple,nonduplex
	-adf tests_all_stages
	-hide all the output on screen to log
	-distrubutioncode, stage 3 too
	-scanimage capaple user?, everything installed?
	'''
	
	#command= "bash "+self.testsscripts+"dummybashscript.sh  " +" 2 4 "+ self.testpath + " 1 1"
	#print command 
	#os.system(command)
	command= "bash "+self.testsscripts+"scanndistribute150825.sh  " +" 1 1 "+ self.testpath + " 1 nonadf"
	os.system(command)
	#print command
	#knows probs:
	#okular: cannot connect to X server :0 # use first ubuntu user #k
	#I/O Error: Permission denied.#k ?__?: use first ubuntu user for execution #k
	#scanimage: no SANE devices found, was installed?
	# am I  scanimage capaple user?
	#scanimage: sane_start: Document feeder out of documents
	#  how do I check if feeder is filled?__?
	#bash: /opt/OCRmyPDF-2.2-stable/OCRmyPDF.sh: not found? k
	# ?__? Annoying me that scanner is not mute, beepsk at displayk
	#

	#import shutil
	#for f in filelist:
	    #dst=self.testpath+f #
	    #src=self.testpathressources+f
	    ##print dst,src
	    #shutil.copyfile(src,dst)   


	#Oracle:
	self.failUnless(os.stat(self.testpath+"doctempbundlesandw1.pdf").st_size>16804)
	#as we do not know, if on the paper original is any text, we are happy that there is a pdf with the name and some contents in.
    
    
    def test_pre_and_post_instalaion_tests_from_qemu_generation_to_ready_use_image(self):
	pass
	return
    

    def tearDown(self):
	pass
	return
    # free the stuff you did in setUp
    
    def test_prepares_preeseeded_install(self):
	pass
	return
	#preeseeded_install(self.latexpdf)
	#Oracle:	self.failUnless(os.stat(self.testpath+"Readmeqemuburu.txt").st_size==60723)

 
