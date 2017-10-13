#!/bin/bash

path="/dv/hdfs/inbound/hql_scripts"
JDBC_URL="jdbc:hive2://avula1.com:2181,avula2.com:2181,avula3.com:2181/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2"
dbName_wh="avula_wh"
dbName_in="avula_in"

declare -a arr=("grpg_note")
for i in "${arr[@]}"
do
echo ${i}
        logFile=/home/userID/hive_logs/Inbound_Warehouse_${i}_`date +"%Y-%m-%d-%H:%M:%S"`.log
        pathScripts="/home/userID/hive_scripts"
        file=${pathScripts}/${i}.tbl.sh
        read=$(cat ${file})
        echo ${read}
    echo "Executing " $i
    hiveql="INSERT INTO TABLE ${dbName_wh}.${i} partition(load_time_stamp_p)
    SELECT ${read},
       unix_timestamp() AS LOAD_DTM,
       'I' AS TRANS_CODE,
       'GUIDAVULAGUID' AS GUID,
       from_unixtime(unix_timestamp()) AS INGSTN_ID,
       'provPkHash' AS SOURCE_CODE,
       load_time_stamp_p
    FROM ${dbName_in}.${i};" 2>&1  #| tee -a ${logFile}
    beeline -u  "${JDBC_URL}" -e "set hive.exec.dynamic.partition.mode=nonstrict; ${hiveql}" 2>&1
    if [ $? -eq 0 ]; then
        echo "Executed Successfully" # | tee -a ${logFile}
    else
        echo "Execuation Failed"  #| tee -a ${logFile}
        exit 1
    fi
    echo "Done executing " $i
touch ${logFile}
#> ${logFile} 2>&1
echo "----------------------------------------------------------------------------" #| tee -a ${logFile}
echo "----------------------------------------------------------------------------" #| tee -a ${logFile}
done
~
