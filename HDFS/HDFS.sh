		Daemon			Default Port	Configuration Parameter
HDFS	Namenode			50070		dfs.http.address
        Datanodes			50075		dfs.datanode.http.address
		Secondarynamenode	50090		dfs.secondary.http.address
		Backup/Checkpoint node?	50105	dfs.backup.http.address
MR		Jobracker			50030		mapred.job.tracker.http.address
		Tasktrackers		50060		mapred.task.tracker.http.address

sudo lsof -u username | grep 'Book.scala'  --- to check file was open or not in linux
mysql -u root -p
show databases;
create database retail_db;  || drop database retail_db;
create user reatil_dba identified by 'hadoop';  || drop user retail_dba;
grant all on retail_db.* to retail_dba;
flush privileges;
use retail_db;
source /root/hdp/retail_db.sql;
hdfs dfs -dus pathoffile Know the sizs of the HDFS folder

How to configure Replication Factor in HDFS?
hdfs-site.xml is used to configure HDFS. Changing the dfs.replication property in hdfs-site.xml will change the default replication for all files placed in HDFS.
You can also modify the replication factor on a per-file basis using the
Hadoop FS Shell:[training@localhost ~]$ hadoopfs –setrep –w 3 /my/fileConversely,
you can also change the replication factor of all the files under a directory.
[training@localhost ~]$ hadoopfs –setrep –w 3 -R /my/dir

Avro -vs- Parquet
Avro is a row-based storage format for Hadoop. However Avro is more than a serialisation framework its also an IPC framework
Parquet is a column-based storage format for Hadoop. 

Both highly optimised (vs pain text), both are self describing , uses compression 

If your use case typically scans or retrieves all of the fields in a row in each query, Avro is usually the best choice.
If your dataset has many columns, and your use case typically involves working with a subset of those columns rather than entire records, Parquet is optimized for that kind of work.
Parquet is a file format that really gears towards analytical querying that means write once and read many times.
At present Parquest doesn't support modifying the existing columns but you can append the new columns.
Parquest really shine if we want to query only few columns from the dataset.If we want to query whole data set the  avro is good might be like ETL tool that processsing the data.

File Formats:
Ggip: Uses more cpu resource then snaapy or lzo but provides higher compression ratio.  
Snappy and Lzo are optimized for speed and are around an order of maginted faster than Gzip, Snappy is significatly faster then LZO for decompression.
Gzip2 compresses more effectively then Gzip but it is slower if you need your compressed data to be splitable for MapReduce bgip2 files can be split and so can LZO files if they have been indexed in a pre procesing step.


