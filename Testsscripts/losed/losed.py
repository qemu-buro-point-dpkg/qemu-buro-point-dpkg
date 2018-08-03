#!/usr/bin/python3
searchSearchString = "^."#first 4 char in line

searchReplaceString = "foobar\n\r"
searchReplaceString = "\1"
collapseflag="left" # for doc insert
replaceAllflag="off"

incedent=5
insert="\njj\n" #string to be inserted for or appended to selection
appendflag=1


### spawn the  multiline selection to a uno-regex2
incedent2=2
searchSearchString2=""

#the inserted TOC needs to be updated
TOCupdateflag=0

#howto lookup values: 1 macrorecorder, 2. python console readline completion >>> oCursor.ParaA 3. idl file grep
#("CharWeight: SEMIBOLD = 110.000000-150", "CharPosture: ?"
setPropertyValue1a="CharColor"
setPropertyValue1a=""
setPropertyValue1b=255 #blue, red?

#setPropertyValue1a="CharWeight"
#setPropertyValue1b=110 


setPropertyValue2a="NumberingStyleName"
setPropertyValue2a=""
setPropertyValue2b="Outline"
 #second "index marks" Numbering continuing: "outline" else: Numbering 1

setPropertyValue3a="CharHeight"
setPropertyValue3a=""
setPropertyValue3b=12

#setPropertyValue4a="CharUnderline"
#setPropertyValue4b=1

setPropertyValue4a="ParaAdjust"
setPropertyValue4a=""
setPropertyValue4b=0

#LEFT    = 0RIGHT   = 1BLOCK   = 2CENTER  = 3TRETCH = 0

ParaStyleName="Heading 1"
ParaStyleName=""


STYLESFILE="/tmp/qemuburotest/Buildingdemon/b/g/test2.doc" # defunct?
STYLESFILE=""
#style families 5
#CharacterStyles NumberingStyles  ParagraphStyles  #FrameStyles PageStyles


ChapterFILE="/tmp/qemuburotest/Buildingdemon/b/g/test2.doc"#input#./Buildingdemon/b/g/test2.doc
ChapterFILE=""
logfile="/tmp/qemuburotest/logs"#o
logsline="hello_libreoffice-python"

absoluteUrlstr="/tmp/qemuburotest/Buildingdemon/b/e/i/"
#we got a seven files, in test: one out of another
#loadComponentFromabsoluteURL="/tmp/qemuburotest/Buildingdemon/b/e/i/test1.doc" # 

filetype1a='writer_pdf_Export'
filetype1b="test1.pdf"

filetype2a='Text'
filetype2b="test1.txt"

filetype3a='MS Word 97' #bug
filetype3b="test2.doc"

filetype4a='writer8'
filetype4b="test2.odt"

#https://github.com/LibreOffice/core/blob/3168c5e09f084e65a32b5865d975ea9a9524d7c3/desktop/source/lib/init.cxx
 #{ "doc",   "MS Word 97" },
    #{ "docm",  "MS Word 2007 XML VBA" },
    #{ "docx",  "MS Word 2007 XML" },
    #{ "fodt",  "OpenDocument Text Flat XML" },
    #{ "html",  "HTML (StarWriter)" },
    #{ "odt",   "writer8" },
    #{ "ott",   "writer8_template" },
    #{ "pdf",   "writer_pdf_Export" },
    #{ "rtf",   "Rich Text Format" },
    #{ "txt",   "Text" },
    #{ "xhtml", "XHTML Writer File" },
    #{ "png",   "writer_png_Export" },


import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-c', '--config_file')
parser.add_argument('-l', '--loadComponentFromabsoluteURL')
parser.add_argument('-i', '--incedent')
parser.add_argument('-o', '--tmpdir')
parser.add_argument('-p', '--insert')
parser.add_argument('-s', '--searchSearchString')
parser.add_argument('-t', '--absoluteUrltxt')
parser.add_argument('-f', '--filetype4b')
parser.add_argument('-1a', '--setPropertyValue1a')
parser.add_argument('-1b', '--setPropertyValue1b')

