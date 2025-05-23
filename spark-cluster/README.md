# 🧪 Apache Spark Cluster Tutorial (Docker Compose)

This project sets up a simple **Apache Spark cluster** locally using Docker Compose, then runs a basic **PySpark** job to process a CSV file.

Perfect for experimenting with Spark in a clustered setup — no cloud or complex installation needed.

Run the cluster
```
docker-compose up -d && docker-compose logs spark-submit
```

This will:
Start 1 Spark master and 2 Spark workers
Submit and run the PySpark job via a spark-submit container


Spark UI
Access the Spark master UI at:
http://localhost:8080
You’ll see the running job and worker nodes.

--

PySpark Job Overview

The job (main.py) does the following:
Loads a CSV file (people.csv)

Filters rows where age > 30

Displays the result using show()