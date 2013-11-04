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
