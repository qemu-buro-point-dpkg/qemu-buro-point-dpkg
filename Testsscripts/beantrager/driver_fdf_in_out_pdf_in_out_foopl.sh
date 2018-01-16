

# another "handler" function: needed for tests
demogreeter1 () {
    demo=$1; 
    echo "Layer 5 buildinhandler2 Hello "$demo
return; }

#third party interface#
foopl="" # project wide fdf-coin
inpdf="foo.pdf"
outpdf="filled.pdf"
thirdpartycodepath="$Qemuburo_install_dir""Testsscripts/beantrager/thirdpartycode/"
a1="" #a1: "user interfae parameter and table representation of user manipulation input data"
#prepare array such: Textfeld|1'Antonius|Weber Textfeld|2'
fdf_value_ui="" #user interface, if to enter a single entry in a certain form field 
fdf_fieldname_ui=""
a1_i_value=""
a1_i_number=""
#uncommented before release, however still syntax template
patchfieldname="Textfeld 4"
#fdf_value_ui="Antonius Weber" #user interface, if to enter a single entry in a certain form field 
#fdf_fieldname_ui="Textfeld 2"
patchvalue="Brunswick"

a1_i_value="5er"
a1_i_number=5
#tbi juggling

#alfoo.pdfpha set_form_buttons_by_name_interface for buttons
patchvalue1="Yes"
patchfieldname1="Markierfeld 3"
foofdf=foo.fdf

greetervar=demogreeter 

tmpdir="$HOME/Downloads"

logs="logs" #
sample_run_counter=0
tmpdir="/tmp/qemuburotest/" #path for temporary and out put data?
mkdir "/tmp/qemuburotest" 2>/dev/null

# timetoken="150887562023415219500"
# samplerate=1 # seconds sleeping between firing (sleep builtin)
# 
# triggertimeslogs="tmp_triggertimes.log" # file name of (future) events list 
# 
# functionname="demogreeter"
# comment="demogreeter0"
# 
# execution_stamp_prefix="a"$sample_run_counter"a" # to use a timetable and a program data base alike
# execution_stamp_postfix="Ω"$every_offset_ns"Ω"$times1"Ω"$functionname"Ω"$comment"Ω" # 
# 
# 
# tokenarray="" #inner variable, list of acute tokens found at sampling time
# date_format="%s%N" #for date utc with nanoseconds
# 
# # "every" (tuesday)" function of a human user interface
# sectonanoconverter="000000000"
# every_offset_sec=360000000 #if in "every"-User-mode: alternating unending mode
# #*60*60*24*7,*365 #every n days, year, not week, weekdays, month, years, 
# 
# every_offset_ns=$every_offset_sec$sectonanoconverter
# times1=2 #event decrementer
# 
# 
# nexttimetoken="" #inner, next token to set in repition mode
# file_offset=0 #line number, where uncommented switches to commented,inner variable
# file_length=0 #of time table inner variable

testdebug="0" # derault off, since huge logs
installpath=$tmpdir #no
userconfigpath=$tmpdir #user configs default: read from output path
conffile="driver_fdf_in_out_pdf_in_out_foopl.userconfig.sh" #userconfigs default file name


#snipped according
#/abs-guide.html#STANDARD-OPTIONS
#G.1. Standard Command-Line Options

while :; do
    case $1 in
        -h|-\?|--help)   # Call a "show_help" function to display a synopsis, 
            #then exit.
            exit
            ;;
        -t|--tmpdir)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                tmpdir=$2
                shift
            fi
            ;;
        --foopl)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                foopl=$2
                shift
            fi
            ;;
        --inpdf)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                inpdf=$2
                shift
            fi
            ;;
        --outpdf)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                outpdf=$2
                shift
            fi
            ;;
        --times)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                times1=$2
                shift
            fi
            ;;
        --testdebug)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                testdebug=$2
                shift
            fi
            ;;
        --userconfigpath)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                userconfigpath=$2
                shift
            fi
            ;;
        -v|--verbose)
            echo hello2
            verbose=$((verbose + 1)) # Each -v argument adds 1 to verbosity.
            ;;
        --)              # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)               # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done


#read a userconfig default from output dir, tb completed to a debian standard
cd $tmpdir
#userconfigpath=$userconfigpath" "$userconfigpath
  for a in $userconfigpath;
      do test -f $a$conffile && source $a$conffile $tmpdir
  done 
#source /tmp/qemuburotest/Buildingloggerdemon.userconfig.sh 

#we fill the logs of a def test_dummy_ready_to_start_tdd_gnu_cli_project_demo_example(self):
echo PPool$PPool RANGE$RANGE dup$dup stage1batchmode$stage1batchmode Slot$Slot startstage$startstage > $PPool"logs"

# #userconfigpath=$userconfigpath" "$userconfigpath
#   for a in $userconfigpath;
#       do time test -f $a$conffile && source $a$conffile $tmpdir
#   done 

#scrap from voult spezification see stamp to db format
#echo "hello "$Qemuburo_install_dir"Testsscripts/losed/""driver_fault2db.sh"
tmpdir="/tmp/qemuburotest/"
cd "$tmpdir"
#tbi


