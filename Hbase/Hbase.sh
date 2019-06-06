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

##How do we get the complete list of columns that exist in a column Family?  http://www.hadooptpoint.org/filters-in-hbase-shell/#codesyntax_12
#https://www.cloudera.com/documentation/enterprise/5-3-x/topics/admin_hbase_filtering.html
#https://intellipaat.com/tutorial/hbase-tutorial/client-api-advanced-features/
##https://www.cloudera.com/documentation/enterprise/5-12-x/topics/admin_hbase_import.html
# cacert /opt/confluent/confluent-3.3.0/secure/wellpoint-rootCA.pem 

The HBase filter will takes two additional optional boolean arguments, filterIfColumnMissing and setLatestVersionOnly.(true,true)
If the filterIfColumnMissing flag is set to true, the columns of the row will not be emitted if the specified column to check is not found in the row. The default value is false.
If the setLatestVersionOnly flag is set to false, it will test previous versions (timestamps) in addition to the most recent. The default value is true.

Hbase Filter:
echo "scan 'namespace:tableName', {FILTER => \"((SingleColumnValueFilter('cf','LOAD_STRT_DTM',>=, 'binary:2019-04-08 12:48:16.993',true,true)) AND (SingleColumnValueFilter('cf','LOAD_STRT_DTM',<,'binary:2019-04-09 14:43:57.753',true,true)) AND (SingleColumnValueFilter('cf','WORK_FLOW_NM',=,'binaryprefix:EDI_WDS_EDI_465A_SLN_B',true,true)) AND (SingleColumnValueFilter('cf','ZONE_CD',=,'regexstring:RAWZ',true,true)) AND (SingleColumnValueFilter('cf','SUBJ_AREA_NM',=,'regexstring:CLM',true,true)) AND (SingleColumnValueFilter('cf':'PBLSH_IND',=,'binary:Y',true,true)) AND (QualifierFilter (=, 'binary:LOAD_INGSTN_ID')))\"}" | hbase shell

hbase Filter to get the second row of same row key into single row:
echo -e "scan 'namespace:tableName',{COLUMNS => ['cf:PBLSH_IND','cf:WORK_FLOW_NM','cf:LOAD_INGSTN_ID'], FILTER => \"SingleColumnValueFilter('cf','WORK_FLOW_NM',=,'regexstring:.NASCO.CLM.MEDCHEAD.2',true,true) AND (SingleColumnValueFilter('cf':'PBLSH_IND',=,'binary:Y',true,true))\"}" | hbase shell -n | grep -e LOAD_INGSTN_ID -e WORK_FLOW_NM | awk '{print $1,$4}' | sed 's/value=//' |  sed "N;s/\n/ /" | awk '{print $1,$2,$4}

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
