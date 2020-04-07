##Install the preprocessing software
##1.TEQC: https://www.unavco.org/software/data-processing/teqc/teqc.html
## uncompress it , move it to /opt/, and then use softlink 
##ln -s /opt/xx /bin/xx to add it to the environment 
##2.crx2rnx: https://terras.gsi.go.jp/ja/crx2rnx.html
##copy the /bin/CRX2RNX file to the project folder 

##Download the data
## now the data frequency is 1Hz
## you should download some more high rate data
## use a shell file to download the data

raw_data_folder=./static_raw_data;
o_files_folder=./static_o_files;

##Uncompress the data
sudo uncompress ${raw_data_folder}/*.Z
echo "uncompressing done"

##convert to RENIX file
sudo find ${raw_data_folder}/ -name *.16d -exec ./CRX2RNX {} \;
echo "file format convertion done"
sudo mkdir ${o_files_folder}
mv ${raw_data_folder}/*.16o ./${o_files_folder}/
echo "RINEX observation files are saved in o_files folder"  

##merge renix file of a station over several hours
#cd o_files
#sudo mkdir long_o_files

##set station name for processing
#station=ropi;
#doy=300;

#sudo teqc ${station}* > ./long_o_files/${station}${doy}.16o
#echo "merge RINEX files for station " ${station} "done"

#cd ..
