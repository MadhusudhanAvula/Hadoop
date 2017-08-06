SFO
/usr/hdp/2.6.0.3-8/spark/bin/spark-shell --packages com.databricks:spark-csv_2.10:1.5.0
import org.apache.spark.sql.hive.HiveContext
val hc = new HiveContext(sc)
    
val fire = hc.read.format("com.databricks.spark.csv").option("header","true").option("inferSchema","true").load("/avula/Fire.csv")

import org.apache.spark.sql.types.{StructType, StructField, StringType, IntegerType, BooleanType}
import org.apache.spark.sql.Row
////val customSchema = StructType(Array(StructField("year",IntegerType,true),StructField("make",StringType,true),StructField("model",StringType,true),StructField("comment",StringType,true)))


val fireSchema = StructType(Array(StructField("CallNumber", IntegerType, true),
                     StructField("UnitID", StringType, true),
                     StructField("IncidentNumber", IntegerType, true),
                     StructField("CallType", StringType, true),                  
                     StructField("CallDate", StringType, true),       
                     StructField("WatchDate", StringType, true),       
                     StructField("ReceivedDtTm", StringType, true),       
                     StructField("EntryDtTm", StringType, true),       
                     StructField("DispatchDtTm", StringType, true),       
                     StructField("ResponseDtTm", StringType, true),       
                     StructField("OnSceneDtTm", StringType, true),       
                     StructField("TransportDtTm", StringType, true),                  
                     StructField("HospitalDtTm", StringType, true),       
                     StructField("CallFinalDisposition", StringType, true),       
                     StructField("AvailableDtTm", StringType, true),       
                     StructField("Address", StringType, true),       
                     StructField("City", StringType, true),       
                     StructField("ZipcodeofIncident", IntegerType, true),       
                     StructField("Battalion", StringType, true),                 
                     StructField("StationArea", StringType, true),       
                     StructField("Box", StringType, true),       
                     StructField("OriginalPriority", StringType, true),       
                     StructField("Priority", StringType, true),       
                     StructField("FinalPriority", IntegerType, true),       
                     StructField("ALSUnit", BooleanType, true),       
                     StructField("CallTypeGroup", StringType, true),
                     StructField("NumberofAlarms", IntegerType, true),
                     StructField("UnitType", StringType, true),
                     StructField("Unitsequenceincalldispatch", IntegerType, true),
                     StructField("FirePreventionDistrict", StringType, true),
                     StructField("SupervisorDistrict", StringType, true),
                     StructField("NeighborhoodDistrict", StringType, true),
                     StructField("Location", StringType, true),
                     StructField("RowID", StringType, true)))


val fire = hc.read.format("com.databricks.spark.csv").option("header","true").schema(fireSchema).load("/avula/Fire.csv")
fire.limit(5).show()
fire.columns
fire.count()
fire.select("CallType").show(5)


fire.select("CallType").distinct().show(100, false)

fire.select("CallType").groupBy("CallType").count().orderBy(desc("count")).show(100,false)

//import org.apache.spark.sql.functions._  (optional for unixTimeStamp)
//import org.apache.spark.sql.types._  (optional for UnixTimeStamp)
import org.apache.spark.sql.functions.unix_timestamp
///val res = df.select($"id", $"date", unix_timestamp($"date", "yyyy/MM/dd HH:mm:ss").cast(TimestampType).as("timestamp"), current_timestamp(), current_date())

/*val ts = unix_timestamp($"dts","MM/dd/yyyy HH:mm:ss").cast("timestamp")
  df.withColumn("ts", ts).show(2,false)*/
//val newDf = df.withColumn("D", when($"B".isNull or $"B" === "", 0).otherwise(1))

//val ts = unix_timestamp($"dts","MM/dd/yyyy HH:mm:ss").cast("timestamp")
//df.withColumn("ts", ts).show(2,false)
//val from_pattern1 = "MM/dd/yyyy"
//val to_pattern1 ="yyyy-MM-dd"
//val from_pattern2 ="MM/dd/yyyy hh:mm:ss aa"
//val to_pattern2 = "MM/dd/yyyy hh:mm:ss aa"

val sf = fire.withColumn("CallDateTS", unix_timestamp($"CallDate","MM/dd/yyyy").cast("timestamp")).drop($"CallDate").withColumn("WatchDateTS", (unix_timestamp($"WatchDate", "MM/dd/yyyy").cast("timestamp"))).drop($"WatchDate").withColumn("ReceivedDtTmTS", (unix_timestamp($"ReceivedDtTm", "MM/dd/yyyy hh:mm:ss aa").cast("timestamp"))) .drop($"ReceivedDtTm").withColumn("EntryDtTmTS", (unix_timestamp($"EntryDtTm", "MM/dd/yyyy hh:mm:ss aa").cast("timestamp"))).drop($"EntryDtTm").withColumn("DispatchDtTmTS", (unix_timestamp($"DispatchDtTm", "MM/dd/yyyy hh:mm:ss aa").cast("timestamp"))).drop($"DispatchDtTm").withColumn("ResponseDtTmTS", (unix_timestamp($"ResponseDtTm", "MM/dd/yyyy hh:mm:ss aa").cast("timestamp"))).drop($"ResponseDtTm").withColumn("OnSceneDtTmTS", (unix_timestamp($"OnSceneDtTm", "MM/dd/yyyy hh:mm:ss aa").cast("timestamp"))).drop($"OnSceneDtTm").withColumn("TransportDtTmTS", (unix_timestamp($"TransportDtTm", "MM/dd/yyyy hh:mm:ss aa").cast("timestamp"))).drop($"TransportDtTm").withColumn("HospitalDtTmTS", (unix_timestamp($"HospitalDtTm", "MM/dd/yyyy hh:mm:ss aa").cast("timestamp"))).drop($"HospitalDtTm").withColumn("AvailableDtTmTS", (unix_timestamp($"AvailableDtTm", "MM/dd/yyyy hh:mm:ss aa").cast("timestamp"))) .drop($"AvailableDtTm")  

sf.select(year($"CallDateTS")).distinct().orderBy("year(CallDateTS)").show()

sf.filter(year($"CallDateTS") === 2016).filter(dayofyear($"CallDateTS")>=180).filter(dayofyear($"CallDateTS")<=187).select(dayofyear($"CallDateTS")).distinct().orderBy("dayofyear(CallDateTS)").show()

sf.filter(year($"CallDateTS") === 2016).filter(dayofyear($"CallDateTS")>=180).filter(dayofyear($"CallDateTS")<=187).groupBy(dayofyear($"CallDateTS")).count().orderBy("dayofyear(CallDateTS)").show()

sf.rdd.getNumPartitions

sf.repartition(6).createOrReplaceTempView("sfv")
/*https://community.hortonworks.com/questions/44665/timestamptype-format-for-spark-dataframes.html
https://community.hortonworks.com/questions/97719/convert-string-column-into-date-timestamp-spark-da.html
https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3741049972324885/3696710289009770/4413065072037724/latest.html*/