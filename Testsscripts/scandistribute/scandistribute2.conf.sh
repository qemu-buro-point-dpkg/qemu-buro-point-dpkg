# #Part III
# #distribute
# 
# #uff wie got some Problems big black bars below, this: 
# #pdfcrop --margins '0 0 0 -189' --clip doctempbundlesandw1.pdf  doctempoutput.pdf
# #mv doctempoutput.pdf doctempbundlesandw1.pdf
# 
# #extract 1 leave copy
# 
# #extracts1

#...
#extracts1
a="Bescheide/Verwaltungsakte/Vereinbarung/DialektikderAufklaerung/Undinger/bedingungslosesgrundeinkommenfueralleMenschenaufderweltjetzt/oderderboeseonkelkantkommtauchnoch/oderderliebeonkelsade/"

mkdir -p $a
#Pstore=$PPool"/allpathes/thatyoucan/imagine"
Pstore=$PPool"Bescheide/Verwaltungsakte/Vereinbarung/DialektikderAufklaerung/Undinger/bedingungslosesgrundeinkommenfueralleMenschenaufderweltjetzt/oderderboeseonkelkantkommtauchnoch/oderderliebeonkelsade/"

Nstore=$DATE"Gliedi.pdf"
Nstore="Gliedi.pdf"

let Nstart=5
let Nend=6

pdftk A=doctempbundlesandw1.pdf cat A$Nstart-$Nend output $Pstore$Nstore
pdfinfo $Pstore$Nstore |grep Pages >> log.txt 2>&1
pdftotext $Pstore$Nstore - |head -125|tail >> log.txt 2>&1
ls -l $Pstore$Nstore >> log.txt 2>&1
#k
#extracts1 end

#extracts2
Pstore=$PPool

Nstore=$DATE"Gliedi.pdf"