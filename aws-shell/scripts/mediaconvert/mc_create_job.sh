#!/bin/sh

# Get the topic ARN
TOPIC_ARN=$(aws sns list-topics --output json | jq -r '.Topics[] | select(.TopicArn | contains("'$SNS_NAME_MEDIACONVERT'")).TopicArn')
#echo $TOPIC_ARN

sed -e "s|\${BUCKET_INPUT}|$BUCKET_INPUT|g" \
-e "s|\${BUCKET_OUTPUT}|$BUCKET_OUTPUT|g" \
-e "s|\${MEDIACONVERT_ROLE_ARN}|$MEDIACONVERT_ROLE_ARN|g" \
-e "s|\${MEDIACONVERT_JOB_TEMPLATE}|$MEDIACONVERT_JOB_TEMPLATE|g" \
-e "s|\${TOPIC_ARN}|$TOPIC_ARN|g" \
-e "s|\${MEDIACONVERT_QUEUE_ARN}|$MEDIACONVERT_QUEUE_ARN|g" \
/scripts/mediaconvert/job.json > /scripts/mediaconvert/job-filled.json    

aws mediaconvert create-job --cli-input-json file:///scripts/mediaconvert/job-filled.json

#LAST_JOB_ID=$(aws mediaconvert list-jobs --output json | jq -r '.Jobs[0].Id')
#aws mediaconvert get-job --id $LAST_JOB_ID