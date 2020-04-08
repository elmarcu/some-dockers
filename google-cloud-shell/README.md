
##Docker google cloud client shell

docker-compose up
docker-compose exec gcp-client bash
 > gcloud auth login
 > gcloud --help


 #LOGIN
 #web based login
 gcloud auth login

 #login keyfile
 gcloud auth activate-service-account --key-file [KEY_FILE]

 #list
 bq ls

 #https://cloud.google.com/bigquery/bq-command-line-tool

 #delete table -t for table -f for force
 bq rm -f -t [PROJECT_ID]:[DATASET].[TABLE]

 #copy table from one project and workspace to another
 bq cp [PROJECT_ID_1]:[DATASET].[TABLE] [PROJECT_ID_2]:[DATASET].[TABLE]


 #expiracion de tablas - por segundos
 bq update --expiration 3600 [PROJECT_ID]:[DATASET].[TABLE]
 bq update --default_table_expiration 3600 [TABLE]

 #create table
 bq mk --table --expiration [INTEGER] --description [DESCRIPTION] --label [KEY:VALUE, KEY:VALUE] [PROJECT_ID]:[DATASET].[TABLE] [SCHEMA]

 [SCHEMA] is an inline schema definition in the format [FIELD]:[DATA_TYPE],[FIELD]:[DATA_TYPE] or the path to the JSON schema file on your local machine.


 #rsync from dir to google storage
 gsutil rsync -n -dr -x "FILES|FILES" dir/ gs://bucket/subdir/

 #rsync between buckets
 gsutil -m rsync -rd gs://b1 gs://b2

 #A series of really specific regular expressions solves the problem:
 gsutil -m rsync -rdx '\..*|.*/\.[^/]*$|.*/\..*/.*$|_.*' . gs://my-bucket.com/path
 #Where the exclude pattern has 4 components separated by | characters.

 \..*        <- excludes .files and .directories in the current directory
 .*/\.[^/]*$ <- excludes .files in subdirectories
 .*/\..*/.*$ <- excludes .directories in subdirectories
 _.*         <- excludes _files and _directories



 ##public files
 gsutil -m acl set -R -a public-read gs://bucket
 gsutil defacl set public-read gs://bucket
