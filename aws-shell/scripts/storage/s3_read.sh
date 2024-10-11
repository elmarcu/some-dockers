#!/bin/sh

aws s3 ls s3://$BUCKET_INPUT/ --recursive
aws s3 ls s3://$BUCKET_OUTPUT/ --recursive
