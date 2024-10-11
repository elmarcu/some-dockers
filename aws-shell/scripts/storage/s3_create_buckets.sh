#!/bin/sh

aws s3api create-bucket --bucket $BUCKET_DEFAULT --region $AWS_DEFAULT_REGION --create-bucket-configuration LocationConstraint=$AWS_DEFAULT_REGION

aws s3api create-bucket --bucket $BUCKET_OUTPUT --region $AWS_DEFAULT_REGION --create-bucket-configuration LocationConstraint=$AWS_DEFAULT_REGION
