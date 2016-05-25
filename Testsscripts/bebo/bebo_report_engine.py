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
