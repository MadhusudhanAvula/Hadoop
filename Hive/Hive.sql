set fs.defaultFS; --> to check the namenode

array_type     can be accessed by using Index
map_type       can be accessed by using Key
struct_type    can be accessed by using .dot operator
show databases like 's.*'

load data local inpath '/path' into table tez;
insert overwrite local directory '/path' row format delimited fields terminated by ',' select * from tez;

set hive.metastore.warehouse.dir; --> to find the metastore directory
set hive.execuation.engine = tez; --> to change the execution engine

set hive.exec.dynamic.partition;
set hive.exec.dynamic.partition.mode; ==> nonstrict

ALTER TABLE tableName ADDPARTATION (dept='accounting');
MSCK REPAIR TABLE tableName;  if some partation columns are not visible when we do query.

By using below commands we can access sub directories recursively in Hive
hive> Set mapred.input.dir.recursive=true;
hive> Set hive.mapred.supports.subdirectories=true;

SET hive.execution.engine=tez;   http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.4.3/bk_performance_tuning/content/hive_perf_best_pract_config_tez.html

To delete and update table need to be created as ORC file format and tbel properties('Transaction' ='true')

Map Join - Files will be kept  in memory then it will get read (but nor recommed).

EXPLAIN:
EXPLAIN command that shows the execution plan for a query. The syntax for this statement is as follows:
EXPLAIN [EXTENDED|DEPENDENCY|AUTHORIZATION] query

The use of EXTENDED in the EXPLAIN statement produces extra information about the operators in the plan. This is typically physical information like file names.
The use of DEPENDENCY in the EXPLAIN statement produces extra information about the inputs in the plan. It shows various attributes for the inputs.
The use of AUTHORIZATION in the EXPLAIN statement shows all entities needed to be authorized to execute the query and authorization failures if any exist. 



CREATE DATABASE IF NOT EXISTS cards;
CREATE DATABASE IF NOT EXISTS retail_ods;
CREATE DATABASE retail_edw;
CREATE DATABASE retail_stage;
CREATE DATABASE IF NOT EXISTS pig_demo;

Hive DDL:
----------------------------
-- Create sample database
-- CREATE DATABASE IF NOT EXISTS cards;

