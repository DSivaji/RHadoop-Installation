## Hive Installation 


Please check Hive [compatibility](http://hive.apache.org/releases.html) with Hadoop version and [download](http://apache.spinellicreations.com/hive/stable/) it.

Log in as admin for sudo access

Un-tar the hive tar.gz file (hive-x.x.x.tar.gz file. In my case it is hive-0.11.0.tar.gz)

Go to the downloaded directory and un-tar the file it will create a directory call hive-0.11.0.
```
  tar -xzf hive-0.11.0.tar.gz
```
Move directory hive-0.11.0 to /usr/local and change ownership to hduser using sudo access
```
  sudo mv hive-0.11.0 /usr/local
  sudo chown -R hduser:hadoop /usr/local/hive-0.11.0
```
Create soft-links to easy access for hive-0.10.0 directory 
```
  sudo ln -s /usr/local/hive-0.11.0 /usr/local/hive
```
Switch to hduser ```su hduser```

Set Hive environmental variable and alias in your bash shell config file(i.e. ~/.bashrc) by copy and paste below lines
Edit .bashrc file. 
```
  #setting up hive home path
  export HIVE_HOME=/usr/local/hive
  export PATH=$HIVE_HOME/bin:$PATH
  export HIVE_CONF=$HIVE_HOME/conf 
  export HIVE_LIB=$HIVE_HOME/lib
  
  #creating alias for start hive
  alias hvstart="cd /usr/local/hive/ && bin/hive"
  #creating alias for start hive thrift server mode
  alias hvsst="cd /usr/local/hive/ && bin/hive --service hiveserver"
  alias hvsst2="cd /usr/local/hive/ && bin/hive --service hiveserver2"
```
Exit from the terminal and open a new terminal. Now you are ready to use hive

####How to check hive working right?

  * To start the hive cluster(make sure hadoop started already) ```hvstart```. It should show up a command prompt as "hive>"
  * Then type ```show tables;``` and then hit enter it should run properly without showing any errors. It will show “OK” since there is no preloaded table in hive
  * To start hiveserver use ```hvsst``` and for hiveserver2 ```hvsst2```

