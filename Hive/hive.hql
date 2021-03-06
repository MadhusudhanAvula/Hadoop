   --showHeader=[true/false]       show column names in query results
   --headerInterval=ROWS;          the interval between which heades are displayed
   --fastConnect=[true/false]      skip building table/column list for tab-completion
   --autoCommit=[true/false]       enable/disable automatic transaction commit
   --verbose=[true/false]          show verbose error messages and debug info
   --showWarnings=[true/false]     display connection warnings
   --showNestedErrs=[true/false]   display nested errors
   --numberFormat=[pattern]        format numbers using DecimalFormat pattern
   --force=[true/false]            continue running script even after errors
   --maxWidth=MAXWIDTH             the maximum width of the terminal
   --maxColumnWidth=MAXCOLWIDTH    the maximum width to use when displaying columns
   --silent=[true/false]           be more silent
   --autosave=[true/false]         automatically save preferences
   --outputformat=[table/vertical/csv2/tsv2/dsv/csv/tsv]  format mode for result display
                                   Note that csv, and tsv are deprecated - use csv2, tsv2 inste

select pk_hash_key, count(*) from dbname.tabeName group by pk_hash_key having count(*) > 1;
select TX_ID,MBR_ID,PATIENT_DOB,STATUS,pk_hash_key, count(*) from dbname.tabeName group by pk_hash_key having count(*) > 1
select TX_ID,MBR_ID,PATIENT_DOB,STATUS,pk_hash_key, count(*) as du from dbname.tabeName group by pk_hash_key,TX_ID,MBR_ID,PATIENT_DOB,STATUS having count(*) > 1 order by du desc;

The standard way using SQL window function would be as follows:
SELECT
  student, class, score, rank
FROM (
  SELECT
    student, class, score,
    rank() over (PARTITION BY class ORDER BY score DESC) as rank
  FROM
    table
) t
WHERE rank <= 2
An alternative and efficient way to compute top-k items using each_top_k is as follows:

SELECT
  each_top_k(
    2, class, score,
    class, student -- output columns other in addition to rank and score
  ) as (rank, score, class, student)
FROM (
  SELECT * FROM table
  CLUSTER BY class -- Mandatory for `each_top_k`
) t
 `CLUSTER BY x` is a synonym of `DISTRIBUTE BY x CLASS SORT BY x` and required when using `each_top_k`.
 `each_top_k` is beneficial where the number of grouping keys are large. If the number of grouping keys are not so large (e.g., less than 100), consider using `rank() over` instead.
 
 
select * from (SELECT dcn AS ENTRPR_EDI_DCN_ID, CLM_NBR, src_sbscrbr_id as MBRSHP_ID, clm_adjstmnt_nbr,TRIM(CLM_SOR_CD) AS CLM_SOR_CD, BDF_SCRTY_LVL_CD, BDF_EXTRNL_LOAD_CD, GUID, BDF_SOR_CD,BDF_LOAD_LOG_KEY AS PREV_ZONE_BDF_LOAD_LOG_KEY,ROW_NUMBER() OVER(PARTITION BY dcn,clm_nbr  order by clm_adjstmnt_nbr desc ) as rnk from db_name.tableName)q where q.rnk='1'

select count(*) from
( select rcrd_agrgtr_id as a, rcrd_type_cd, rcrd_type_qlfr_cd from clm_edw_edi_463a_clm_prov group by rcrd_agrgtr_id, rcrd_type_cd, rcrd_type_qlfr_cd ) x

select count(*) from  db_name.tableName a where a.load_dtm in ( select max(load_dtm) from db_name.tableName)

select ar.PROV_STTS_KEY,ar.PROV_STTS_EFCTV_DT,ar.PROV_STTS_CD,ar.PROV_STTS_TRMNTN_DT,ar.PROV_STTS_TRMNTN_RSN_CD from dbName.prov_sps_prov_mstr lateral view explode(prov_stts_aray_txt) arr as ar

select * from
 (select mbr.mbr_key, Count (mbr.mbr_key)  nbr, ml.lang_cd from  EDW_ALLPHI.mbr mbr  left outer join edw_nophi.mbr_lang ml  on mbr.mbr_key = ml.mbr_key  group by mbr.mbr_key,ml.lang_cd) as p
 where p.nbr <>1

SELECT pgm_desc ,(CASE WHEN prscrbr_npi IS NULL THEN 'NULL' ELSE 'Valid' END) AS prscrbr_npi_value, COUNT(*) FROM db_name.tableName GROUP BY pgm_desc, (CASE WHEN prscrbr_npi IS NULL THEN 'NULL' ELSE 'Valid' END ) ORDER BY 1,2;

select * from table1 where a=x 
union all 
select * from table2 where a!=x and b=y

##Left_anti

SELECT * FROM db_name.anti_test AS a WHERE NOT EXISTS ( SELECT 1 FROM db_name.anti_test1 AS b WHERE  a.name = b.name );
>>> spark.sql("SELECT  * FROM  mbr AS a WHERE  NOT EXISTS ( SELECT * FROM  app AS b WHERE  a.mcid = b.mcid )").count()
107751
##left_semi
>>> spark.sql("SELECT  * FROM  mbr AS a WHERE EXISTS ( SELECT * FROM  app AS b WHERE  a.mcid = b.mcid )").count()
2679

Sub Query:
with
  tbl
  as
  (
    select RCRD_AGRGTR_ID, GRP_RCVR_ID, CLM_SOR_CD, CASE WHEN CLM_SOR_CD='896' AND GRP_RCVR_ID = 'FEPVA'  THEN '888'
    WHEN CLM_SOR_CD='869' AND ( RCRD_AGRGTR_ID LIKE '4%' OR RCRD_AGRGTR_ID LIKE '7%' ) THEN '827'
    WHEN CLM_SOR_CD='999' OR CLM_SOR_CD= '869' THEN 'UNK'
    ELSE COALESCE(TRIM(CLM_SOR_CD),' ') END AS new_CLM_SOR_CD
    from db_name.tableName hdr
  )
select distinct(new_clm_sor_cd)
from tbl

#Drop tables starting with temp 
hive -e "show tables 'temp_*'" | xargs -I '{}' hive -e 'drop table {}'

##Convert String time/date to TIMESTAMP
select from_unixtime(unix_timestamp(clm_rcvd_dt ,'yyyyMMdd'), 'yyyy-MM-dd HH:mm:ss.S')
from db_name.table;

##Date to timestamp
spark.sql("SELECT from_unixtime(unix_timestamp(MEMM.BRTH_DT,'MM/dd/yyyy'), 'yyyy-MM-dd HH:mm:ss.SSS') from table").show(2,False)
