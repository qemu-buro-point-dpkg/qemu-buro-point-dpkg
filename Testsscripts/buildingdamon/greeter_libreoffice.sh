


pid=$(ps x|grep soffice.bin|grep -v grep|cut -f1 -d" ")

if [ "$pid" = "" ] ; 
then 
soffice "--accept=socket,host=localhost,port=8100;urp;" --headless --invisible &
fi
pid=$(ps x|grep soffice.bin)

echo "hello libreoffice greeter""pid ""$pid">/tmp/qemuburotest/logs




#kill $pid
killall soffice.bin
