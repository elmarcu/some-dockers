#!/bin/sh

# Apply the CORS configuration to the bucket
aws s3api put-bucket-cors --bucket "$BUCKET_OUTPUT" --cors-configuration file://scripts/storage/cors-config.json && echo "CORS configuration applied to bucket: $BUCKET_OUTPUT"