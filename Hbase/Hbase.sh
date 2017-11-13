MemStore:
In general when something is written to HBase, it is first written to an in-memory store (memstore), once this
 memstore reaches a certain size*, it is flushed to disk into a store file (everything is also written immediately 
 	to a log file for durability). 
*From Global perspective, HBase uses by default 40% of the heap (see property hbase.regionserver.global.memstore.upperLimit) 
for all memstores of all regions of all column families of all tables. If this limit is reached, it starts flushing
 some memstores until the memory used by memstores is below at least 35% of heap (lowerLimit property). This is adjustable 
 but you would need to have perfect calculation to have this change.
Yes GC does impact on memstore and you can actually modify this behavior by using Memstore-local allocation buffer. 
I would suggest you to read the 3 part article on "Avoiding Full GCs in HBase with MemStore-Local Allocation Buffers" as 
below : http://www.cloudera.com/blog/2011/02/avoiding-full-gcs-in-hbase-with-memstore-local-allocation-buffers-part-1/


scan 'test', {COLUMNS => ['F'],FILTER => \ 
"(SingleColumnValueFilter('F','u',=,'regexstring:http:.*pdf',true,true)) AND \
(SingleColumnValueFilter('F','s',=,'binary:2',true,true))"}

echo "scan 'tableName', { COLUMNS => 'cf:cq2', FILTER => \"ValueFilter( =, 'binaryprefix:value2' )\"} " | hbase shell |awk '{print $1 " | | " $4}'

echo "scan 'tableName', { COLUMNS => 'cf:cq1', FILTER => \"ValueFilter( =, 'binaryprefix:value1' )\"} " | hbase shell |grep value2 |awk '{print $1}'

echo "scan 'tableName',{FILTER => \"MultipleColumnPrefixFilter('cq1','cq2')\"}" | hbase shell

echo "scan 'tableName',{FILTER => \"MultipleColumnPrefixFilter('cq1','cq2')\"}" | hbase shell | grep -e value=value1 -e value2

scan 'tableName', {FILTER => "SingleColumnValueFilter('cf','cq1',=,'regexstring:value1') AND SingleColumnValueFilter('cf','cq2',=, 'regexstring:value2' )"}  
scan 'tableName', {FILTER => "MultipleColumnPrefixFilter('cq1', 'cq2') AND SingleColumnValueFilter('cf','cq1',=,'regexstring:value1') AND SingleColumnValueFilter('cf','cq2',=, 'regexstring:value2' )"}  

echo "scan 'tableName'" | hbase shell 
cf:cq2
echo "get 'tableName',{DependentColumnFilter('cf','cq1')}" | hbase shell

echo "scan 'tableName', {FILTER => \"(SingleColumnValueFilter('cf','cq1',=,'regexstring:value1',true,true)) AND (SingleColumnValueFilter('cf','cq2',=,'binary:value2',true,true))\"}" | hbase shell
