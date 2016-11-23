import subprocess
import os
import sys
import subprocess
#import tempfile
import re



def prepares_filelist_valid_cummulative_tex(report_table_tex, texpics, reportdir, debug=1001):
    '''
    to cumulative tex 
    '''
    s=""
    s=s+"\documentclass[12]{article}\n"
    s=s+"\usepackage{graphicx}\n"
    s=s+"\usepackage{caption}\n"
    s=s+r"\begin{document}"+"\n"
    s=s+r"\tableofcontents"+"\n"
    # %\chapter{First chapterrr}
    s=s+r" \section{"+report_table_tex[0][0][0]+"}"+"\n"
    i=0
    for i1 in range(len (report_table_tex)):
	s=s+r"\subsection{"+report_table_tex[i1][1][0]+"}"+"\n"
	s=s+r"\paragraph{"+report_table_tex[i1][2][0]+r"\\}"+"\n"
	#s=s+r" \\   \\ "+"\n"
	s=s+r"\begin{center}"+"\n"
	s=s+r"  \begin{tabular}{ | p{7cm} | p{7cm} |}"+"\n"
	s=s+r"     \hline"+"\n"
	s=s+r"    \multicolumn{2}{|c|}{resuls-options} \\ \hline"+"\n"
	for i2 in range(4,len (report_table_tex[i1])):
	    s=s+str(report_table_tex[i1][i2 ][1])+"& "+str(report_table_tex[i1][i2 ][0]) +"\n"
	    s=s+r"\\ \hline"+"\n"   
	
	s=s+r"    \end{tabular}"+"\n"
	s=s+r"  \end{center}"+"\n";
	#
	s=s+r"\begin{center}"+"\n"
	#s=s+r"\begin{figure}[hp]"+"\n"
	#s=s+r"\centering"+"\n"
	#s=s+r"\includegraphics[width=0.4\textwidth]{pic_"+str(i1+1)+"_report_piece1_valid_direct_complete.png}"+"\n"
	s=s+r"\includegraphics[width=0.4\textwidth]{"+texpics[i1]+"}\n"
	s=s+r"\captionof{figure}{fem warmth flow}"+"\n"
	#s=s+r"\caption{Awesome Image}"+"\n"
	#s=s+r"\label{fig:awesome_image}"+"\n"
	#s=s+r"\end{figure}"+"\n"
	s=s+r"  \end{center}"+"\n";

    s=s+r"\end{document}"+"\n"

    i=0    
    cumulativetex_file=reportdir+"cumulative"+str(i+1)+".tex"
    fh=open(cumulativetex_file,"w")
    fh.write(s);fh.close()
    
    return cumulativetex_file

def prepares_pdf_cummulativ_tex_and_latexpdf(latexpdf, cumulativetex_file, reportdir, debug=1000):
    ##!execute pdflatex
    logs2=reportdir+"logslatexpdf" #Error messages
    latexpdfoutlog=" >>"+logs2 +" 2>&1 "

    command= latexpdf +" -file-line-error -halt-on-error "+cumulativetex_file +latexpdfoutlog
    os.chdir(reportdir)
    #print "command:"+command
    output = subprocess.check_output([command, '-1'], shell=True, stderr=subprocess.STDOUT,)
    #FreeCAD.Console.PrintMessage(output)  
    
    if int(str(debug)[len(str(debug))-1])==1:
	command= "xpdf cumulative1.pdf 2&"
	os.system(command)
    pass
def twgc_plain_gnu_to_guest_AzAeA(cumulative_twgc_ware, reportdir, debug=1000, output_file="guest_AzAeA"):
    '''
    (cumulative_twgc_ware, reportdir, debug=1000)
    #sif manipulationa
    extract hard coded keywords from garbage flow and extracts them to a formatted file
   
    '''
    if output_file=="guest_AzAeA":
	output_file=reportdir+output_file
    siffile=cumulative_twgc_ware
    siffile="/home/githubqemuburo/github_qemuburo/Testresources/twgc_plain_gnu_jobboerse.arbeitsagentur.de_Elekroingenieur_Berlin_10_takes_rambo_style_5_2016"
    #print "the voult " +siffile
    import re
    #get text of file in one variable: s
    fh=open(siffile)
    s=fh.read();fh.close()
    #print str("len(s)") + str(len(s))
    
    pattern="\n##.*?\n##"
