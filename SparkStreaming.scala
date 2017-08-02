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
    
    ssc.checkpoint("/home/syedacademy/Work/Inputs/SparkInputs/streaming_checkpoint")
         
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

    ssc.checkpoint("/home/syedacademy/Work/Inputs/SparkInputs/streaming_checkpoint")

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
    
    val lines = ssc.textFileStream("/home/syedacademy/Work/Inputs/SparkInputs/streaming_input")   
    
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
    
    
    val myFile = sc.textFile("/home/syedacademy/Work/Inputs/SparkInputs/wordls.txt")
    val wordpair = myFile.flatMap(row => row.split(" ")).map(x => (x,1)).reduceByKey(_ + _);
    
    wordpair.foreach(println);
    
  }
  
}