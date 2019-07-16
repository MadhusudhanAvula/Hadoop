#!/bin/env python
# -*- coding: utf-8 -*-
import logging
import os
from datetime import datetime,timedelta
import pandas
import itertools
import argparse
from pyspark import SparkContext
from pyspark.sql import SparkSession

## Assigning Input Arguements to variables
parser = argparse.ArgumentParser()
parser.add_argument("-s", required=True, help="SourceName | SOURCE NAME")
parser.add_argument("-r", required=False, help="RAWZTableName | SOURCE NAME")
parser.add_argument("-a", required=False, help="APPZTableName | SOURCE NAME")
# parser.add_argument("--operation", help="operation",\
# choices=["add","subtract","multiply"])
args = parser.parse_args()

## create logger with 'Module Name'
log = logging.getLogger(__name__)
log.setLevel(logging.INFO)
## create file handler which logs debug messages
#file_handler = logging.FileHandler('{}'.format(logpath))
#file_handler.setLevel(logging.INFO)
## create console handler with a higher log level(Display logs in console)
stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.INFO)
## create formatter and add it to the handlers
formatter = logging.Formatter('%(levelname)s - %(message)s')
#file_handler.setFormatter(formatter)
stream_handler.setFormatter(formatter)
## add the handlers to the logger
#log.addHandler(file_handler)
log.addHandler(stream_handler)

if "HADOOP_ENV" in os.environ and "RELEASE_VER" in os.environ:
    log.info("Exported variables from Bash profile")
    ENV = os.environ['HADOOP_ENV'].lower()
    RELEASE = os.environ['RELEASE_VER'].lower()
else:
    log.info("WARNING:: Unable to find HADOOP_ENV and RELEASE_VER variables in Bash Profile")
    abspath = os.path.dirname(os.path.abspath(__file__))
    realpath = os.path.dirname(os.path.realpath(__file__))
    log.info("abspath: {} \nrealpath: {} ".format(abspath,realpath))
    ENV = realpath.split("/")[3]
    log.info("{}".format(ENV))
    if ENV == 'dv':
        ENV = 'dv'; RELEASE = realpath.split("/")[11];
    elif ENV == 'ts':
        ENV = 'ts'; RELEASE = realpath.split("/")[11];
    elif ENV == 'pr':
        ENV = 'pr'; RELEASE = realpath.split("/")[11];
    else:
        ENV = 'dv'; RELEASE = 'r000';
    log.info("WARNING:: DO EXPORT HADOOP_ENV: {} AND RELEASE_VER: {} VARIAVLES".format(ENV,RELEASE))

#ENV = '{}'.format(args.e).lower()
#RELEASE = '{}'.format(args.r).lower()
log.info("INFO:: HADOOP_ENV: {} AND RELEASE_VER: {} VARIAVLES".format(ENV,RELEASE))
sc =SparkContext.getOrCreate()
log4jLogger = sc._jvm.org.apache.log4j
log = log4jLogger.LogManager.getLogger(__name__)
log.info("Finally getting logs from log4j!")
spark = SparkSession.builder.master("yarn").appName("{}".format('py_edi')).config("hive.support.concurrency","false").config("hive.exec.dynamic.partition.mode", "nonstrict").enableHiveSupport().getOrCreate()

start_time = datetime.now()
log_time = datetime.strftime(start_time, '%Y%m%d_%H%M%S')
log.info("BEGIN TIME: {}".format(log_time))
today = datetime.today().date()
d6 = today - timedelta(days=6);d5 = today - timedelta(days=5); d4 = today - timedelta(days=4); d3 = today - timedelta(days=3); d2 = today - timedelta(days=2); d1 = today - timedelta(days=1)#.replace("-", "")
lids="'{}','{}','{}','{}','{}','{}','{}'".format(today,d1,d2,d3,d4,d5,d6).replace("-", "")
sor_nm="{}".format(args.s)
tbls=['clm_edi_clm_hdr','clm_edi_clm_sln','clm_edi_clm_cob_sbscrbr','clm_edi_clm_prov','clm_edi_clm_sll_cob_lai','clm_edi_clm_sll_prov']
def pattern(tbl):
        switcher={
                'clm_edi_clm_hdr':'EDI_400A_CLM_HDR',
                'clm_edi_clm_sln':'EDI_465A_SLN_BSIN|EDI_465A_SLN_BSIS_DNTL|EDI_465A_SLN_BSIS_DNTL',
                'clm_edi_clm_cob_sbscrbr':'EDI_464A_COB_SBSCRBR',
                'clm_edi_clm_prov':'EDI_463A_CLM_PROV',
                'clm_edi_clm_sll_cob_lai':'EDI_465W_SLL_COB_LAI',
                'clm_edi_clm_sll_prov':'EDI_465T_SLL_PROV',
             }
        return switcher.get(tbl,"Invalid table")
#rawz_tbl="{}".format(args.r)
#appz_tbl="{}".format(args.a)
for tbl in tbls:
    table_nm=r"{}_EDI_400A_CLM_HDR".format(sor_nm)
    appz_tbl="{}".format(tbl)
    log.info("{} --> {}".format(appz_tbl,table_nm))
    hbasefile="/home/af51360/edi/agpfacets_hbase_2019-05-05_2019-05-20.tmp"
    df = pandas.read_csv('./nasco_hbase_driver.csv', sep='\t', names=('llks', 'count', 'file'))
    #pattern = '|'.join(mylist)
    df1=df[df['file'].apply(str).str.contains('{}'.format(pattern(tbl)))]
    #log.info(df)
    li=df1['llks'].values.tolist()
    log.info(li)
    #rawz_llks=tuple(list(itertools.chain.from_iterable(li)))
    rawz_llks=str(li).replace('[','(').replace(']',')')
    log.info(rawz_llks)
    pysql=spark.sql("select count(*) from {}_bdfedmzph_gbd_{}_wh.{} where clm_sor_cd='{}' and load_ingstn_id in ({}) and prev_zone_bdf_load_log_key in {}".format(ENV,RELEASE,appz_tbl,'824',lids,rawz_llks)).show()
    log.info("{}".format(pysql))
    #exec("{}".format(pysql))
#log.info("odf=spark.read.format("jdbc").option("url","jdbc:oracle:thin:@test33pr14-scan1:1525/TESTDBRF").option("DB","(select count(*) from clm_edi_clm_hdr where clm_sor_cd="{}".format(sor_nm) load_ingstn_id in ("{}".format(lids)) and prev_zone_bdf_load_log_key in {}.format(rawz_llks)t").option("user","AVULA").option("password","Avula007").option("driver","oracle.jdbc.driver.OracleDriver").option("fetchsize","10000").option("numPartitions",12).load()")



'''
with open(hbasefile) as myfile:
    for line in myfile:
        if line:
            print("{}".format(line))'''