setPropertyValue1a
args = parser.parse_args()
if args.config_file!=None:
    pass
    config_file=args.config_file
    #print(config_file)
    with open(config_file) as f:
        code = compile(f.read(), config_file, 'exec')
        exec(code, globals(), locals())
        ##https://stackoverflow.com/a/37611448 ". conf.sh"

if args.loadComponentFromabsoluteURL!=None:
    loadComponentFromabsoluteURL=args.loadComponentFromabsoluteURL
    pass


if args.incedent!=None:
    incedent=args.incedent
if args.tmpdir!=None:
    absoluteUrlstr=args.tmpdir
if args.insert!=None:
    insert=str(args.insert) #+'\npp\n'
    insert=insert.replace("\\n", "\n")
    insert=insert.replace("|", " ")
    #print("insertffffffff"+repr(insert))
if args.searchSearchString!=None:
    searchSearchString=args.searchSearchString
if args.filetype4b!=None:
    filetype4b=args.filetype4b
if args.setPropertyValue1b!=None:
    setPropertyValue1b=args.setPropertyValue1b
    if (setPropertyValue1b[:3]=="_i_"):
        setPropertyValue1b=int(setPropertyValue1b.replace('_i_',''))
#if args.setPropertyValue1a!=None:
    setPropertyValue1a=args.setPropertyValue1a



#print(replaceAllflag)





#import /home/kubuntu/Downloads/format_config

import uno
import os
from com.sun.star.beans import PropertyValue
import subprocess
import time

##a launch server hack

a=""
try:
    a=subprocess.check_output('ps ax | grep soffice | grep -v "grep\|defunct" ',shell=True)
except:
    pass

print(str(a)+"asubprocess.check")
if (a==""):
    try:
        os.system('killall soffice.bin;')
    except:
        pass
    print("start soffice --accept")
    ##a=subprocess.check_output('soffice "--accept=socket,host=localhost,port=8100;urp;" --headless --invisible &',shell=False)
    os.system('soffice "--accept=socket,host=localhost,port=8100;urp;" --headless --invisible &')
#prove (if), killstart, while wait?
while (str(a)==""):    
    try:
        a=subprocess.check_output('netstat -nap | grep office ',shell=True)
    except:
        pass
    print(str(a)+"innen_subprocess.check")
    time.sleep(0.01)

#time.sleep(4.01)

def overwriteStyles(document, fromFile):
    """First arg is the document itself, the second is a string with path to style file in UNO API format"""
    styles = document.StyleFamilies
    styles.loadStylesFromURL(fromFile, styles.StyleLoaderOptions)

def updateTOC(document):
    """Update links in table of contents"""
    iList = document.getDocumentIndexes()
    assert(iList.getCount() > 0), "Table of contents not found, aborting!"
    for i in range(0, iList.getCount()):
        iList.getByIndex(i).update()

def setFirstPage(file):
    """Sets the first page style to «First Page»"""
    enumeration = file.Text.createEnumeration()
    enumeration.nextElement().PageDescName = 'First Page'



localContext = uno.getComponentContext()
resolver = localContext.ServiceManager.createInstanceWithContext(
                "com.sun.star.bridge.UnoUrlResolver", localContext )

smgr = resolver.resolve( "uno:socket,host=localhost,port=8100;urp;StarOffice.ServiceManager" )
remoteContext = smgr.getPropertyValue( "DefaultContext" )
desktop = smgr.createInstanceWithContext( "com.sun.star.frame.Desktop",remoteContext)

a="file:///"+ loadComponentFromabsoluteURL
file = desktop.loadComponentFromURL(a ,"_blank", 0, ())

#load a styte from another .doc file

if STYLESFILE!="":overwriteStyles(file, "file:///"+ STYLESFILE)


### uno-regex1, replaceAll first tier

search = file.createReplaceDescriptor()
search.SearchRegularExpression = True
search.SearchString = searchSearchString
search.ReplaceString = searchReplaceString
selsFound = file.findAll(search)
if replaceAllflag!="off":
    selsreplace =file.replaceAll(search)