#    pattern="i.*?e"
    it=re.findall(pattern,s,re.MULTILINE+re.DOTALL)
    #got occurences in s:
    #['\nMate...End', '\nMate...End'..]
    a=[ite.span() for ite in re.finditer(pattern,s,re.MULTILINE+re.DOTALL)]
    #[(3089, 3166), (3167,..]    
    #print "it"+it
    a1=sum([list(i) for i in a],[])
    i1=0
    i2=0
    AzAeAL=[]

    for j in a1:
	i1=i2
	i2=j 
	AzAeA=[]

	#print "i1 i2 " + str (i1) + "  " +str(i2)
	#[4471, 10162, 14924,
	#print "a1" + str(a1)
	match = re.search(r'([a-zA-Z0-9_]*@.*?\.(de|com))',s[i1:i2])
	#match = re.search(r'(.*@.*)(Externer Link)',s[a1[2]:a1[3]])
	if match!=None:
	    #print match.group(1)
	    token=match.group(1)
	else:
	    #print "no Email found"
	    token="no Email found"
	AzAeA.append([token,"email_receiver"])

	match = re.search(r'\n((Frau|Herr) .*\n)', s[i1:i2])
	if match!=None:
	    #print match.group(1)
	    token=match.group(1)
	else:
	    #print "Sehr geehrte Damen und Herren"
	    token="Sehr geehrte Damen und Herren"

	AzAeA.append([token,"name_receiver"])
	
	AzAeAL.append(AzAeA)
    fh=open(output_file,"w")
    fh.write(str(AzAeAL));fh.close()

    return AzAeAL
    pass

def multiple_AzAeA_lcgsp_ready_for_mailing(guest_AzAeA_file, reportdir,AzAeAL, profile_dir, asprm_file="", debug=1000):
    '''
    (guest_AzAeA, reportdir, debug=1000, asprm_file="")   
    create a series of pdf report file (loveletter) from given input flows 
    AzAeA inte
    '''
    #ast import
    guest_AzAeA=[]
    import ast
    fh=open(guest_AzAeA_file,"r")
    s=fh.read();fh.close()
    a=ast.literal_eval(s)
    guest_AzAeA.append(a)
    #print guest_AzAeA
    
    
    #
    asprmL=[]
    asprm=[]
    if asprm_file=="":
	asprm.append(["Hans Meier","name_sender"])
	asprm.append(["14.5.2016","date"])
	asprm.append(["Tel 0168 4564554","Header"])
	asprm.append(["Unternehmen Zukunft","Footer"])
	asprm.append(["path to foto",profile_dir+"passbild200bsw.jpg"])
	asprm.append(["path to certificate 1",profile_dir+"11Schulzeugnisr_ckseite.jpg"])
	asprm.append(["path to certificate 2",profile_dir+"12Schulzeugnis.jpg"])
	asprm.append(["path to certificate 3",profile_dir+"21Diplomzeugnis.jpg"])
	asprm.append(["path to certificate 4",profile_dir+"22DiplomzeugnisR_ckseite.jpg"])
	asprm.append(["path to logo",profile_dir+"22DiplomzeugnisR_ckseite.jpg"])
	asprm.append(["path to signature",profile_dir+"140707Unterschrift.svg"])
	# read texttemplate
	fh=open(profile_dir+"construction_stone_body.txt")
	s=fh.read();fh.close()
	#print str("len(s)") + str(len(s))
    
	pattern="\n##.*?\n##"
    #    pattern="i.*?e"
	it=re.findall(pattern,s,re.MULTILINE+re.DOTALL)
	#got occurences in s:
	#['\nMate...End', '\nMate...End'..]
	a=[ite.span() for ite in re.finditer(pattern,s,re.MULTILINE+re.DOTALL)]
	#[(3089, 3166), (3167,..]    
	#print "it"+it
	a1=sum([list(i) for i in a],[])
	#print "a1 "+ str(a1)
	#print "s1 "+ s[a1[1]:a1[2]]
	for i in range(len(a1)-1):
	    asprm.append(["text_construction_stone"+str(i),s[a1[i]:a1[i+1]]])
	
	#...
	asprmL.append(asprm)
	#print "range(len(a1) "+str(len(a1))+" len(asprm) "+str(len(asprm))
	#print "asprm 2 "+asprm[len(asprm)-len(a1)+2][1]

    import ast
    #export
    fh=open(profile_dir+"asprm","w")
    fh.write(str(asprmL));fh.close()

    #reimport 
    asprmL=[]
    fh=open(profile_dir+"asprm","r")
    s=fh.read();fh.close()
    a=ast.literal_eval(s)
    asprmL.append(a)
    #print asprmL

    #print asprmL
    #print asprmL[0]
    #print AzAeAL[0]
    AzAeA_to_loveletter_pdf(reportdir, AzAeAL[0], asprmL[0], profile_dir, debug=1000)
    loveletter=""
    return loveletter
    
