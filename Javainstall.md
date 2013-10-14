Install JDK:

1. Download Oracle JDK from Oracle download page (in my case jdk-7u21-linux-x64.tar.gz)
2. Open Terminal window and go to the directory where you downloaded the above file. Un-tar the file and it will create a directory with the name jdk1.7.0_21 
            tar –xzf jdk-7u21-linux-x64.tar.gz
3. Create a directory “jvm” under the path /usr/lib using sudo access
            sudo mkdir -p /usr/lib/jvm
4. Move the directory jdk1.7.0_21 to the created directory in Step 3 using sudo access
            sudo mv jdk1.7.0_21 /usr/lib/jvm/
5. Update alternatives of java, javac & javaws to Ubuntu environment with sudo access
            sudo update-alternatives --install “/usr/bin/java” “java”  “/usr/lib/jvm/jdk1.7.0_21/bin/java” 1
            sudo update-alternatives --install ”/usr/bin/javac” “javac” “/usr/lib/jvm/jdk1.7.0_21/bin/javac” 1
            sudo update-alternatives --install ”/usr/bin/javaws” “javaws” “/usr/lib/jvm/jdk1.7.0_21/bin/javaws” 1
6. Now just update and configure to use as default on your machine
            sudo update-alternatives –config java
7. Let’s also install Java plugin on your Firefox web-browser
  * Goto Firefox plugins folder
            cd /usr/lib/firefox/plugins/ #or use cd /usr/lib/mozila/plugins/
  * Create a soft-link to java browser plugin file
            sudo ln -s /usr/lib/jvm/jdk1.7.0_21/jre/lib/amd64/libnpjp2.so
  * Verify if it is working: Open Firefox browsers and type “about:plugins” in the address bar, you could see an entry for Java. 
