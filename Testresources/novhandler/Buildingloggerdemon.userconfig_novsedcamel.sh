#testscenario: this is meant to be as of a third party shop project. We would maybe not access the tmpini of partner projects that easy. We will to rely on a protocol of a hardcoding, right? Or from ps? cycling and searchig?


outpath="/tmp/qemuburotest/"
logs="logs"
echo "#########Layer (Kernel) 0 Hallo config Buildingloggerdemon.userconfig_novsedcamel.sh novsedcamelhandler init###" >>$outpath$logs

confroot="/tmp/qemuburotest/" #?
confstring0=".ttconfig/"
confstring1="ttcookies/"
ttcookie_handler_to_register_name=".ttcookie.sophokles"
ttcookie_handler_to_register="ttcookies/"

fpttcookielock="$confroot""$confstring0""$confstring1"".ttcookie.lock"
fpfoundhandler_to_load="$confroot""$confstring0""$confstring1"".ttcookie."
self_unwished_pattern="$ttcookie_handler_to_register"""

if [ -f "$fpttcookielock" ]; 
then
echo "hellonovcamellocked">>$outpath$logs
else
    echo "hellonovcamelunlocked">>$outpath$logs
    touch $fpttcookielock
    for i in $(ls $fpfoundhandler_to_load*|grep -v "$self_unwished_pattern"); 
    do
    echo -e "Layer 5 init handler: register handlers from ""$i""\n load all handlers but mine from HOME ###" >>$outpath$logs
    i1=$(cat $i)
    chmod +x "$i1" 2>/dev/null
    echo -e "test -f $i1 && source $i1; " >>$outpath$logs
    test -f "$i1" && . "$i1";  
    done;
    rm $fpttcookielock
fi


ncv () { echo hallo subc; }
novsedhandler () {
echo "novsedhandler () {call .. mainhandler# " >>$outpath$logs
#     bash $Qemuburo_install_dir"Testsscripts/losed/mainhandler.sh" 
#     #a "camel" sequence stamping
#     #tbi: only testdebug
#     cat $timetablefullpath|grep $string_shop_id|grep -v "grep\|watch"|tee $tmpdir"logs.cameltest">>"$tmpdir"'logs';
echo -e "n">>"$tmpdir""robusttest.extra.log"

return 0;
}

#echo "function2:"; grep " () {" $0
#echo "0""$0"
#grep ".*" $0



