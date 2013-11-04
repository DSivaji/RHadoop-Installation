## Install R Packages

####Install dependent packages for Rhadoop

Add few enivronment variable to different files

First add LD_LIBRARY_PATH to```sudo vi /etc/bash.bashrc```
```
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server:$JAVA_HOME/jre/lib/amd64
```
Update and configure Java
```
sudo update-alternatives --config java #Update with Java version what you have installed earlier
sudo R CMD javareconf
```

Get full access for hduser to install R packages without any issues ```sudo chmod 777 /usr/local/lib/R/site-library```

Open in a new terminal login to hduser
```
R --no-save << EOF
  install.packages(c("rJava","Rserve","Rcpp","RJSONIO","digest","functional","stringr","plyr","bitops","reshape2","R.methodsS3","devtools"), 
       dep=T,repos="http://cran.csiro.au/", INSTALL_opts=c('--byte-compile'))
EOF
```

####Install RHadoop

Add required enivronment to```$HADOOP_HOME/conf/hadoop-env.sh```
```
export R_HOME=/usr/lib/R 
```
Add HADOOP_CMD to```sudo vi /etc/bash.bashrc```
```
export HADOOP_CMD=/usr/local/hadoop/bin/hadoop
```
It requires rhdfs,rmr2 packages and [download](https://github.com/RevolutionAnalytics/RHadoop/wiki/Downloads) them and install as below
```
cd ~/Downloads
sudo HADOOP_CMD=/usr/local/hadoop/bib/hadoop R CMD INSTALL rhdfs_1.0.7.tar.gz
sudo R CMD INSTALL rmr2_2.3.0.tar.gz
```

####Install plyrmr
First install require packages and then install plyrmr
```
sudo R --no-save <<EOF
library(devtools)
install_github("pryr","hadley")
install.packages("hydroPSO",dep=T,repos="http://cran.csiro.au/")
EOF

R CMD INSTALL plyrmr_0.1.0.tar.gz
```

####Install RHive
First clone the git repo, build the source code and then install most recent package
```
cd ~/Downloads
mkdir RHive_source
cd RHive_source
git clone git://github.com/nexr/RHive.git
cd RHive
ant build
sudo R CMD build ./RHive
sudo R CMD INSTALL --byte-compile RHive_2.0-0.0.tar.gz
```

Note: Recommended to install R-Studio IDE
