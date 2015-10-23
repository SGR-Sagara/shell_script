#!/bin/bash
## CEXP1 - Customer Export invoices Report

cd /home/trafik/COMAMEXBTA/amexnordic/
dats=$(date --date "last month" +%m)
dys=$(cal $(date +"$dats %Y") | awk 'NF {DAYS = $NF}; END {print DAYS}')
mon=$(date +"%Y%m")
rep_mon=$(date +"%Y-%B")

xml_dn_basware=$(find ./xml_dn_basware/$mon* -type f | wc -l)
xml_dn_capgemini=$(find ./xml_dn_capgemini/$mon* -type f | wc -l)
xml_dn_digidoc=$(find ./xml_dn_digidoc/$mon* -type f | wc -l)
xml_dn_logicaskanska=$(find ./xml_dn_logicaskanska/$mon* -type f | wc -l)
xml_dn_stralfors=$(find ./xml_dn_stralfors/$mon* -type f | wc -l)
xml_cc_basware=$(find ./xml_cc_basware/$mon* -type f | wc -l)
xml_cc_molnlycke=$(find ./xml_cc_molnlycke/$mon* -type f | wc -l)
xml_cc_omxdk=$(find ./xml_cc_omxdk/$mon* -type f | wc -l)
xml_cc_omxfi=$(find ./xml_cc_omxfi/$mon* -type f | wc -l)
xml_cc_omxse=$(find ./xml_cc_omxse/$mon* -type f | wc -l)
xml_cc_storaenso=$(find ./xml_cc_storaenso/$mon* -type f | wc -l)
xml_ws_basware=$(find ./xml_ws_basware/$mon* -type f | wc -l)
xml_ws_outokumpu=$(find ./xml_ws_outokumpu/$mon* -type f | wc -l)
svefak_itella=$(find ./svefak_itella/$mon* -type f | wc -l)
xml_tullverket=$(find ./xml_tullverket/$mon* -type f | wc -l)
xml_e2b_skanska=$(find ./xml_e2b_skanska/$mon* -type f | wc -l)
paper_logica=$(find ./paper_logica/$mon* -type f | wc -l)
Netrevelation=$(find ./Netrevelation/ -mtime -$dys -type f | wc -l)
archive_logica=$(find ./archive_logica/ -mtime -$dys -type f | wc -l)


echo "Customer Export invoices for $rep_mon" > /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "Customer Export Type ; Total No. of files"  >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_DN [Basware] ; "$xml_dn_basware >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_DN [Cap Gemini]; "$xml_dn_capgemini >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_DN [Digidoc]; "$xml_dn_digidoc >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_DN [Logica Skanska]; "$xml_dn_logicaskanska >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_DN [Stralfors]; "$xml_dn_stralfors >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_CC  [Basware]; "$xml_cc_basware >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_CC  [Molnlycke]; "$xml_cc_molnlycke >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_CC  [OMX_Denmark]; "$xml_cc_omxdk >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_CC  [OMX_Finland]; "$xml_cc_omxfi >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_CC  [OMX_Sweden]; "$xml_cc_omxse >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_CC  [Stora Enso]; "$xml_cc_storaenso >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_WS [Basware]; "$xml_ws_basware >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML_WS [Outokumpu]; "$xml_ws_outokumpu >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "Svefaktura/XML e2b DN [Itella]; "$svefak_itella >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "Svefaktura DN [Tullverket]; "$xml_tullverket >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "XML e2b [Skanska]; "$xml_e2b_skanska >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "Paper Logica; "$paper_logica >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "Net Revelelation Taxi Data; "$Netrevelation >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
echo "Logica Archive; "$archive_logica >> /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt

mail -s "AMEX Customer Export invoices for $rep_mon" sagara.jayathilaka@ebuilder.com ravinda.abeysinghe@ebuilder.com hemantha.dejoedth@ebuilder.com Charitha.Perera@ebuilder.com < /home/trafik/sgr/Customer_Export_invoices_for_$rep_mon.txt
