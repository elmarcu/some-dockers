from pyspark.sql import SparkSession

# Create Spark session
spark = SparkSession.builder \
    .appName("CSV Processor") \
    .getOrCreate()

# Load CSV
df = spark.read.csv("data/people.csv", header=True, inferSchema=True)

# Show original data
print("Original Data:")
df.show()

# Transform: filter people over 30
adults = df.filter(df.age > 30)

print("People older than 30:")
adults.show()

# Stop Spark
spark.stop()
