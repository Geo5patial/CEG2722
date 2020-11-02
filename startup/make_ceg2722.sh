#!/bin/bash
#
# script to prepare the linux environment for the module ceg2722 
# under the Newcastle Linux system.
#
#
echo "==========================================================="
echo "|                                                         |"
echo "| Welcome to CEG2722 - part2: Linux data processing       |"
echo "|                                                         |"
echo "==========================================================="
echo ""
echo ""
echo "STEP 0: Make sure you do have wget and curl"
if ! [[ -x "$(command -v wget)" && -x "$(command -v curl)" ]]; then
  echo "Error: wget and/or curl is not installed." >&2
  exit 1
else
	echo "Great, lets go"
fi
exit
echo ""
echo "=========================================================="
echo ""
echo "STEP 1: Setup your bash  profile\n"
wget https://raw.githubusercontent.com/koulali/CEG2722/main/startup/bashrc ~/.bashrc
echo " done..."
echo ""
echo "=========================================================="
echo ""
echo "STEP 2: Download micro text editor\n"
mkdir ~/bin/
curl https://getmic.ro | bash
mv ./micro ~/bin/
echo " done..."
echo ""
echo "=========================================================="
echo ""
echo "STEP 3: Download CEG2722 practicals\n"
mkdir ~/ceg2722
mkdir ~/ceg2722/practicals/
cd ~/ceg2722/practicals/
wget https://raw.githubusercontent.com/koulali/CEG2722/main/startup/ceg2722_data.tar.gz
tar -xvzf ceg2722_data.tar.gz
cd ~/
echo " done..."
echo ""
echo "=========================================================="
echo ""
echo "STEP 4: Download TEQC\n"
wget https://www.unavco.org/software/data-processing/teqc/development/teqc_CentOSLx86_64d.zip
gunzip teqc_CentOSLx86_64d.zip
mv teqc ~/bin/
echo " done..."
echo "=========================================================="
echo ""
echo "STEP 4: Download CRX2RNX\n"
wget https://terras.gsi.go.jp/ja/crx2rnx/RNXCMP_4.0.8_Linux_x86_64bit.tar.gz
tar xvzf RNXCMP_4.0.8_Linux_x86_64bit.tar.gz
mv ./RNXCMP_4.0.8_Linux_x86_64bit/bin/CRX2RNX ~/bin/crx2rnx
rm -rf RNXCMP_4.0.8_Linux_x86_64bit.tar.gz ./RNXCMP_4.0.8_Linux_x86_64bit/
echo " done..."
echo "=========================================================="
echo "That's All Folks!"


