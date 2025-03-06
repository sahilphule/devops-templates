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

def update_host_instance(duplo_token, duplo_id, host_name, action):
    client = DuploClient(duplo_host, duplo_token, tenant_id=duplo_id)

    try:
        # Fetch host details
        hosts = client.get(f"/v3/subscriptions/{duplo_id}/host")
        if not hosts:
            raise ValueError("No hosts found for this tenant.")

        # Find the specific host by name
        host_instance = next((host for host in hosts if host["Name"] == host_name), None)
        if not host_instance:
            raise ValueError(f"Host {host_name} not found")

        current_state = host_instance['State']
        print(f"Current state of {host_name}: {current_state}")

        # Start or stop host
        if action == "start" and current_state == "stopped":
            client.post(f"/v3/subscriptions/{duplo_id}/host/{host_name}/start", {})
            print(f"Started host: {host_name}")
        elif action == "stop" and current_state == "running":
            client.post(f"/v3/subscriptions/{duplo_id}/host/{host_name}/stop", {})
            print(f"Stopped host: {host_name}")
        else:
            print(f"Host {host_name} is already in the desired state.")

    except Exception as e:
        print(f"Error updating host {host_name}: {e}")
        raise

def lambda_handler(event, context):
    secret_name = "DuploCloudLambdaSecrets"
    host_names = ["host-1", "host-2"]  # Replace with actual host names

    try:
        secrets = get_secret(secret_name)
        duplo_token = secrets.get("DUPLO_TOKEN")
        duplo_id = secrets.get("DUPLO_ID")

        if not duplo_token or not duplo_id:
            raise ValueError("Missing DUPLO_TOKEN or TENANT_ID in secrets.")

        action = event.get("action", "").lower()

        if action in ["start", "stop"]:
            for host_name in host_names:
                update_host_instance(duplo_token, duplo_id, host_name, action)
        else:
            print(f"Invalid action {action}. Use 'start' or 'stop'.")

    except Exception as e:
        print(f"Error in lambda_handler: {e}")
