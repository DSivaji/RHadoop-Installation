RHadoop Installation
=====================

Setup a Hadoop cluster at your home and configure R to analyze your data

Here are the steps to follow to setup a single node hadoop cluster, Hive and R

1.	[Install JDK(Version: latest, in my case JDK v7 update 21)](Javainstall.md)
2.	Install Hadoop (Version: Hadoop-1.1.2)
3.	Install Hive (Version: Hive-0.10.0)
4.	Install R with shared libraries(Version: R-3.0.1 "Good Sport")
5.	Install Rstudio(Version: latest version)
6.	Install required packages
7.	Configuring R, hadoop and hive

Note: 
1. Check your system type, is it 32 bit or 64 bit (in my case it is 64 bit)
2. Be aware of your application versions
Install freshly a new Ubuntu (in my case Version: 13.04 on Oracle Virtual Box) with fully upgraded over the net with some basic applications 
  * sudo apt-get install vim # Modified vi editor
  * sudo apt-get install ssh # Hadoop cluster works on SSH network to manages its resources