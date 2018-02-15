# source /home/githubqemuburo/github_qemuburo/Testresources/novhandler/Buildingloggerdemon.userconfig_novsedcamel.sh
# #source /tmp/qemuburotest/a.sh; 


#db read at start, a policy
confroots="$Qemuburo_install_dir ""/tmp/qemuburotest/ ""$HOME/ ""$private_of_qemu ";
ramsh1=""
for confroot1 in $confroots; 
do 
ramsh="$confroot1"".ttconfig/tmpini.sh"; 
#echo "Rem"rampsh:$ramsh;
[ -f "$ramsh" ] && ramsh1=$ramsh; 
done;
. "$ramsh1";
#db read at start, a policy

outpath="/tmp/qemuburotest/"
logs="logs"
#echo "Layer0 Hallo config file> Buildingloggerdemon.userconfig_for_camel.sh register mydemogreeter () 
#ok one thought: this is point, where the a user's galleries shops could registerer their event functions 
#comment
echo -e \
"Programmname ""$(basename $0)" \
"#### FUNCNAME ""#""${FUNCNAME[*]}" \
>>"$tmpdir""logs"



#loading all registered handlers at prerelaunch routine, too, wont you?

fpttcookielock="$confroot""$confstring0""$confstring1"".ttcookie.lock"
fpfoundhandler_to_load="$confroot""$confstring0""$confstring1"".ttcookie."
self_unwished_pattern="$ttcookie_handler_to_register_name" #"\|sopho"
#echo -e \
# "\n confstring0? ""$confstring0" \
# "\n fpttcookielock? ""$fpttcookielock" \
# "\n fpfoundhandler_to_load? ""$fpfoundhandler_to_load" \
# "\n self_unwished_pattern? ""$self_unwished_pattern" #>>"$tmpdir""logs"



if [ -f "$fpttcookielock" ]; 
then
echo "hellocamellocked" >>$outpath$logs #>/dev/null
else
    echo "hellocamelunlocked" >>$outpath$logs #>/dev/null
    touch $fpttcookielock
    for i in $(ls $fpfoundhandler_to_load*|grep -v "$self_unwished_pattern"); 
    do
    i1=$(cat $i)
    echo -e "Layer 5 init handler: register handlers from i--i1""$i"--"$i1""\n load all handlers but mine from HOME ###" >>$outpath$logs
    #chmod +x "$i1" 2>/dev/null
    echo -e "test -f $i1 && source $i1; " >>$outpath$logs
    test -f "$i1" && source "$i1"; 
    done;
    rm $fpttcookielock
fi



mydemogreeter () {
#db read at start, a policy
# # confroots="$Qemuburo_install_dir ""/tmp/qemuburotest/ ""$HOME/ ""$private_of_qemu ";
# # ramsh1=""
# # for confroot1 in $confroots; 
# # do 
# # ramsh="$confroot1"".ttconfig/tmpini.sh"; 
# # #echo $ramsh; 
# # [ -f "$ramsh" ] && ramsh1=$ramsh; 
# # done;
# # . "$ramsh1";
#db read at start, a policy
# defunct? bug?

echo -e \
"Programmname ""$(basename $0)" \
"#### FUNCNAME ""#""${FUNCNAME[*]}" \
>>"$tmpdir""logs"

#call 
echo "Layer6 mydemogreeter () {default handler init### "# >>$outpath$logs
nice -9 echo "hello">$tmpdir/hl
nic="nice -19"
#"$nic"" ""$Qemuburo_install_dir""Testsscripts/losed/mainhandler.sh"; 
a=19
nice -19 bash "$Qemuburo_install_dir""Testsscripts/losed/mainhandler.sh";
return 0; }



