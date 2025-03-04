#!/bin/sh

#sh /scripts/storage/s3_create_buckets.sh
#sh /scripts/storage/s3_transfer_file.sh
#sh /scripts/storage/s3_read.sh
#sh /scripts/storage/s3_cors.sh
#sh /scripts/storage/s3_make_public.sh

## lambda
# use other docker service to create the lambda function
# manual invoke
# aws lambda invoke --function-name $LAMBDA_FUNCTION_NAME --payload '{"jobId": "YOUR_JOB_ID"}' response.json

#sns
#sh /scripts/sns/sns_subscribe.sh
# sns manual invoke
# aws sns publish --topic-arn arn:aws:sns:your-region:your-account-id:YourSNSTopic --message "Test SNS message"

#cloudwatch
#sh scripts/cloudwatch/cw_create_event.sh

#sh /scripts/mediaconvert/mc_list_describe.sh
#sh /scripts/mediaconvert/mc_create_template.sh
#sh /scripts/mediaconvert/mc_create_job.sh

#sh /scripts/cloudfront/cf_create_distribution.sh
#sh /scripts/cloudfront/cf_fetch_distribution_url.sh
#sh /scripts/cloudfront/cf_purge_distribution.sh

aws lambda invoke --help

aws lambda invoke --function-name $LAMBDA_FUNCTION_NAME --payload '{"Records": [{"Sns": {"Message": "{"jobId": "1729017036650-sgrhzc"}"}}]}' response.json

cat response.json
rm response.json
# aws sns publish --topic-arn arn:aws:sns:your-region:your-account-id:YourSNSTopic --message "Test SNS message"
