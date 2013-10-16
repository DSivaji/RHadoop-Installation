##Install R with shared libraries

Please read [instruction](http://cran.r-project.org/bin/linux/ubuntu/README) here before install R in Ubuntu
Log in as admin access with sudo access
First install dependencies for compiling R(it will take a while to download and build dependences). It will ask for continue type “Y” and hit enter.
sudo apt-get build-dep r-base 
sudo apt-get install r-base r-recommended r-base-dev
Install documentation in HTML format for packages in core R and manuals in PDF format 
sudo apt-get install r-base-html r-doc-pdf
Downloading R via http(You can download latest R version from CRAN or choose which version you want from - http://cran.r-project.org/src/base/)
wget http://cran.r-project.org/src/base/R-2/R-2.15.2.tar.gz
Go to the directory where it is downloaded and un-tar the file. It will create a directory call R-2.15.2
tar –xfz  R-2.15.2.tar.gz
Switch to hduser
su hduser
To build shared libraries 
cd /Rin/R-2.15.2
./configure  --enable-R-shlib 
make
make install
Now you install R with shared libraries
To start R, In terminal Type “R” and hit enter
