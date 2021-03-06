BlockSize(N) = batchInterval/blockInterval.
 The blocks generated during the batchInterval are partitions of the RDD. Each partition is a task in spark.

 batch processing time should be less than the batch interval.
A good approach to figure out the right batch size for your application is to test it with a conservative batch interval (say, 5-10 seconds) and a low data rate. 
To verify whether the system is able to keep up with the data rate, you can check the value of the end-to-end delay experienced by each processed batch (either look for “Total delay” in Spark driver log4j logs, or use the StreamingListener interface). 

An alternative to receiving data with multiple input streams / receivers is to explicitly repartition the input data stream (using inputStream.repartition(<number of partitions>)). This distributes the received batches of data across the specified number of machines in the cluster before further processing.

Processing Time - The time to process each batch of data.
Scheduling Delay - the time a batch waits in a queue for the processing of previous batches to finish.

CheckPoint
---------
sc.setCheckpointDir("/home/Avula/Spark6AM/checkpointdirname")

val a = sc.parallelize(Array(1,2,3,4,5,6,7,3,4,3,2,2), 2)

a.checkpoint

a.collect  

Untill and Action have triggered it have not stored an RDD 


sc.getCheckpointDir
res4: Option[String] = None

//scala> sc.setCheckpointDir("/home/Avula/Spark6AM/checkpointdirname")

