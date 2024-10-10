#!/bin/sh

#Create and apply a Bucket Policy that grants public read access to all objects within the bucket.
sed -e "s|\${BUCKET_OUTPUT}|$BUCKET_OUTPUT|g" \
/scripts/storage/bucket-policy.json > /scripts/storage/bucket-policy-filled.json   
aws s3api put-bucket-policy --bucket $BUCKET_OUTPUT --policy file:///scripts/storage/bucket-policy-filled.json

#Allow Public Access to the Bucket
aws s3api put-public-access-block --bucket $BUCKET_OUTPUT --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false
#Set Bucket ACL to Public Read
aws s3api put-bucket-acl --bucket $BUCKET_OUTPUT --acl public-read
#Set ACL for All Existing Objects
aws s3 cp s3://$BUCKET_OUTPUT s3://$BUCKET_OUTPUT --recursive --acl public-read
