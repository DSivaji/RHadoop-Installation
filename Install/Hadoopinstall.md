Install Hadoop (single node cluster):

1. Create a dedicated user group(as hadoop) and user(as hduser) to maintain Hadoop cluster(use sudo access)

```
      sudo addgroup hadoop #creating user group
      sudo adduser –ingroup hadoop hduser # creating user
```
2. Switch to hduser and create a RSA key to hduser for password-less connection to SSH. It will  ask for “file in which to save the key” please hit enter

```
    su hduser #switching user
    ssh-keygen –t rsa –P ""
```
3. Enable SSH access to your local machine with newly created key

```
    cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
```
4. Check configured SSH setup by connecting to your local meching with hduser user. It will ask for conformation, type “yes” and enter; and then exit from hduser

```
    ssh localhost
    exit
```
5. Download a new stable version of hadoop (haddop-x.x.x.tar.gz file. In my case it is hadoop-1.0.4.tar.gz)
6. Go to the downloaded directory and un-tar the file it will create a directory call hadoop-1.0.4


    tar –xzf hadoop-1.0.4.tar.gz
7. Move directory hadoop-1.0.4 to /usr/local and change ownership to hduser using sudo access


    sudo mv hadoop-1.0.4 /usr/local
    sudo chown –R hduser:hadoop /usr/local/hadoop-1.0.4
8. Create soft-links to easy access for hadoop-1.0.4 directory 


    sudo ln –s /usr/local/hadoop-1.0.4 /usr/local/hadoop
9. Make directories for Hadoop processing which will act as base temporary directory both for the local file system and HDFS (Hadoop file system). Also make hduser its owner.


    sudo mkdir -p /app/hadoop/tmp/
    sudo chown -R hduser:hadoop /app
    sudo chmod -R 777 /app
10.	Switch to hduser 


    su hduser
12.	Configure your hadoop conf file
Get into hadoop config directory
Command: cd /usr/local/hadoop/conf/
Open hadoop-env.sh Command: vim hadoop-env.sh
Search for HADOOP_OPTS and replace whole line with below to disable IPv6
export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true
Again search for JAVA_HOME and replace whole line with below line
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_21/
Save and exit this file
[ESC] :wq
13.	Set hadoop environmental variable and alias in your bash shell config file(i.e. ~/.bashrc) by copy and paste below lines
Open .bashrc file. Command: vim ~/.bashrc
Copy all lines below in to the file
# Set Hadoop-related environment variables
export HADOOP_PREFIX=/usr/local/hadoop
export HADOOP_HOME=/usr/local/hadoop
# Set JAVA_HOME (we will also configure JAVA_HOME directly for Hadoop later on)
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_21/
# Some convenient aliases and functions for running Hadoop-related commands
unalias fs &> /dev/null
alias fs=”hadoop fs”
unalias hls &> /dev/null
alias hls=”fs -ls”
alias hdstart=” cd /usr/local/hadoop && bin/start-all.sh”
alias hdstop=” cd /usr/local/hadoop && bin/stop-all.sh”
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
Save and exit this file
		[ESC]:wq
14.	Open core-site.xml file
Command: vim core-site.xml
Add below text within <configuration></configuration> tags
<property>
<name>hadoop.tmp.dir</name>
<value>/app/hadoop/tmp</value>
<description>Base folder for other temporary directories.</description>
</property><property>
<name>fs.default.name</name>
<value>hdfs://localhost:2810</value>
<description>This is name of default file system.</description>
</property>
Save and exit this file
	[ESC]:wq
15.	Open mapred-site.xml file
Command: vim mapred-site.xml
Add below text within <configuration></configuration> tags
<property>
<name>mapred.job.tracker</name>
<value>localhost:2811</value>
<description>The host and port that the MapReduce job tracker runs at.</description>
</property>
Save and exit this file
	[ESC]:wq
16.	Open hdfs-site.xml file
Command: vi hdfs-site.xml
Add below text within <configuration></configuration> tag. After that save and exit file as in step 12.
<property>
<name>dfs.replication</name>
<value>1</value>
<description>Default data blocks replication</description>
</property>
17.	Format HDFS filesystem via the NameNod
Command1: cd /usr/local/hadoop/bin
Command2: ./hadoop namenode –format
18.	You should find a message line in output “/hadoop-hduser/dfs/name has been successfully formatted.”
19.	Exit for the terminal and open a new terminal. Now you are ready to use hadoop
20.	How to check hadoop working right?
a.	To start the hadoop cluster
Command: hdstart
It should not ask for anything
b.	Now you could open browser and see without an error message
http://localhost:50070/ – NameNode daemon (HDFS Layer)
http://localhost:50030/ – JobTracker daemon (MapReduce Layer)
http://localhost:50060/ – TaskTracker daemon (MapReduce Layer)