CREATE TABLE deck_of_cards (
COLOR string,
SUIT string,
PIP string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

--Download deckofcards.txt from github repository www.github.com/dgadiraju/data
--mkdir -p ~/demo/data/cards
--copy file deckofcards.txt to ~/demo/data/cards
-- Load data from local file system into hive table (append to existing table)
LOAD DATA LOCAL INPATH '/root/demo/data/cards/deckofcards.txt' INTO TABLE deck_of_cards;

--Load data from HDFS into hive table (append data to existing table), file user /user/root/cards will be deleted
LOAD DATA INPATH '/user/root/cards/deckofcards.txt' INTO TABLE deck_of_cards;

-- Loads data from local file system (overwrite existing data)
LOAD DATA LOCAL INPATH '/root/demo/data/cards/deckofcards.txt' OVERWRITE INTO TABLE deck_of_cards;

CREATE EXTERNAL TABLE deck_of_cards_external (
COLOR string,
SUIT string,
PIP string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/apps/hive/warehouse/cards.db/deck_of_cards';

-- Create ods and edw database for retail_db@mysql
-- CREATE DATABASE IF NOT EXISTS retail_ods;
-- CREATE DATABASE retail_edw;
-- CREATE DATABASE retail_stage;

-- HDPCD - Define a Hive-managed table 
USE retail_stage;
CREATE TABLE orders_demo (
order_id int,
order_date string,
order_customer_id int,
order_status string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- HDPCD - Define a Hive external table
-- Download the data from github, unzip and copy deckofcards.txt 
-- Run on terminal on your PC/Mac to copy data to sandbox
-- scp ./Documents/Training/GoogleDrive/Training/data/cards/deckofcards.txt root@sandbox.hortonworks.com:~
-- On sandbox
hadoop fs -mkdir /user/root/cards
hadoop fs -put deckofcards.txt /user/root/cards
hadoop fs -ls /user/root/cards
-- launch hive by running "hive"
CREATE DATABASE IF NOT EXISTS cards;
USE cards;
CREATE EXTERNAL TABLE deck_of_cards_external
(color string,
suit string,
pip string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/user/root/cards';


-- Create ods tables (mostly they will follow same structure, except additional audit columns)
use retail_ods;
CREATE TABLE categories (
category_id int,
category_department_id int,
category_name string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

CREATE TABLE customers (
customer_id       int,
customer_fname    string,
customer_lname    string,
customer_email    string,
customer_password string,
customer_street   string,
customer_city     string,
customer_state    string,
customer_zipcode  string 
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

CREATE TABLE departments (
department_id int,
department_name string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

You can stop a partition form being queried by using the ENABLE OFFLINE clause with ALTER TABLE statement.

CREATE TABLE orders (
order_id int,
order_date string,
order_customer_id int,
order_status string
)
PARTITIONED BY (order_month string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

CREATE TABLE order_items (
order_item_id int,
order_item_order_id int,
order_item_order_date string,
order_item_product_id int,
order_item_quantity smallint,
order_item_subtotal float,
order_item_product_price float
)
PARTITIONED BY (order_month string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

In Hive, you can enable buckets by using the following command,
set.hive.enforce.bucketing=true;

CREATE TABLE orders_bucket (
order_id int,
order_date string,
order_customer_id int,
order_status string
)
CLUSTERED BY (order_id) INTO 16 BUCKETS
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

CREATE TABLE order_items_bucket (
order_item_id int,
order_item_order_id int,
order_item_order_date string,
order_item_product_id int,
order_item_quantity smallint,
order_item_subtotal float,
order_item_product_price float
)
CLUSTERED BY (order_item_order_id) INTO 16 BUCKETS
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

CREATE TABLE products (
product_id int, 
product_category_id int,
product_name string,
product_description string,
product_price float,
product_image string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

-- Create edw tables (following dimension model)
use retail_edw;
CREATE TABLE products_dimension (
product_id int,
product_name string,
product_description string,
product_price float,
product_category_name string,
product_department_name string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

CREATE TABLE order_fact (
order_item_order_id int,
order_item_order_date string,
order_item_product_id int,
order_item_quantity smallint,
order_item_subtotal float,
order_item_product_price float
)
PARTITIONED BY (product_category_department string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

-- Create external tables for retail_stage
use retail_stage;

CREATE EXTERNAL TABLE categories
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION 'hdfs:///apps/hive/warehouse/retail_stage.db/categories'
TBLPROPERTIES ('avro.schema.url'='hdfs://sandbox.hortonworks.com/user/root/retail_stage/sqoop_import_categories.avsc');

CREATE EXTERNAL TABLE customers
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION 'hdfs:///apps/hive/warehouse/retail_stage.db/customers'
TBLPROPERTIES ('avro.schema.url'='hdfs://sandbox.hortonworks.com/user/root/retail_stage/customers.avsc');

CREATE EXTERNAL TABLE departments
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION 'hdfs:///apps/hive/warehouse/retail_stage.db/departments'
TBLPROPERTIES ('avro.schema.url'='hdfs://sandbox.hortonworks.com/user/root/retail_stage/departments.avsc');

CREATE EXTERNAL TABLE orders
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION 'hdfs:///apps/hive/warehouse/retail_stage.db/orders'
TBLPROPERTIES ('avro.schema.url'='hdfs://sandbox.hortonworks.com/user/root/retail_stage/orders.avsc');

CREATE EXTERNAL TABLE order_items
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION 'hdfs:///apps/hive/warehouse/retail_stage.db/order_items'
TBLPROPERTIES ('avro.schema.url'='hdfs://sandbox.hortonworks.com/user/root/retail_stage/order_items.avsc');

CREATE EXTERNAL TABLE products
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION 'hdfs:///apps/hive/warehouse/retail_stage.db/products'
TBLPROPERTIES ('avro.schema.url'='hdfs://sandbox.hortonworks.com/user/root/retail_stage/products.avsc');

CREATE TABLE departments_delta (
department_id int,
department_name string,
update_date string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

Hive Load:
-------------

########Copy data from MySQL to local file system
#Enable file_priv to retail_dba
mysql -u root -p #if password enabled, else "mysql -u root"
update mysql.user set file_priv = 'Y' where user = 'retail_dba';
commit;
exit;
#On OS prompt, run
service mysqld restart
mysql -u retail_dba -p #prompts for password and launches mysql CLI
use retail_db;
#Make sure you understand table structure, delimiter, partition etc, run mysql export command
select * from categories into outfile '/tmp/categories01.psv' fields terminated by '|' lines terminated by '\n';
select * from customers into outfile '/tmp/customers.psv' fields terminated by '|' lines terminated by '\n';
select * from departments into outfile '/tmp/departments.psv' fields terminated by '|' lines terminated by '\n';
select * from products into outfile '/tmp/products.psv' fields terminated by '|' lines terminated by '\n';
#We cannot use orders and order_items directly as tables in hive database retail_ods are partitioned

########Load data from local file system to hive table
load data local inpath '/tmp/categories01.psv' overwrite into table categories;
load data local inpath '/tmp/customers.psv' overwrite into table customers;
load data local inpath '/tmp/departments.psv' overwrite into table departments;
load data local inpath '/tmp/products.psv' overwrite into table products;
#You can remove overwrite while appending data to underlying hive table

########Load data from HDFS to hive table
#Prepare HDFS stage directory
#On command prompt (if you login as root)
hadoop fs -mkdir /user/root/departments
hadoop fs -put /tmp/departments.psv /user/root/departments
hadoop fs -ls /user/root/departments
#Launch hive
hive
use retail_ods;
load data inpath '/user/root/departments/*' overwrite into table departments;
hadoop fs -ls /user/root/departments
#You will not find files

Hive Insert:
---------------
#Prepare orders on mysql database
#on mysql
select * from orders into outfile '/tmp/orders.psv' fields terminated by '|' lines terminated by '\n';

#Create orders_stage under hive database retail_stage
hive
use retail_stage;

CREATE TABLE orders_stage (
order_id int,
order_date string,
order_customer_id int,
order_status string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

load data local inpath '/tmp/orders.psv' overwrite into table orders_stage;

insert overwrite table retail_ods.orders partition (order_month)
select order_id, order_date, order_customer_id, order_status,
substr(order_date, 1, 7) order_month from retail_stage.orders_stage;

#Now we have 2 tables retail_stage.order_items and retail_stage.orders
#We need to join these 2 and populate retail_ods.order_items table which have additional columns
#order_item_order_date and order_month
#Also table is partitioned by order_month
insert overwrite table order_items partition (order_month)
select oi.order_item_id, oi.order_item_order_id, o.order_date,
oi.order_item_product_id, oi.order_item_quantity, oi.order_item_subtotal,
oi.order_item_product_price, substr(o.order_date, 1, 7)
order_month from retail_stage.order_items oi join retail_stage.orders_stage o
on oi.order_item_order_id = o.order_id;

Hive SQL:
-----------------
-- Using all HiveQL/SQL clauses
-- Get number of orders by order_status for a given date '2013-12-14'
SELECT order_status, count(1) FROM orders
WHERE order_date = '2013-12-14 00:00:00.0'
GROUP BY order_status
ORDER BY order_status;

-- Get number of completed orders for each date before '2013-12-14 00:00:00.0'
SELECT order_date, count(1) FROM orders
WHERE order_date <= '2013-12-14 00:00:00.0' AND order_status = 'COMPLETE'
GROUP BY order_date
ORDER BY order_date;

-- Get number of pending, review and onhold order for each date for the month of 2013 December
SELECT order_date, count(1) FROM orders
WHERE order_date LIKE '2013-12%' AND order_status IN ('PENDING', 'PENDING_PAYMENT', 'PAYMENT_REVIEW', 'ON_HOLD')
-- order_date LIKE '2013-12%' AND (order_status = 'PENDING' or order_status = 'PENDING_PAYMENT'....)
GROUP BY order_date
ORDER BY order_date;

--Incorrect query
SELECT order_date, count(1) FROM orders
WHERE order_date BETWEEN '2013-12-01 00:00:00.0' AND '2013-12-31 00:00:00.0'
AND order_status LIKE 'PENDING%' OR order_status IN ('PAYMENT_REVIEW', 'ON_HOLD')
GROUP BY order_date
ORDER BY order_date;

--Correct alternative query
SELECT order_date, count(1) FROM orders
WHERE order_date BETWEEN '2013-12-01 00:00:00.0' AND '2013-12-31 00:00:00.0'
AND (order_status LIKE 'PENDING%' OR order_status IN ('PAYMENT_REVIEW', 'ON_HOLD'))
GROUP BY order_date
ORDER BY order_date;

Hive Transactions:
-------------------
-- Creating database (if not exists)
CREATE DATABASE IF NOT EXISTS hive_demo;

-- set hive.txn.manager by default it uses DummyTxnManager
set hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;

-- Also make sure these properties are set
--    hive.support.concurrency – true
--    hive.enforce.bucketing – true (Not required as of Hive 2.0)
--    hive.exec.dynamic.partition.mode – nonstrict
--    hive.compactor.initiator.on – true (for exactly one instance of the Thrift metastore service)
--    hive.compactor.worker.threads – a positive number on at least one instance of the Thrift metastore service

-- Creating table
-- Make sure table is bucketed, file format is orc and 
-- transactional is set to true under tblproperties
create table hive_transactions (i int, j string)
clustered by (i) into 4 buckets
stored as orc
tblproperties ('transactional'='true');

-- Inserting data
insert into table hive_transactions values (1, 'Avula');
insert into table hive_transactions values (2, 'Avula');

--or insert into table hive_transactions (i, j) values (1, 'Avula');

-- Updating data
update hive_transactions set j = 'IT Versity' where i = 2;

-- Deleting data
delete hive_transactions where i = 1;

Hive Denormalize:
---------------------
select d.department_name, substr(o.order_date, 1, 7) month, 
sum(oi.order_item_subtotal) monthly_revenue
from orders o join order_items oi on oi.order_item_order_id = o.order_id
join products p on oi.order_item_product_id = p.product_id
join categories c on p.product_category_id = c.category_id
join departments d on c.category_department_id = d.department_id
where o.order_date like '2013%'
group by d.department_name, substr(o.order_date, 1, 7);

create table retail_denormalized 
row format delimited fields terminated by '|'
as
select d.*, oi.*, o.order_date 
from orders o join order_items oi on oi.order_item_order_id = o.order_id
join products p on oi.order_item_product_id = p.product_id
join categories c on p.product_category_id = c.category_id
join departments d on c.category_department_id = d.department_id;

select department_name, substr(order_date, 1, 7) order_month, sum(order_item_subtotal) monthly_revenue 
from retail_denormalized where order_date like '2013%'
group by department_name, substr(order_date, 1, 7);

Hive Partitioning:
------------------------
-- Creating partitioned table
CREATE TABLE orders_partitioned_static (
  order_id int,
  order_date string,
  order_customer_id int,
  order_status string
)
PARTITIONED BY (order_month string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

-- Adding static partitions
alter table orders_partitioned_static add partition (order_month='2014-01');

-- Copying data into static partition
-- Load command works when the files being copied only have data with order_date from 2014-01
-- Using insert command
insert into table orders_partitioned_static partition (order_month='2014-01')
select * from orders where order_date like '2014-01%';


CREATE TABLE orders_partitioned_dynamic_nonstrict (
  order_id int,
  order_date string,
  order_customer_id int,
  order_status string
)
PARTITIONED BY (order_month string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

-- Make sure hive execution engine is pointing to mr (for Cloudera certifications)
set hive.execution.engine=mr;

-- Validate partition parameters
hive.exec.dynamic.partition=true
hive.exec.dynamic.partition.mode=nostrict

-- If hive.exec.dynamic.partition.mode nonstrict, no need to add any partitions
-- Use insert command to copy data from source table orders
insert into table orders_partitioned_dynamic_nonstrict partition (order_month)
select o.*, substr(order_date, 1, 7) order_month from orders o;

CREATE TABLE orders_partitioned_dynamic_strict (
  order_id int,
  order_date string,
  order_customer_id int,
  order_status string
)
PARTITIONED BY (order_year string, order_month string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

-- Make sure hive execution engine is pointing to mr (for Cloudera certifications)
set hive.execution.engine=mr;

-- Validate partition parameters
hive.exec.dynamic.partition=true
hive.exec.dynamic.partition.mode=strict

-- If hive.exec.dynamic.partition.mode strict we need to have static partition for parent
alter table orders_partitioned_dynamic_strict 
  add partition (order_year='2013', order_month='01')
      partition (order_year='2014', order_month='01');

-- If hive.exec.dynamic.partition.mode nostrict, no need to add any partitions
-- Use insert command to copy data from source table orders
insert into table orders_partitioned_dynamic_strict partition (order_year='2014', order_month)
select o.*, substr(order_date, 6, 2) order_month from orders o where order_date like '2014%';

insert into table orders_partitioned_dynamic_strict partition (order_year='2013', order_month)
select o.*, substr(order_date, 6, 2) order_month from orders o where order_date like '2013%';