##Testing RHadooop and RHive

#### Testing RHive

Start HDFS ```hdstart``` then start hive server2 ```hvsst2```

Open R-Studio and run the code

```
library(Rserve) #loading R server package
Rserve(args="--no-save")
#Set environment variables
Sys.setenv(HADOOP_HOME="/usr/local/hadoop")
Sys.setenv(HIVE_HOME="/usr/local/hive")

library(RHive)
#Conneting to Hive
rhive.connect()
rhive.env()

#Create an R dataset 
xy=data.frame(x=1:10,y=(1:10)**2)

#Loading R dataset into hive
rhive.write.table(data=xy,tableName='xy')
rhive.list.tables() #It show up xy table

#Selecting data fron Hive
rhive.load.table(tableName='xy') #It should show the table content
```

#### Testing RHadoop

First start HDFS ```hdstart```

```
#Set environment variables
Sys.setenv(HADOOP_HOME="/usr/local/hadoop")
Sys.setenv(HADOOP_CMD="/usr/local/hadoop/bin/hadoop")

library(rmr2)
library(rhdfs)
hdfs.init()

x=1:5
hdfsx=to.dfs(x)
hdfs.ls("/tmp") #This will show all HDFS fin in /tmp directory
from.dfs(hdfsx) #Pulling Hadoop R object
```

#### Word count example

Open terminal and create and load a test file into HDFS
```
echo "this is the file testing hadoop and this should work fine" >> /tmp/wctest.txt
fs -put /tmp/wctest.txt /hdfs/hdfp/wctest.txt
```
Open R-Studio and run below rmr program
```
#Set environment variables
Sys.setenv(HADOOP_HOME="/usr/local/hadoop")
Sys.setenv(HADOOP_CMD="/usr/local/hadoop/bin/hadoop")
Sys.setenv(HADOOP_STREAMING="/usr/local/hadoop/contrib/streaming/hadoop-streaming-1.2.1.jar") #Is for HDFS file streaming

library(rmr2)
library(rhdfs)
hdfs.init()

#Output dfs object into a R dataframe
hdfs.ouput=function(hdfsobj)
{
  r=from.dfs(hdfsobj)
  return(data.frame(Key=r$key,Val=r$val))  
}

#MapReduce for Word count
wordcount=function(input,output=NULL,pattren=" ")
{
     return(mapreduce(input=input,output=output,input.format="text",
                      map=function(k,v) { words <- unlist(strsplit(v,split=pattren)) keyval(words,1)},
                      reduce=function(k,vv) keyval(k,sum(vv))))
}

hdfs.ouput(wordcount(input='/hdfs/hdfp/wctest.txt'))
```
