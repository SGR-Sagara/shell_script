host_name=`hostname`
my_user=`whoami`

mkdir ${host_name}_${my_user}_xfbexport;

pelbase export_site -f  ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}sites
pelbase export_lsite -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}lsites
pelbase export_appli -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}appli
pelbase export_list -f  ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}list
pelbase export_model -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}model
pelbase export_user -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}user
pelbase export_user -f  ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}user
pelbase export_profile -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}profile
pelbase export_cgate -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}cgate
pelbase export_cgategroup -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}cgategroup
pelbase export_decisionrule -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}decisionrule
pelbase export_ruletable -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}ruletable
pelbase export_proplist -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}proplist
pelbase export_tradepart -f ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}tradepart

secbase export_cert -ctfn ${host_name}_${my_user}_xfbexport/${host_name}_${my_user}cert

tar -cvf ${host_name}_${my_user}_xfbexport.tar ${host_name}_${my_user}_xfbexport/

echo "COnfigruation greated and zipped ${host_name}_${my_user}_xfbexport.tar"

echo "Export successfull..."

exit 0

