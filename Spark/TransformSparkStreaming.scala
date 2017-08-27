package com.avula


import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.streaming.StreamingContext._


object TransformSparkStreaming {
  
  def main(args : Array[String]) {
  
  val ssc = new StreamingContext("local[2]", "Statefulwordcount", Seconds(10))
  
  
    // From File  
    val myFile = ssc.sparkContext.textFile("/home/avula/Work/Inputs/SparkInputs/wordls.txt")
    val wordspair =myFile.flatMap(row =>row.split(" ")).map(x=>(x,1)).reduceByKey(_+_)
    
    println(wordspair)
      
    val oldwordCount=wordspair.reduceByKey(_+_)
    
    println(oldwordCount)
    
    
    
    // From Socket
    val lines = ssc.socketTextStream("10.0.2.15", 9999)    
    val words = lines.flatMap(_.split(" "))
    val pairs = words.map(word => (word, 1))
    val wordCounts = pairs.reduceByKey(_ + _)
    
     //val joinref = oldwordCount.join(wordCounts);   // We can't do this
    
    // Joining Both Data
    val joinRDD =  wordCounts.transform(rdd=>{
      rdd.join(wordspair).map{
        case(word,(oldCount,newCount))=>{
          (word,oldCount+newCount)
        }
      }
    })
    joinRDD.print()
    ssc.start()
    ssc.awaitTermination()
  
    
  }
  
}