//scala> sc.getCheckpointDir
res6: Option[String] = Some(hdfs://localhost:8020/home/Avula/Spark6AM/checkpointdirname/2433cb8d-e14e-436c-a85d-6ad3a7d992a3)


coalesce, repartition :
val a = sc.parallelize(Array(1,2,3,4,5,6,7,3,4,3,2,2), 20)
val b = a.coalesce(2)

val b = a.repartition(3)
-------------------------------------------------------------------------------------------------------------------
import org.apache.spark.SparkConf

//scala> val conf = new SparkConf().setMaster("local[*]").setAppName("KafkaReceiver")
conf: org.apache.spark.SparkConf = org.apache.spark.SparkConf@2f8bf5fc

//scala> import org.apache.spark.streaming.StreamingContext
import org.apache.spark.streaming.StreamingContext

//scala> import org.apache.spark.streaming.Seconds
import org.apache.spark.streaming.Seconds

//scala> val ssc = new StreamingContext(conf, Seconds(10))
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
15/07/21 09:08:39 INFO SparkContext: Running Spark version 1.4.1
...
ssc: org.apache.spark.streaming.StreamingContext = org.apache.spark.streaming.StreamingContext@2ce5cc3

//scala> import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.streaming.kafka.KafkaUtils

// Note the name of the topic iin use - spark-topic
scala> val kafkaStream = KafkaUtils.createStream(ssc, "localhost:2181","spark-streaming-consumer-group", Map("spark-topic" -> 5))
kafkaStream: org.apache.spark.streaming.dstream.ReceiverInputDStream[(String, String)] = org.apache.spark.streaming.kafka.KafkaInputDStream@4ab601ac

// The very complex BIG data analytics
scala> kafkaStream.print()

// Start the streaming context so Spark Streaming polls for messages
scala> ssc.start
15/07/21 09:11:31 INFO ReceiverTracker: ReceiverTracker started
15/07/21 09:11:31 INFO ForEachDStream: metadataCleanupDelay = -1
...
15/07/21 09:11:31 INFO StreamingContext: StreamingContext started
-----------------------------------------------------------------------------------------------------------------------------
Spark streaming

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.streaming._
import org.apache.spark.storage.StorageLevel

// nc -l 172.17.0.2 9999

object NetworkStream {

   def main(args : Array[String]){
      // SparkConf
   // val conf = new SparkConf().setAppName("SimpleApp").setMaster("local[2]").set("spark.executor.memory", "1g")
     val conf = new SparkConf().setAppName("SimpleApp")
       .set("spark.master", "yarn-client").set("spark.driver.host", "172.17.0.2").setMaster("spark://sandbox.hortonworks.com:9999")
       .set("spark.driver.host","sandbox")
       .set("spark.local.ip","127.0.0.1")
       .set("spark.driver.host","172.17.0.2");

    val ssc = new StreamingContext(conf, Seconds(10))
    
    val lines = ssc.socketTextStream("172.17.0.2", 9999, StorageLevel.MEMORY_AND_DISK)

    val wordpair = lines.flatMap(row => row.split(" ")).map(x => (x,1)).reduceByKey(_ + _).print();
    
    ssc.start();
    ssc.awaitTermination();
     
   }
}
----------------------------------------------------------------------------------------------------------------------

package com.simplespark

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.streaming._
import org.apache.spark.storage.StorageLevel

object StatefulWordCount {
  
  def main(args : Array[String]) {
    
    def updateFunction(values : Seq[Int], runningCount : Option[Int]) = {
      val newCount = values.sum + runningCount.getOrElse(0)
      new Some(newCount)
    }
    // SparkConf
    //val conf = new SparkConf().setAppName("SimpleApp").setMaster("local[2]").set("spark.executor.memory", "1g")
    
    val ssc = new StreamingContext("local[2]", "StatefulWordCount", Seconds(10));
    
    val lines = ssc.socketTextStream("10.0.2.15", 9999, StorageLevel.MEMORY_AND_DISK)
    
    ssc.checkpoint("/home/Avula/Work/Inputs/SparkInputs/streaming_checkpoint")
         
    val wordpair = lines.flatMap(row => row.split(" ")).map(x => (x,1)).reduceByKey(_ + _) 
    
    val totalWordCount = wordpair.updateStateByKey(updateFunction _)
    
    totalWordCount.print();
    
    ssc.start();
    ssc.awaitTermination();  
    
    // updateStateByKey(function)
  }
}


----------------------------------------------------------------------------------------------------------------------
package com.simplespark

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.streaming._
import org.apache.spark.storage.StorageLevel

object WIndowStatefulStream {

  def main(args: Array[String]) {

    val ssc = new StreamingContext("local[2]", "WindowStatefulStream", Seconds(10));

    val lines = ssc.socketTextStream("10.0.2.15", 9999, StorageLevel.MEMORY_AND_DISK)

    ssc.checkpoint("/home/Avula/Work/Inputs/SparkInputs/streaming_checkpoint")

    val wordPair = lines.flatMap(row => row.split(" ")).map(x => (x, 1)).reduceByKey(_ + _)
    
    wordPair.reduceByKeyAndWindow((x : Int,y : Int) => (x+y), Minutes(1), Seconds(20)).print()
    ssc.start();
    ssc.awaitTermination();

  }
}
----------------------------------------------------------------------------------------------------------------------
package com.simplespark

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.streaming._
import org.apache.spark.storage.StorageLevel

object FileStream {
  
  
     def main(args : Array[String]){
       
    // SparkConf
    val conf = new SparkConf().setAppName("SimpleApp").setMaster("local[2]").set("spark.executor.memory", "1g")
    
    val ssc = new StreamingContext(conf, Seconds(20));
    
    val lines = ssc.textFileStream("/home/Avula/Work/Inputs/SparkInputs/streaming_input")   
    
    val wordpair = lines.flatMap(row => row.split(" ")).map(x => (x,1)).reduceByKey(_ + _).print();
    
    ssc.start();
    ssc.awaitTermination();  
       
     }
  
}
-----------------------------------------------------------------------------------------------------------------------
package com.simplespark

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._

object SimpleApp {
  
  def main(args : Array[String]){
    
    // SparkConf
    val conf = new SparkConf().setAppName("SimpleApp").setMaster("local[2]").set("spark.executor.memory", "1g")
    val sc = new SparkContext(conf)
    
    
    val myFile = sc.textFile("/home/Avula/Work/Inputs/SparkInputs/wordls.txt")
    val wordpair = myFile.flatMap(row => row.split(" ")).map(x => (x,1)).reduceByKey(_ + _);
    
    wordpair.foreach(println);
    
  }
  
}
--------------------------------------------------------------------------------------------------------------------
import org.apache.spark.sql.functions._
val myDF = sqlContext.parquetFile("hdfs:/to/my/file.parquet")
val coder: (Int => String) = (arg: Int) => {if (arg < 100) "little" else "big"}
val sqlfunc = udf(coder)
myDF.withColumn("Code", sqlfunc(col("Amt")))
-------------------------------------------------------------------------------------------------------------------

val dataset = Seq((0, "hello"), (1, "world")).toDF("id", "text")

// Define a regular Scala function
val upper: String => String = _.toUpperCase

// Define a UDF that wraps the upper Scala function defined above
// You could also define the function in place, i.e. inside udf
// but separating Scala functions from Spark SQL's UDFs allows for easier testing
import org.apache.spark.sql.functions.udf
val upperUDF = udf(upper)

// Apply the UDF to change the source dataset
scala> dataset.withColumn("upper", upperUDF('text)).show
+---+-----+-----+
| id| text|upper|
+---+-----+-----+
|  0|hello|HELLO|
|  1|world|WORLD|
+---+-----+-----+
------------------------------------------------------------------------------------------------------------------