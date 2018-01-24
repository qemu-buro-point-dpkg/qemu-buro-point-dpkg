#third party interface#
foopl="" # project wide fdf-coin
inpdf="foo.pdf"
outpdf="filled.pdf"
thirdpartycodepath="$Qemuburo_install_dir""Testsscripts/beantrager/thirdpartycode/"
a1="" #a1: "user interfae parameter and table representation of user manipulation input data" to input
#prepare array such: Textfeld|1'Antonius|Weber Textfeld|2'
fdf_value_ui="" #user interface, if to esegment a file in bash sednter a single entry in a certain form field 
fdf_fieldname_ui=""
a1_i_value=""
a1_i_number=""
#uncommented before release, however still syntax template
#fdf_value_ui="Antonius Weber" #user interface, if to enter a single entry in a certain form field 
#fdf_fieldname_ui="Textfeld 2"
a1_i_value="5er"
a1_i_number=5
#tbi juggling

#scaling pdfform types:consult support form types list

#fdf_FieldType=Text
fdf_FieldType="Button"


#alfoo.pdfpha set_form_buttons_by_name_interface for buttons, type "donate for books"-uni library chemnitz
patchvalue1="Yes" #for buttons, Off
patchfieldname1="Markierfeld 3"

patchvalue="Brumszwick" #for text
patchfieldname="Textfeld 4"



foofdf=foo.fdf

greetervar=demogreeter 

tmpdir="$HOME/Downloads"

logs="logs" #
sample_run_counter=0
tmpdir="/tmp/qemuburotest/" #path for temporary and out put data?
mkdir "/tmp/qemuburotest" 2>/dev/null


testdebug="0" # derault off, since huge logs
installpath=$tmpdir #no
userconfigpath=$tmpdir #user configs default: read from output path
#conffile="driver_fdf_in_out_pdf_in_out_foopl.userconfig.sh" #userconfigs default file name
