from pyspark.sql.functions import udf, split, explode, col, sum, desc
from pyspark.sql.window import Window
from datetime import date

from app.utils import utils


class search_performance(object):
    def __init__(self, spark, input_path, output_path):
        # "/Users/mavula/Downloads/data.sql"
        df = spark.read.options(header='True', delimiter='\t') \
            .csv(input_path).select("referrer", "product_list", "event_list")

        domain = udf(lambda z: utils.get_domain(z))

        df = df.filter((df.event_list == "1") & (df.product_list != "null")) \
            .withColumn("search_engine_domain", domain(df.referrer)) \
            .withColumn("product_list", explode(split(df.product_list, ",")))

        df = df.withColumn("revenue", split(df.product_list, ";").getItem(3).cast('int')) \
            .withColumn("search_keyword", split(df.product_list, ";").getItem(1)) \
            .select("search_engine_domain", "revenue", "search_keyword")

        df = df.withColumn("revenue", sum(col("revenue")).over(Window.partitionBy("search_engine_domain"))) \
            .withColumn("search_keyword", split(df.search_keyword, "-").getItem(0)).orderBy(desc("revenue"))

        df.show(10, False)
        today = date.today()
        print("output file name::: {}/{}__SearchKeywordPerformance.tab".format(output_path, today))
        df.write.options(header='True', delimiter='\t').csv(
            "{}/{}__SearchKeywordPerformance.tab".format(output_path, today))