#test_values_to_logs
#pdftk interface tutorial chemitz? -dump..
#test_values_to_foopl#
#sed
#if not existant foo.pl create empty one from pdf, default 

if [ "$foopl" = "" ]; then
foopl="foo.pl" # project wide fdf-coin
fi
# ref to 3.party code *2
if [ -f $foopl ]; then 
echo "h">/dev/null
else
pdftk $inpdf dump_data_fields | perl "$thirdpartycodepath"fields2pl.pl > $foopl
fi

#test_values_to_foopl#
# nice, but we need it even we a proposed data
#..
# a bash string manupulation matter
# so nothing, where other go the highway, we chuggle the forest path side way besides..
# carefully enpackaged our lunch package, right? First, to fullfill ui needs A1 and A2. So?
#empackage read data a1: "user interfae parameter and table representation of user manipulation input data"
#fdf_specifier_fomat_string="Textfeld"
if [ "$a1" = "" ]; then
    #pdftk $inpdf dump_data_fields|head -n23 
    a1=$(pdftk $inpdf dump_data_fields|grep -A2 Textfeld|grep -v "\-\-\|FieldFlag"|sed -e "s/FieldValue: /lue:/"|sed -e "s/FieldName: /ame:/"|tr " " "|"  |tr "\n" "\'"|sed -e "s/'ame/ ame/g")
    #dump voult to disk as for template
    echo $a1>"$tmpdir"tmp_a1
fi
inc=0
for i in $a1; do
    #i="Textfeld|1'Antonius|Weber Textfeld|2"
    #i="ame:Textfeld|1'lue:Antonius|Weber"
    fdf_fieldname_i=$(echo $i |cut -f1 -d"'" |tr "|" " "|cut -f2 -d":")
    fdf_value_i=$(echo $i |cut -f2 -d"'" |tr "|" " "|cut -f2 -d":")
    ##sedpatch1 sed $foopl patch
    #'Textfeld 1'=>q{},
    #echo $i $fdf_fieldname_i $fdf_value_i
    sed -e "s/\('$fdf_fieldname_i'=>q{\).*\(}\)/\1$fdf_value_i\2/" -i $foopl
    #echo "sed -e ""s/\('$fdf_fieldname_i'=>q{\)\(}\)/\1$fdf_value_i\2/"" -i $foopl"

    #cat $foopl|grep "Textfeld 1'"
    #sed -e $foopl "s/$fdf_fieldname/fffff/g" #-i
    # todo dive to perl syntax
    #sedpatch2
    #pseudocode: if inc=a1_i_number: sed $a1(inc) foo.pl
    let inc+=1
    #echo $inc"inc"
    #after-patching the results for a set_text_by_index
    if [ $inc -eq  $a1_i_number ]; then
        #pdftk $inpdf dump_data_fields|head -n23 
        echo $inc"inc"
        sed -e "s/\('$fdf_fieldname_i'=>q{\).*\(}\)/\1$a1_i_value\2/" -i $foopl
        #dump voult to disk as for template
    fi

    #ui manipulate form xy find by number of textfields
done
# patch foo.pl out of for loop
#ui manupulate_formu xy find_by_name of textfield, such as: where in formular field name is Textfeld 4, set Brunswick.
sed -e "s/\('$patchfieldname'=>q{\)[^}]*\(}\)/\1$patchvalue\2/" -i $foopl
#echo "sed -e ""s/\('$fdf_fieldname_i'=>q{\)\(}\)/\1$fdf_value_i\2/"" -i $foopl"

if [ "$fdf_fieldname_ui" != "" ]; then
#sedpatch3 with fdf_fieldname_ui
 echo "hrll§">/dev/null
fi

if [ "$fdf_value_ui" != "" ]; then
#sedpatch4 with fdf_value_ui;
 echo "hrll§">/dev/null
fi;
#test_values_to_foopl_end#

# third party snipped
perl "$thirdpartycodepath"genfdf.pl $foopl > foo.fdf
# Does that say I could parse that simply? Does it says it? Yes, Yes.
## fdf manunipulation start
foofdf=foo.fdf
sed -e "s/\(<< \/T ($patchfieldname1) \/V (\).*\()\)/\1$patchvalue1\2/g" -i $foofdf 



pdftk $inpdf fill_form foo.fdf output $outpdf
# third party snippedend 

#pwd
pdftotext filled.pdf -|grep "Weber">greppedWeber.log

##you had the text input, what about buttons?
#button section

#pdftk $outpdf dump_data_fields|grep Button -A6
a2Buttons=$(pdftk $inpdf dump_data_fields|grep Button -A6)
#echo $a2Buttons
#FieldType: Button FieldName: Markierfeld 4 FieldFlags: 0 FieldValue: FieldJustification: Left FieldStateOption: Off FieldStateOption: Yes -- FieldType: Button FieldName: Markierfeld 2 FieldFlags: 0 FieldValue: FieldJustification: Left FieldStateOption: Off FieldStateOption: Yes -- FieldType: Button FieldName: Markierfeld 3 FieldFlags: 0 FieldValue: FieldJustification: Left FieldStateOption: Off FieldStateOption: Yes

#test_1_issue botton form update,2. change a button.

