
# small golang wraper for fast search

Go Lang webserver to request and query elastic search for fast search
this ES is feed by a logstash that pull changes from a mysqlDB

components:

MySQL: Stores your data.
Logstash: Pulls data from MySQL and indexes it into Elasticsearch.
Elasticsearch: Provides fast search capabilities.
Golang: Queries Elasticsearch for rapid data retrieval.

download mysql connector
https://dev.mysql.com/downloads/connector/j/
and place the jar on root 
```
wget https://dev.mysql.com/downloads/file/?id=530070
unzip mysql-connector-j-9.0.0.zip
mv mysql-connector-j-9.0.0/mysql-connector-j-9.0.0.jar ./logstash/
rm -rf mysql-connector-j-9.0.0.zip mysql-connector-j-9.0.0
```

make the cronjob executable
```
chmod +x cronjob/insert_products.sh
```

go lang requirements
```
brew install go
which go
export PATH="/opt/homebrew/opt/go/bin:$PATH"
cd golang/
go mod init go-elastic-logstash-mysql
go get github.com/elastic/go-elasticsearch/v7
```

build and up
```
docker-compose up --build
```

test
```
curl http://localhost:8080/search?q=product
```
