##Install Hadoop (single node cluster)

Create a dedicated user group(as hadoop) and user(as hduser) to maintain Hadoop cluster
```
	sudo addgroup hadoop #creating user group
	sudo adduser --ingroup hadoop hduser # creating user
```
Switch to hduser and create a RSA key to hduser for password-less connection to SSH. It will  ask for “file in which to save the key” please hit enter
```
	su hduser #switching user
	ssh-keygen -t rsa -P ""
```
Enable SSH access to your local machine with newly created key
```
	cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
```
Check configured SSH setup by connecting to your local meching with hduser user. It will ask for conformation, type “yes” and enter; and then exit from hduser
```
	ssh localhost
	exit
	exit
```
[Download](http://mirror.reverse.net/pub/apache/hadoop/common/stable/) a new stable version of hadoop (haddop-x.x.x.tar.gz file. In my case it is hadoop-1.2.1.tar.gz). Go to the downloaded directory and un-tar the file it will create a directory call hadoop-1.2.1
```
	cd ~/Downloads
	tar -xzf hadoop-1.2.1.tar.gz
```
Move directory hadoop-1.2.1 to /usr/local and change ownership to hduser
```
	sudo mv hadoop-1.2.1 /usr/local
	sudo chown -R hduser:hadoop /usr/local/hadoop-1.2.1
```
Create soft-links to easy access for hadoop-1.2.1 directory 
```
	sudo ln -s /usr/local/hadoop-1.2.1 /usr/local/hadoop
```
Make directories for Hadoop processing which will act as base temporary directory both for the local file system and HDFS (Hadoop file system). Also make hduser its owner. Thne switch to hduser
```
	sudo mkdir -p /app/hadoop/tmp/
	sudo chown -R hduser:hadoop /app
	sudo chmod -R 777 /app
	su hduser
```
Set hadoop environmental variable and alias in your bash shell config file(i.e. ~/.bashrc)
```
	# Set Hadoop-related environment variables
	export HADOOP_PREFIX=/usr/local/hadoop
	export HADOOP_HOME=/usr/local/hadoop
	# Set JAVA_HOME (we will also configure JAVA_HOME directly for Hadoop later on)
	export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_45/
	# Some convenient aliases and functions for running Hadoop-related commands
	unalias fs &> /dev/null
	alias fs="hadoop fs"
	unalias hls &> /dev/null
	alias hls="fs -ls"
	alias hdstart="cd /usr/local/hadoop && bin/start-all.sh"
	alias hdstop="cd /usr/local/hadoop && bin/stop-all.sh"
	# If you have LZO compression enabled in your Hadoop cluster and
	# compress job outputs with LZOP (not covered in this tutorial):
	# Conveniently inspect an LZOP compressed file from the command
	# line; run via:
	#
	# $ lzohead /hdfs/path/to/lzop/compressed/file.lzo
	#
	# Requires installed ‘lzop’ command.
	#
	lzohead () {
	hadoop fs -cat $1 | lzop -dc | head -1000 | less
	}
	# Add Hadoop bin/ directory to PATH
	export PATH=$PATH:$HADOOP_PREFIX/bin
	export PATH=$PATH:$JAVA_HOME/bin
```
Get into hadoop config directory and edit hadoop-env.sh,core-site.xml,mapred-site.xml,hdfs-site.xml files
```
	chmod 722 /usr/local/hadoop/conf/*
	echo "export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true" >>/usr/local/hadoop/conf/hadoop-env.sh
	echo "export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_45" >>/usr/local/hadoop/conf/hadoop-env.sh
	cd /usr/local/hadoop/conf/
```

Edit core-site.xml file and add below text within <configuration></configuration> tags
```
	<property>
	  <name>hadoop.tmp.dir</name>
	  <value>/app/hadoop/tmp</value>
	  <description>Base folder for other temporary directories.</description>
	</property><property>
	  <name>fs.default.name</name>
	  <value>hdfs://localhost:2810</value>
	  <description>This is name of default file system.</description>
	</property>
```
Edit mapred-site.xml file and add below text within <configuration></configuration> tags
```
	<property>
	  <name>mapred.job.tracker</name>
	  <value>localhost:2811</value>
	  <description>The host and port that the MapReduce job tracker runs at.</description>
	</property>
```
Edit hdfs-site.xml file and add below text within <configuration></configuration> tag. After that save and exit from the terminal.
```
	<property>
	  <name>dfs.replication</name>
	  <value>1</value>
	  <description>Default data blocks replication</description>
	</property>
```
Open a new terminal and format HDFS filesystem via the NameNod
```
	cd /usr/local/hadoop/bin
	./hadoop namenode -format
```
You should find a message line in output "/hadoop-hduser/dfs/name has been successfully formatted." Exit from the terminal and open a new terminal. 

Now you are ready to use hadoop. Login as hduser and start hadoop ```hdstart```. If it is working right then it will ask for anything.

You could open browser HDFS file and see without an error message

	http://localhost:50070/ – NameNode daemon (HDFS Layer)
	http://localhost:50030/ – JobTracker daemon (MapReduce Layer)
	http://localhost:50060/ – TaskTracker daemon (MapReduce Layer)

####Run a sample program to check wheather it is working fine####

Create a directory to save all your HDFS file using sudo access
```
	sudo mkdir /hdfs
	sudo chown -R hduser:hadoop /hdfs
	su hduser
```
Create a text file in your /tmp directory
```
	echo 'This line of text is to check Hadoop working condition. It should return a count of the words' >> /tmp/wctest
```
Move the file into the HDFS system 
```
	fs -put /tmp/wctest /hdfs/wctest
```
Run the word count program
```
	hadoop jar hadoop-examples-1.2.1.jar wordcount /hdfs/wctest /hdfs/wctestopt
```
Output should apper as words and count of the words
```
	fs -cat /hdfs/wctestopt/part-r-00000
```

######[<< Back](Home.md)
