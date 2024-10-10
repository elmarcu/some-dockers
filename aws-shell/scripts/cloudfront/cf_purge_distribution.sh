#!/bin/sh

LAST_DISTRIBUTION_ID=$(aws cloudfront list-distributions --output json | jq -r '.DistributionList.Items | max_by(.LastModifiedTime) | .Id')
aws cloudfront create-invalidation --distribution-id $LAST_DISTRIBUTION_ID --paths "/*"

MOST_RECENT_INVALIDATION=$(aws cloudfront list-invalidations --distribution-id $LAST_DISTRIBUTION_ID --output json | jq -r '.InvalidationList.Items | max_by(.CreateTime)')

INVALIDATION_ID=$(echo $MOST_RECENT_INVALIDATION | jq -r '.Id')
INVALIDATION_STATUS=$(echo $MOST_RECENT_INVALIDATION | jq -r '.Status')

echo "Most Recent Invalidation ID: $INVALIDATION_ID"
echo "Status: $INVALIDATION_STATUS"
