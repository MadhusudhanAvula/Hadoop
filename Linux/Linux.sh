find / -name "mysql*.jar" --> to search 
ln -s /root/hdp/java/mysql-commector/version(1.5.8.9) /root/hdp/mysql-connector --> to setup a soft link ln -s /orginal_path  /custome_name
unlink custome_name --> to unlink the path
ps -ef|grep -i manager(or)node | ps -fu hdfs(or)yarn  |  /hadoop dfsadmin -report |fsck
hadoop fs -du -s -h --> to find the size of file
ls -al

sudo lsof -u username | grep 'Book.scala'  --- to check file was open or not in linux

---------------------------------------------
java install:
-------------
sudo apt-get install openjdk-8-jdk
java -version
javac -version

To Set Java Path:
update-alternatives --config java
gedit /etc/environment
JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

Verify Java Path:
source /etc/environment
echo $JAVA_HOME

Install Hadoop:
sudo apt-get install ssh
Verify Hadoop Installation:
ssh localhost

Cloudera:
---------
To start cloudera manager:
sudo /home/cloudera/cloudera-manager --force

sudo /home/cloudera/cloudera-manager --express --force
To start MySql-------mysql -u root -p
To show databases-----show databases;

To check the memory in Hadoop cluster:
Top

Vmstat
To access environment variables: cat ~/.bash,   cat ~/.bashrc
To add domine : cat /etc/hosts
To modify host name:  /etc/sysconfig/network

By using touch command, we can create multiple empty files
Cat filename.txt |grep “word”
To find total lines: wc  -l filename.txt
To merge files in Hadoop: Hadoop fs -getmerge path filenames


Hadoop fs -cat testing
Ping (hostname)
Cat /etc/hosts
PIG:
C = FOREACH A GENERATE (loc == 'hyd'?'HYDERABAD':'OTHER') AS Location,loc;
C = FOREACH A GENERATE (CASE WHEN loc == 'hyd' then 'HYDERABAD' else 'OTHER' end) AS Location,loc;
conc = FOREACH A GENERATE CONCAT('HomeTwon-',loc) AS LocDtls;
cnt = FOREACH groupbyloc GENERATE COUNT(A),group;
A = LOAD '/chenna/sample.txt' USING PigStorage(',') AS (id:int,name:chararray,loc:chararray);
grp = GROUP A BY loc;
cnt = FOREACH grp GENERATE COUNT(A),group;

Cloudera:
$ wget http://archive.cloudera.com/cm5/installer/latest/cloudera-manager-installer.bin

$ chmod u+x cloudera-manager-installer.bin

$ sudo ./cloudera-manager-installer.bin


LINUX Ethernet config:
cd /etc/sysconfig/network-scripts/
service network restart
 
CentOS:
To configure the resolve file: nano /etc/resolv.conf
For host name : nano /etc/sysconfig/networ
