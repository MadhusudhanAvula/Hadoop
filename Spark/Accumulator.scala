package com.avula

import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object Accumulator {
  
  def main(args : Array[String]) {

    val conf = new SparkConf().setAppName("AggrAccumulator Example").setMaster("local[2]").set("spark.executor.memory", "1g")
    val sc = new SparkContext(conf)
    
    val ac = sc.accumulator(0)
    val words = sc.textFile("/home/Avula/Work/Inputs/SparkInputs/wordls.txt").flatMap(_.split("\\W+"))
    words.foreach(w => ac += 1 )
    println(ac.value)  
    
  }
  
}