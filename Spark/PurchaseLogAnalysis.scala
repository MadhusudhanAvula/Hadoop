package com.avula

import org.apache.spark.{ SparkContext, SparkConf }
import org.apache.spark.rdd.RDD

object PurchaseLogAnalysis {
  def main(args: Array[String]): Unit = { 
    
      val conf = new SparkConf().setAppName("PurchaseAnalysisJob").setMaster("local[2]").set("spark.executor.memory", "1g")
      val ctx = new SparkContext(conf)
     
    val badPkts = ctx.accumulator(0, "Bad Packets")
		val zeroValueSales = ctx.accumulator(0, "Zero Value Sales")
		val missingFields = ctx.accumulator(0, "Missing Fields")
    val blankLines = ctx.accumulator(0, "Blank Lines")
    
    ctx.textFile("/home/avula/Work/Inputs/SparkInputs/purchases.log", 4)
    .foreach { line =>
            if (line.length() == 0) blankLines += 1
            else if (line.contains("Bad data packet")) badPkts += 1
            
            else {
					  val fields = line.split("\t")

					if (fields.length != 4) missingFields += 1
          else if (fields(3).toFloat == 0) zeroValueSales += 1
            
    }
  }
    
   /*   // 4 Executors
      missingFields
      1 --->   1
      2 --->   3
      3 ---->  0
      4 ---->  5
      
      1 + 3+ 0 + 5 = 9*/
      
      
    println("Purchase Log Analysis Counters:")
		println(s"\tBad Data Packets=${badPkts.value}")
		println(s"\tZero Value Sales=${zeroValueSales.value}")
		println(s"\tMissing Fields=${missingFields.value}")
    println(s"\tBlank Lines=${blankLines.value}")
    
    
  }
    
}