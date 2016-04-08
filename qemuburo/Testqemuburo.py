# -*- coding: utf-8 -*-
# unittest 
# Author: 
# 
# License: GPL 
# Version: 04/13/2015


#usage: 
#2)python Testqemuburo.py
#3)python -m unittest Testqemuburo.qemuburoTestCase.test_pre_and_post_instalaion_tests_from_qemu_generation_to_ready_use_image
#.
#----------------------------------------------------------------------
#Ran 1 test in 0.063s

#OK

import sys
import os
import shutil
#print "update loaded modules"
#sys.path.append("/home/kubuntu/freecad/lib/")
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
	self.testpath = '/tmp/qemuburotest'
	self.debugflag=100000
	

	if not os.path.exists(self.testpath):
	    try:os.makedirs(self.testpath)
	    except:pass
	

	#clean for new test
	filelist = glob.glob(self.testpath+"*")
	for f in filelist:
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

    
    
    def test_pre_and_post_instalaion_tests_from_qemu_generation_to_ready_use_image(self):
	pass
	return
    

    def tearDown(self):
	pass
    # free the stuff you did in setUp
    

#1
    def test_prepares_preeseeded_install(self):

	#preeseeded_install(self.latexpdf)
	#Oracle:
	self.failUnless(os.stat(self.testpath+"Readmeqemuburu.txt").st_size==60723)

 
