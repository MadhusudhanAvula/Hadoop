'''change the numeric date to weekdays'''
import sys
import datetime
for line in sys.stdin:
	line = line.strip()
	userid, fName, lName, orderId, orderTime = line.split(",") 
	weekday = datetime.datetime.fromtimestamp(float(unixtime)).isoweekday()
	print ','.join {[userid, fName, lName,str(weekday)]}


'''In Hive shell:
create a new table but replace the old time column with new column name 
add python file to hive
	add file /atom/python/date.py;
 Insert override table newtable select transform(all_old_columns) using 'python data.py' as (all new_table_columns) from old_tabel;'''
 