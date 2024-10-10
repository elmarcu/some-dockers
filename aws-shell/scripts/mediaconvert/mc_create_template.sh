#!/bin/sh

sed -e "s|\${BUCKET_INPUT}|$BUCKET_INPUT|g" \
-e "s|\${BUCKET_OUTPUT}|$BUCKET_OUTPUT|g" \
-e "s|\${MEDIACONVERT_JOB_TEMPLATE}|$MEDIACONVERT_JOB_TEMPLATE|g" \
/scripts/mediaconvert/job-template.json > /scripts/mediaconvert/job-template-filled.json

aws mediaconvert create-job-template --cli-input-json file:///scripts/mediaconvert/job-template-filled.json
aws mediaconvert list-job-templates