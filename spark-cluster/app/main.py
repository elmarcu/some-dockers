import requests
import time
import subprocess
import os
from pyspark.sql import SparkSession

# Create a Spark session
spark = SparkSession.builder.appName("MyApp").getOrCreate()

# Set log level
spark.sparkContext.setLogLevel("INFO")

# Set up logging
logger = spark._jvm.org.apache.log4j.LogManager.getLogger("main")

def get_alive_workers(spark_master_url):
    try:
        # Make a GET request to the Spark master REST API
        response = requests.get(f"{spark_master_url}/json")
        response.raise_for_status()  # Raise an exception for any HTTP errors
        data = response.json()  # Parse the JSON response
        logger.info(f"Response from Spark master: {data}")
        logger.info(f"Alive workers: {data.get('aliveworkers', 0)}")
        # Extract the number of alive workers
        alive_workers = data.get('aliveworkers', 0)  # Default to 0 if not found
        return alive_workers
    except requests.exceptions.RequestException as e:
        logger.error(f"Error querying Spark master: {e}")
        return 0

def wait_for_workers(spark_master_url, expected_workers, retries=10, delay=5):
    for _ in range(retries):
        alive_workers = get_alive_workers(spark_master_url)
        logger.info(f"Currently, {alive_workers} alive workers.")
        if alive_workers >= expected_workers:
            logger.info(f"All {expected_workers} workers are alive and registered.")
            return True
        time.sleep(delay)
    logger.info(f"Timeout reached. Only {alive_workers} workers are alive.")
    return False

def submit_spark_job():
    spark = SparkSession.builder \
        .appName("CSV Processor Cluster") \
        .getOrCreate()

    df = spark.read.csv("data/people.csv", header=True, inferSchema=True)

    logger.info("Original Data:")
    df.show()

    adults = df.filter(df.age > 30)

    logger.info("People older than 30:")
    adults.show()

    spark.stop()

# Main logic
if __name__ == "__main__":
    spark_master_url = os.environ['SPARK_MASTER_URL']
    expected_workers = int(os.getenv("EXPECTED_WORKERS", "2"))
    logger.info(f"Expected workers: {expected_workers}")
    logger.info(f"Spark master URL: {spark_master_url}")
    logger.info("Waiting for workers to be alive...")

    if wait_for_workers(spark_master_url, expected_workers):
        submit_spark_job()
    else:
        logger.error("Error: Not enough workers available.")
