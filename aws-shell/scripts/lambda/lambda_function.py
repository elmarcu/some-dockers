import json
import boto3
import botocore

def lambda_handler(event, context):
    print(f"Received event: {event}")
    # Extract MediaConvert job ID from SNS event
    message = event['Records'][0]['Sns']['Message']
    message_data = json.loads(message)  # Parse the SNS message (it's in JSON format)
    
    job_id = message_data['jobId']
    
    # Initialize MediaConvert client
    client = boto3.client('mediaconvert')

    try:
        # Get the job details from MediaConvert
        response = client.get_job(Id=job_id)
        
        # Check if the job is complete
        if response['Job']['Status'] == 'COMPLETE':
            return {
                'statusCode': 200,
                'body': f'Job {job_id} completed successfully'
            }
        else:
            return {
                'statusCode': 202,
                'body': f'Job {job_id} is in progress'
            }
    except botocore.exceptions.ClientError as e:
        # Handle the ClientError exception
        return {
            'statusCode': 400,
            'body': f'Job ID {job_id} not found or invalid'
        }
