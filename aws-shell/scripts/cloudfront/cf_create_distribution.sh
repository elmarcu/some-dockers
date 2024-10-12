#!/bin/sh

DATE=$(date +%s)
sed -e "s|\${DATE}|$DATE|g" \
-e "s|\${BUCKET_OUTPUT}|$BUCKET_OUTPUT|g" \
/scripts/cloudfront/config.json > /scripts/cloudfront/config-filled.json    

# CloudFront distribution creation
aws cloudfront create-distribution \
--distribution-config file:///scripts/cloudfront/config-filled.json \
--output json > /scripts/cloudfront/output.json && echo "CloudFront distribution created!" && cat /scripts/cloudfront/output.json
