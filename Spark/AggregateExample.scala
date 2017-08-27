package com.avula



import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object AggregateExample {
  
  
  def main(args : Array[String]){
    
    val conf = new SparkConf().setAppName("Aggregate Example").setMaster("local[2]").set("spark.executor.memory", "1g")
    val sc = new SparkContext(conf)
    val input = sc.parallelize(List(1, 2, 3, 4, 5))

    val result = input.aggregate((0, 0))(
               (acc, value) => (acc._1 + value, acc._2 + 1),
               (acc1, acc2) => (acc1._1 + acc2._1, acc1._2 + acc2._2))
               
   // val avg = result._1/result._2.toDouble
    println(result)
   // println(avg)
}   
}

/*
Partition = 1
1,2,3
0 + 1 = 1 + 2 = 3 + 3 = 6 
0+1 = 1 +  1 = 2 + 1 = 3 

(6,3)

Parition = 2
4,5

0 + 4 = 4 + 5 = 9
0 +1 = 1 + 1 = 2

(9,2)




(6 + 9) = 15

(3 + 2 ) = 5



*/