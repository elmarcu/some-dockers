
##Docker aws client shell

cmds -> general commands (S3, mediaconvert)

mediaconvert -> transcoding mp4 from a S3 bucket

cloudfront -> exposing output hls files from mediconvert to web

lambda -> fucntions to validate mediaconvert results

sns -> hook mediaconvert jobs to lambda validator

-----

docker-compose up
docker-compose exec aws-client bash
 > aws --help

#aws commands

aws configure

AWS Access Key ID [None]: {ACCESS_KEY}
AWS Secret Access Key [None]: {SECRET}
Default region name [None]: us-west-2
Default output format [None]: json"

(or from file $HOME/.aws/credentials)

#list buckets
aws s3 ls

#list directories
aws s3 ls [BUCKET_DEFAULT]

#copy file
aws s3 cp file.txt s3://[BUCKET_DEFAULT]/ --storage-class REDUCED_REDUNDANCY/STANDARD_IA

#make already existing key(file) public access
aws s3api put-object-acl --bucket [BUCKET_DEFAULT] --key [KEY/FILE] --acl public-read
#cheat para hacer public varios bucket_files
aws s3 cp s3://[BUCKET_DEFAULT]/[PATH] s3://[BUCKET_DEFAULT]/[PATH] --acl public-read

#Attempt sync without --delete option - nothing happens
aws s3 sync . s3://my-bucket/path

#Sync with deletion - object is deleted from bucket
aws s3 sync . s3://my-bucket/path --delete
delete: s3://my-bucket/path/MyFile1.txt

#Delete object from bucket
aws s3 rm s3://my-bucket/path/MySubdirectory/MyFile3.txt
delete: s3://my-bucket/path/MySubdirectory/MyFile3.txt

#Sync with deletion - local file is deleted
aws s3 sync s3://my-bucket/path . --delete
delete: MySubdirectory\MyFile3.txt

#Sync with Infrequent Access storage class
aws s3 sync . s3://[BUCKET_DEFAULT]/[PATH] --storage-class STANDARD_IA

#sync and public
aws s3 sync . s3://[BUCKET_DEFAULT]/[PATH] --acl public-read [--dryrun --include --exclude --delete]

#list distributions
aws cloudfront list-distributions

#cache invalidation
aws cloudfront create-invalidation --distribution-id $CDN_DISTRIBUTION_ID --paths "/*"
