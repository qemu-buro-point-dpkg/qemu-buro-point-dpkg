#!/usr/bin/python3
searchSearchString = "^...."#first 4 char in line

searchReplaceString = "foobar\n\r"
searchReplaceString = "\1"
collapseflag="left" # for doc insert
replaceAllflag="of12f"

incedent=5
insert="\njj\n" #string to be inserted for or appended to selection
appendflag=1


### spawn the  multiline selection to a uno-regex2
incedent2=2
searchSearchString2="la"

#the inserted TOC needs to be updated
TOCupdateflag=1

#howto lookup values: 1 macrorecorder, 2. python console readline completion >>> oCursor.ParaA 3. idl file grep

setPropertyValue1a="CharColor"
setPropertyValue1b=255

setPropertyValue2a="NumberingStyleName"
setPropertyValue2b="Outline"
 #second "index marks" Numbering continuing: "outline" else: Numbering 1

setPropertyValue3a="CharHeight"
setPropertyValue3b=8

#setPropertyValue4a="CharUnderline"
#setPropertyValue4b=1

setPropertyValue4a="ParaAdjust"
setPropertyValue4b=2

#LEFT    = 0RIGHT   = 1BLOCK   = 2CENTER  = 3TRETCH = 0

ParaStyleName="Heading 1"


STYLESFILE="/tmp/qemuburotest/Buildingdemon/b/g/test2.doc" # defunct?
#style families 5
#CharacterStyles NumberingStyles  ParagraphStyles  #FrameStyles PageStyles


ChapterFILE="/tmp/qemuburotest/Buildingdemon/b/g/test2.doc"#input#./Buildingdemon/b/g/test2.doc
logfile="/tmp/qemuburotest/logs"#o
logsline="hello_libreoffice-python"

absoluteUrlstr="/tmp/qemuburotest/Buildingdemon/b/e/i/"
#we got a seven files, in test: one out of another
absoluteUrltxt="/tmp/qemuburotest/Buildingdemon/b/e/i/test1.txt"
absoluteUrlpdf="/tmp/qemuburotest/Buildingdemon/b/e/i/test1.pdf"
loadComponentFromabsoluteURL="/tmp/qemuburotest/Buildingdemon/b/e/i/test1.doc" # 

filetype1a='writer_pdf_Export'
filetype2b=""

filetype2a='Text'
filetype2b=""

filetype3a='MS Word 97'
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

