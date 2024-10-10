#!/bin/sh

sed -e "s|\${BUCKET_INPUT}|$BUCKET_INPUT|g" \
-e "s|\${BUCKET_OUTPUT}|$BUCKET_OUTPUT|g" \
-e "s|\${MEDIACONVERT_ROLE_ARN}|$MEDIACONVERT_ROLE_ARN|g" \
-e "s|\${MEDIACONVERT_JOB_TEMPLATE}|$MEDIACONVERT_JOB_TEMPLATE|g" \
/scripts/mediaconvert/job.json > /scripts/mediaconvert/job-filled.json    

aws mediaconvert create-job --cli-input-json file:///scripts/mediaconvert/job-filled.json
LAST_JOB_ID=$(aws mediaconvert list-jobs --output json | jq -r '.Jobs[0].Id')
#LAST_JOB_ID=$(aws mediaconvert list-jobs --output json | grep '"Id"' | head -n 1 | tr '"' ' ' | awk '{print $3}')
aws mediaconvert get-job --id $LAST_JOB_ID