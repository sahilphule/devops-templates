import boto3
import json
from duplocloud.client import DuploClient

secrets_client = boto3.client('secretsmanager')
duplo_host = "https://<org-name>.duplocloud.net"

def get_secret(secret_name):
    try:
        response = secrets_client.get_secret_value(SecretId=secret_name)
        return json.loads(response['SecretString'])

    except Exception as e:
        print(f"Error retrieving secret {secret_name}: {e}")
        raise

def update_rds_instance(duplo_token, duplo_id, instance_name, action):
    client = DuploClient(duplo_host, duplo_token, tenant_id=duplo_id)

    try:
        rds_instance = client.get(f"/v3/subscriptions/{duplo_id}/aws/rds/{instance_name}")
        if not rds_instance:
            raise ValueError(f"RDS instance {instance_name} not found")

        current_state = rds_instance['State']
        print(f"Current state of {instance_name}: {current_state}")

        if action == "start" and current_state == "stopped":
            client.post(f"/v3/subscriptions/{duplo_id}/aws/rds/{instance_name}/start", {})
            print(f"Started RDS instance: {instance_name}")
        elif action == "stop" and current_state == "available":
            client.post(f"/v3/subscriptions/{duplo_id}/aws/rds/{instance_name}/stop", {})
            print(f"Stopped RDS instance: {instance_name}")
        else:
            print(f"RDS instance {instance_name} is already in the desired state.")

    except Exception as e:
        print(f"Error updating RDS instance {instance_name}: {e}")
        raise

def lambda_handler(event, context):
    secret_name = "DuploCloudLambdaSecrets"
    rds_instance_names = ["rds-instance-1", "rds-instance-2"]

    try:
        secrets = get_secret(secret_name)
        duplo_token = secrets.get("DUPLO_TOKEN")
        duplo_id = secrets.get("DUPLO_ID")

        if not duplo_token or not duplo_id:
            raise ValueError("Missing DUPLO_TOKEN or TENANT_ID in secrets.")

        action = event.get("action", "").lower()

        if action in ["start", "stop"]:
            for instance_name in rds_instance_names:
                update_rds_instance(duplo_token, duplo_id, instance_name, action)
        else:
            print(f"Invalid action {action}. Use 'start' or 'stop'.")

    except Exception as e:
        print(f"Error in lambda_handler: {e}")
