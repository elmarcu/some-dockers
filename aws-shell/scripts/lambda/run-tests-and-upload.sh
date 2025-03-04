#!/bin/sh

#already uploaded
exit 0

# Run pytest
echo "Running pytest..."
pytest
TEST_EXIT_CODE=$?

# Check if pytest passed
if [ $TEST_EXIT_CODE -eq 0 ]; then
    echo "All tests passed. Preparing to upload the Lambda function."

    # Zip the Lambda function
    echo "Zipping the Lambda function..."
    zip function.zip lambda_function.py

    # Upload the Lambda function to AWS
    echo "Uploading to AWS Lambda..."

    # Check if the Lambda function exists
    EXISTS=$(aws lambda get-function --function-name $LAMBDA_FUNCTION_NAME --region $AWS_DEFAULT_REGION 2>&1)

    if [[ "$EXISTS" == *"ResourceNotFoundException"* ]]; then
        echo "Lambda function does not exist. Creating..."
        aws lambda create-function \
        --function-name $LAMBDA_FUNCTION_NAME \
        --runtime python3.8 \
        --role $LAMBDA_EXECUTION_ROLE \
        --handler lambda_function.lambda_handler \
        --zip-file fileb://function.zip \
        --region $AWS_DEFAULT_REGION
    else
        echo "Lambda function exists. Updating..."
        aws lambda update-function-code \
            --function-name $LAMBDA_FUNCTION_NAME \
            --zip-file fileb://function.zip
    fi

    if [ $? -eq 0 ]; then
        echo "Lambda function uploaded successfully!"
    else
        echo "Failed to upload Lambda function."
    fi
else
    echo "Tests failed. Lambda function will not be uploaded."
fi

rm function.zip

# manual invoke
#aws lambda invoke --function-name $LAMBDA_FUNCTION_NAME --payload '{"jobId": "YOUR_JOB_ID"}' response.json
