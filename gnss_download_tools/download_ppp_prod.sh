#!/bin/csh

# firstly, link crx2rnx, sh_uncompress and mjday to bin
# sudo cp crx2rnx /opt/
# sudo ln -s /opt/crx2rnx /bin/crx2rnx
# sudo cp sh_uncompress /opt/
# sudo ln -s /opt/sh_uncompress /bin/sh_uncompress
# sudo cp mjday /opt/
# sudo ln -s /opt/mjday /bin/mjday

if ($#argv < 3) then
more << EOF

   Usage $csh download_ppp_prod.sh <path> <yyyy> <doy> 

   EXAMPLES: $csh download_ppp_prod.sh ~/datafolder 2017 001

EOF
   exit
endif

set ppp_prod_dir = $1
@ yyyy  = $2
set yy = `echo $yyyy | awk '{printf("%2.2d",$1-int($1/100)*100)}'`
@ doy   = $3


echo "Download to:" ${ppp_prod_dir}

if (! -d ${ppp_prod_dir}) then 
    mkdir -p ${ppp_prod_dir}
endif

cd ${ppp_prod_dir}

echo " "
echo "Downloading PPP Wizard products (sp3,clk,bia) from http://www.ppp-wizard.net ..."
echo " "

set cdoy = `echo ${doy} | awk '{printf("%3.3d\n",$1)}'`
echo "Year:" ${yyyy} " DOY:" ${cdoy}
   
set WEEKD = `mjday ${doy} ${yyyy} | awk '{nwk=int(($1-44244)/7);nwkd=$1-44244-nwk*7;print nwk*10+nwkd}'`
set WEEK  = `echo ${WEEKD} | awk '{print substr($1,1,4)}'`

echo "Week:" ${WEEK} " Week_Day:" ${WEEKD}

echo "download sp3"
wget -qr -nH --cut-dirs=3 ./ http://www.ppp-wizard.net/products/REAL_TIME/c2t${WEEKD}.sp3.gz
echo "download sp3 done"

echo "download clk"
wget -qr -nH --cut-dirs=3 ./  http://www.ppp-wizard.net/products/REAL_TIME/c2t${WEEKD}.clk.gz
echo "download clk done"

echo "download bia"
wget -qr -nH --cut-dirs=3 ./  http://www.ppp-wizard.net/products/REAL_TIME/c2t${WEEKD}.bia.gz
echo "download bia done"
   
sh_uncompress *.gz
