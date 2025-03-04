
# Get the topic ARN
TOPIC_ARN=$(aws sns list-topics --output json | jq -r '.Topics[] | select(.TopicArn | contains("'$SNS_NAME_MEDIACONVERT'")).TopicArn')
#echo $TOPIC_ARN

# Add CloudWatch Rule to SNS
aws events put-targets --rule $CLOUDWATCH_RULE_NAME \
  --targets '[{
    "Id": "1",
    "Arn": "'$TOPIC_ARN'"
  }]'

# Grant Permissions to CloudWatch to Publish to SNS
aws sns add-permission --topic-arn $TOPIC_ARN \
--label MediaConvertPermission \
--aws-account-id $AWS_PROJECT_ID \
--action-name Publish
