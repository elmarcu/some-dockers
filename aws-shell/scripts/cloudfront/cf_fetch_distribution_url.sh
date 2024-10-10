#!/bin/sh

LAST_DISTRIBUTION_ID=$(aws cloudfront list-distributions --output json | jq -r '.DistributionList.Items | max_by(.LastModifiedTime) | .Id')
DISTRIBUTION_INFO=$(aws cloudfront get-distribution --id $LAST_DISTRIBUTION_ID --output json)
CLOUDFRONT_DOMAIN=$(echo $DISTRIBUTION_INFO | jq -r '.Distribution.DomainName')

# Output the CloudFront domain
echo "CloudFront Domain: $CLOUDFRONT_DOMAIN"
