Start Zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties

Start Broker
bin/kafka-server-start.sh config/server.properties

Topic Creation
bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic test --replication-factor 1 --partitions 1 
To get details of the topic 
bin/kafka-topics.sh --zookeeper localhost:2181 --describe --topic test 

By default we cannot delete the topic.To delete the topic in dev environment we need to set 
	delete.topic.enable = true.

By default auto create topic is true but to get a more controlled approach we need to set this to false and create the topic name manually
	 auto.create.topics.enable = false 

List Topic(To check available topics)
bin/kafka-topics.sh --list --zookeeper localhost:2181

Start Producer
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test 

Start Consumer
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
  //  bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning

  ----------------------------------------------------------------------------------------------------

Message is a array of bytes.
To start different kafka broker on same node make a copy of broker config file becaus we cant start multiple brokers with same properties(same broker config file)  bin/kafka-server-start.sh config/server.properties
broker.id=0;   (brokerPort)listerners=PLAINTEXT://:9092; (brokerLogDir) log.dirs=/tmp/kafka-logs

isr= inSyncReplica
delete.topic.enable --  By default topic deletion is not allowed
auto.create.topics.enable  -- In Prod this option is set to false
default.replication.factor = 1
num.partations = 1
log.retention.ms -- By default the value is 7 days
log.retention.bytes --This size applies to partations, if we can set the value to 1gb.When partation size reached 1gb kafka starts cleanup activity.


import java.util.*;
import org.apache.kafka.clients.producer.*;
public class SimpleProducer {
  
   public static void main(String[] args) throws Exception{
           
      String topicName = "SimpleProducerTopic";
	  String key = "Key1";
	  String value = "Value-1";
	  //////For Kafka message is just an Array of bytes.
we are sending string key and string value but kafka acceps only array of bytes.so, we need a class to convert string to array of bytes.
The activity of converting java object into an array of bytes is called serlization. 
      
      Properties props = new Properties();
      props.put("bootstrap.servers", "localhost:9092,localhost:9093");
      props.put("key.serializer","org.apache.kafka.common.serialization.StringSerializer");         
      props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
	        
      Producer<String, String> producer = new KafkaProducer <>(props);
	
	  ProducerRecord<String, String> record = new ProducerRecord<>(topicName,key,value);
	  ////(or) ProducerRecord<String, String> record = new ProducerRecord<>(topicName, Integer partation, Long timestamp, key, value);

	  producer.send(record);	       
      producer.close();
	  
	  System.out.println("SimpleProducer Completed.");
   }
}

<<< <Producer API>>>
create a Producer object{Properties}-- bootstrap.servers
create a ProducerRecord object --Topicname,PartitionNo,Timestamp,Key,Value
send record to Producer- producer.Send(record){Method}.
<<< Three approaches to send a message to Kafka>>>
Fire and Forget - send and forget
Synchronous send - send and wait for a acknowledgement success. In the case of success we get record metadata object.In the case of failure we get an exception.
But this approach will slow you down, it will limit your throughput because you are waiing for every message to get an acknowledgement.
Asynchronous Send -
 max.in.flight.requests.per.connection By default it is 5 messages per sec ( First you send 5 records and it fails and next five records will be success. After 5 sec it retries for first five records and it will success.But we will loose the order as we received first 6-10 records and then 1-5 records)

<<<Producer Config>>>
ack = 0 (or) 1(or) all
ack = 0 send's message to kafka cluster and forget, will not wait for response from leader and no retries. Highthroughput but may chance of losing a mesages.
ack = 1 send's messsage to cluster and wait but there is a thin chance of losing message.What happens if the leader fails before replicating to other.
ack = all (High reliability and high latency)

retries by default is 0 though we get an exception.
retry.backof.ms controls the time between two retries.Default value is 100ms.

max.in.flight.requests.per.connection By default it is 5 messages per sec




<<<Default Partitioner:>>>
1.If a partitioner is specified in the record, use it.
2.If no partition is specified but key is present choose a partation based on a hash of the key.
3.If no partition or key is present choose a partition in  round-robin fashion.
 

 Custom Partitioner
 Custom Searializer


Custom serializers:
Use generic Serializers instead of creating custom serializers and de-serailizers.Generic serilizers like Avro and protocal buffer.Most of the times we use Avro

<<<Consumer Group>>>
One of the kafka broker elected as a group Coordinator which coordinates the consumer group
Coordinator initiates the rebalance activity if something happens in the consumer group and during the rebalance activity none of the consumers are allowd to read.

<<<Offset>>>
Current offset(sent records) - Is used to avoid resending the same recored again to same consumer
Committed offset(Processed records) - It is used to avoid the resending the same records to the new consumer in the event of partitioning rebalancing.

Types of commit - Auto Commit, Manual Commit (Poll calls)
Auto Commit
	enable.auto.commit by default it is true. Set it to false
	auto.commit.interval.ms the default value is 5sec
Manual Commit.
	Commit sync
	commit Async

ConsumerRebalanceListner
	onPartationsRevoked - is used for commiting the offset and during the rebalancing of the consumer group
	onPartationsAssigned

<<<Kafka consumer>>>

<<<KafkaAvroSerializer&DeSerializer>>>
