##Install R with shared libraries

Please read [instruction](http://cran.r-project.org/bin/linux/ubuntu/README) here before install R in Ubuntu. 
Get sudo access and add below entries in ```/etc/apt/sources.list``` file to obtain latest R packages. Remember to update below lines with your Ubuntu release name. 

```
  deb http://cran.ms.unimelb.edu.au/bin/linux/ubuntu raring/
  deb http://mirror.cse.iitk.ac.in/ubuntu/ raring-backports main restricted universe
```
The Ubuntu archives on CRAN are signed with the key of "Michael Rutter" with key ID E084DAB9.  To add the key to your
system with below commands
```
  gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
  gpg -a --export E084DAB9 | sudo apt-key add -
```
Install and update basic and R related required applications 
```
  sudo apt-get install make
  sudo apt-get install build-essential
  sudo apt-get update
  sudo apt-get build-dep r-base
  sudo update-alternatives --config java #Update with latest Java version
  sudo apt-get install r-base r-recommended r-base-dev
  sudo apt-get install r-base-html r-doc-pdf
  sudo apt-get install libcurl4-gnutls-dev
  sudo apt-get install littler
  sudo R CMD javareconf
```
Now check R installed correctly compiled using --enable-R-shlib. ```sudo R CMD config --ldflags``` It will print a path, take the printed path and check the "libR.so" file exist in that location. If you couldn't see the file then something must gone worng.

If you install R successfully, follow below steps

Get full access for hduser to install packages in R ```sudo chmod 777 /usr/local/lib/R/site-library```

Install required R packages for Rhadoop
```
sudo R --no-save << EOF
    install.packages(c("rJava","Rserve","Rcpp","RJSONIO","digest","functional","stringr","plyr","bitops","reshape2","RHive","R.methodsS3","devtools"), 
         dep=T,repos="http://cran.csiro.au/", INSTALL_opts=c('--byte-compile'))
EOF
```