#insert/ ChapterFILE/string before/after regex 1/regex1-2
oSel =selsFound.getByIndex(int(incedent))
oCursor = oSel.getText().createTextCursorByRange(oSel)


### spawn the  multiline selection to a uno-regex2
if searchSearchString2!="":
    search2 = file.createReplaceDescriptor()
    search2.SearchRegularExpression = True
    search2.SearchString = searchSearchString2
    search.ReplaceString = searchReplaceString
    selsFound2 = file.findAll(search2)
    oSel2=selsFound2.getByIndex(incedent2)
    oCursor.gotoRange(oSel2,True)

#inserted for or appended to selection
appendstr=''
if appendflag==1:
    appendstr=oCursor.getString()
oCursor.setString(insert+appendstr)
#oCursor.collapseToStart() #??
print( setPropertyValue1a, setPropertyValue1b )
if setPropertyValue1a!="":oCursor.setPropertyValue(setPropertyValue1a,setPropertyValue1b) 

if setPropertyValue2a!="":oCursor.setPropertyValue(setPropertyValue2a,setPropertyValue2b)

if setPropertyValue3a!="":oCursor.setPropertyValue(setPropertyValue3a,setPropertyValue3b)

if setPropertyValue4a!="":oCursor.setPropertyValue(setPropertyValue4a,setPropertyValue4b)

if ParaStyleName!="":oCursor.ParaStyleName=ParaStyleName #toc things

# doc insert
if collapseflag=="left":
    oCursor.collapseToStart()
else:
    oCursor.collapseToEnd()

if ChapterFILE!="":
    oCursor.insertDocumentFromURL("file:///"+ ChapterFILE, ())

#tbi
#a=file.getScriptProvider()
#cmd = "Main?language=Basic&location=My Macros&module=Module1&methode=Standard"
#a.getScript("vnd.sun.star.script:"+cmd)##file.Text.getString()
#main__.ScriptFrameworkErrorException: The following Basic script could not be found:
#library: 'Main'
#module: ''
#method: ''
#location: 'My Macros'
#a.invoke()
#Traceback (most recent call last):
#  File "<stdin>", line 1, in <module>
#AttributeError: invoke

#paragraphing recently not implemented
#enumeration = file.Text.createEnumeration()
#par = enumeration.nextElement()

#TOC, tbi create, delete
if TOCupdateflag==1:
    updateTOC(file) 


sections = file.Links.Sections
for name in sections:
    sections[name].dispose()


#multiformated output, append/case

sections = file.Links.Sections
for name in sections:
    sections[name].dispose()

#args = (PropertyValue('FilterName',0,'writer_pdf_Export',0),)
#argsurl="file://"+ absoluteUrlstr+"test2.doc"
#file.storeToURL(argsurl,argstxt)

#file.storeToURL("file://"+ absoluteUrlpdf,args)

#argstxt = (PropertyValue('FilterName',0,'Text',0),)
#argsurl="file://"+ absoluteUrlstr+"test2.doc"
#file.storeToURL(argsurl,argstxt)

#file.storeToURL("file://"+ absoluteUrltxt,argstxt)

argstxt = (PropertyValue('FilterName',0,filetype1a,0),)
argsurl="file://"+ absoluteUrlstr+filetype1b
file.storeToURL(argsurl,argstxt)


argstxt = (PropertyValue('FilterName',0,filetype2a,0),)
argsurl="file://"+ absoluteUrlstr+filetype2b
file.storeToURL(argsurl,argstxt)


argstxt = (PropertyValue('FilterName',0,filetype3a,0),)
argsurl="file://"+ absoluteUrlstr+filetype3b
#file.storeToURL(argsurl,argstxt)
#bug

args = (PropertyValue('FilterName',0,filetype4a,0),)
argsurl="file://"+ absoluteUrlstr+filetype4b
print(argsurl)

file.storeToURL(argsurl,args)


file.dispose() #does what?

logshandle=open(logfile, 'a') #'a' opens the file for appending
logshandle.write(logsline)#'a' opens the file for appendingf.write(line)
logshandle.close() #'a' opens the file for appendingf.close()   
