from pyspark.sql import SparkSession
import argparse

from search_performance import search_performance

def main():
    parser = argparse.ArgumentParser(description='My pyspark job arguments')
    parser.add_argument('--input_path', type=str, required=True, dest='input_path',
                        help='The name of the spark job you want to run')
    parser.add_argument('--output_path', type=str, required=False, dest='output_path',
                        help='Path to the jobs resurces')

    args = parser.parse_args()

    spark = SparkSession \
        .builder \
        .appName("search performance") \
        .getOrCreate()
    search_performance(spark, args.input_path, args.output_path)


if __name__ == "__main__":
    main()
