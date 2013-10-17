## Install R Packages

####Install dependent packages for Rhadoop
Get full access for hduser to install R packages with out any issues ```sudo chmod 777 /usr/local/lib/R/site-library```

Add required enivronment
```
echo "export HADOOP_CMD=/usr/local/hadoop/bin/hadoop" >>/ect/bash.bashrc
```

Install required R packages for Rhadoop
```
  sudo R --no-save << EOF
    install.packages(c("rJava","Rserve","Rcpp","RJSONIO","digest","functional","stringr","plyr","bitops","reshape2","R.methodsS3","devtools"), 
         dep=T,repos="http://cran.csiro.au/", INSTALL_opts=c('--byte-compile'))
  EOF
```

####Install rhdfs



####Install rmr2



####Install plyrmr



####Install RHive