def AzAeA_to_loveletter_pdf(reportdir,AzAeA, asprm, profile_dir, debug=1000, latexpdf="/usr/bin/pdflatex"):
    '''
    (reportdir,AzAeA, asprm, debug=1000)   
    creates pdf report file (loveletter) from given input flows:  AzAeA, asprm
    '''
    #Design loveletter official job application
    s=""
    s=s+"\documentclass[12]{article}\n"
    s=s+"\usepackage{graphicx}\n"
    s=s+"\usepackage{caption}\n"
    s=s+r"\begin{document}"+"\n"
    #s=s+r"\tableofcontents"+"\n"
    # %\chapter{First chapterrr}
    s=s+r" \section{"+AzAeA[0][0]+"}"+"\n"
    #i=0
    #for i1 in range(len (report_table_tex)):
	#s=s+r"\subsection{"+report_table_tex[i1][1][0]+"}"+"\n"
	#s=s+r"\paragraph{"+report_table_tex[i1][2][0]+r"\\}"+"\n"
	##s=s+r" \\   \\ "+"\n"
	#s=s+r"\begin{center}"+"\n"
	#s=s+r"  \begin{tabular}{ | p{7cm} | p{7cm} |}"+"\n"
	#s=s+r"     \hline"+"\n"
	#s=s+r"    \multicolumn{2}{|c|}{resuls-options} \\ \hline"+"\n"
	#for i2 in range(4,len (report_table_tex[i1])):
	    #s=s+str(report_table_tex[i1][i2 ][1])+"& "+str(report_table_tex[i1][i2 ][0]) +"\n"
	    #s=s+r"\\ \hline"+"\n"   
	
	#s=s+r"    \end{tabular}"+"\n"
	#s=s+r"  \end{center}"+"\n";
	##
	#s=s+r"\begin{center}"+"\n"
	##s=s+r"\begin{figure}[hp]"+"\n"
	##s=s+r"\centering"+"\n"
	##s=s+r"\includegraphics[width=0.4\textwidth]{pic_"+str(i1+1)+"_report_piece1_valid_direct_complete.png}"+"\n"
	#s=s+r"\includegraphics[width=0.4\textwidth]{"+texpics[i1]+"}\n"
	#s=s+r"\captionof{figure}{fem warmth flow}"+"\n"
	##s=s+r"\caption{Awesome Image}"+"\n"
	##s=s+r"\label{fig:awesome_image}"+"\n"
	##s=s+r"\end{figure}"+"\n"
	#s=s+r"  \end{center}"+"\n";

    s=s+r"\end{document}"+"\n"

    i=0    
    cumulativetex_file=reportdir+"cumulative"+str(i+1)+".tex"
    fh=open(cumulativetex_file,"w")
    fh.write(s);fh.close()
    
    #####
        ##!execute pdflatex
    logs2=reportdir+"logslatexpdf" #Error messages
    latexpdfoutlog=" >>"+logs2 +" 2>&1 "
    command= latexpdf +" -file-line-error -halt-on-error "+cumulativetex_file #+latexpdfoutlog
    #print command
    os.chdir(reportdir)
    #print "command:"+command
    output = subprocess.check_output([command, '-1'], shell=True, stderr=subprocess.STDOUT,)
    #FreeCAD.Console.PrintMessage(output)  
    
    if int(str(debug)[len(str(debug))-1])==1:
	command= "xpdf cumulative1.pdf 2&"
	os.system(command)
    pass
    #print "self.testbebo_profile" + os.environ["Qemuburo_bebo_profile"]+ profile_dir
    ######
    
    
    #Design loveletter official job application end
    #print "loveletter AzAeA_to_loveletter_pdf" +str(debug)
    loveletter="loveletter" +str(debug)
    return loveletter


