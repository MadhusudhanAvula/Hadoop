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