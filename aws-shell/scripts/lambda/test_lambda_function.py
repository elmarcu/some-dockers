import pytest
import boto3
from unittest.mock import patch  # Import patch from unittest.mock
from botocore.exceptions import ClientError
from lambda_function import lambda_handler

@patch('boto3.client')
def test_valid_job(mock_boto_client):
    # Mock the MediaConvert client
    mock_mediaconvert = mock_boto_client.return_value

    # Set up the response for a valid job
    mock_mediaconvert.get_job.return_value = {
        'Job': {'Status': 'COMPLETE'}
    }

    # Simulate SNS event with valid job ID
    event = {
        'Records': [{
            'Sns': {
                'Message': '{"jobId": "valid_job"}'
            }
        }]
    }

    # Call the Lambda handler
    result = lambda_handler(event, None)

    # Assert the response
    assert result['statusCode'] == 200
    assert 'completed successfully' in result['body']

@patch('boto3.client')
def test_invalid_job(mock_boto_client):
    # Mock the MediaConvert client
    mock_mediaconvert = mock_boto_client.return_value

    # Simulate raising ClientError for an invalid job ID
    mock_mediaconvert.get_job.side_effect = ClientError(
        {"Error": {"Code": "BadRequestException", "Message": "Invalid job ID"}}, 
        "GetJob"
    )

    # Simulate SNS event with invalid job ID
    event = {
        'Records': [{
            'Sns': {
                'Message': '{"jobId": "invalid_job"}'
            }
        }]
    }

    # Call the Lambda handler
    result = lambda_handler(event, None)

    # Assert the response
    assert result['statusCode'] == 400
    assert 'Job ID invalid_job not found or invalid' in result['body']
