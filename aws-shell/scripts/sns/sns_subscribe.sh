#!/bin/sh

# Create an SNS topic
aws sns create-topic --name $SNS_NAME_MEDIACONVERT

# Get the topic ARN
TOPIC_ARN=$(aws sns list-topics --output json | jq -r '.Topics[] | select(.TopicArn | contains("'$SNS_NAME_MEDIACONVERT'")).TopicArn')
#echo $TOPIC_ARN

aws sns subscribe \
  --topic-arn "$TOPIC_ARN" \
  --protocol lambda \
  --notification-endpoint arn:aws:lambda:$AWS_DEFAULT_REGION:$AWS_PROJECT_ID:function:$LAMBDA_FUNCTION_NAME

# Grant SNS permission to invoke the Lambda function
aws lambda add-permission \
  --function-name $LAMBDA_FUNCTION_NAME \
  --statement-id sns-invoke-lambda \
  --action lambda:InvokeFunction \
  --principal sns.amazonaws.com \
  --source-arn "$TOPIC_ARN"

# manual invoke
# aws sns publish --topic-arn $TOPIC_ARN --message "Test SNS message"
