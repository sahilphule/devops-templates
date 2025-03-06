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

def start_ecs_services(duplo_token, duplo_id, service_names):
    client = DuploClient(duplo_host, duplo_token, tenant_id=duplo_id)

    try:
        all_services = client.load("ecs")
        print("All Services: ", all_services)

        for service_name in service_names:

            ecs_service = all_services.find(service_name)

            replicas = ecs_service['Replicas']
            print(f"Current replicas for {service_name}: {replicas}")

            if replicas == 0:
                ecs_service['Replicas'] = 1
                all_services.update(ecs_service)
                print(f"{service_name} started (replicas set to 1).")

            else:
                print(f"{service_name} is already running.")

            print("ECS Service: ", ecs_service)

    except Exception as e:
        print(f"Error toggling replicas: {e}")
        raise

def stop_ecs_services(duplo_token, duplo_id, service_names):
    client = DuploClient(duplo_host, duplo_token, tenant_id=duplo_id)

    try:
        all_services = client.load("ecs")
        print("All Services: ", all_services)

        for service_name in service_names:

            ecs_service = all_services.find(service_name)

            replicas = ecs_service['Replicas']
            print(f"Current replicas for {service_name}: {replicas}")

            if replicas > 0:
                ecs_service['Replicas'] = 0
                all_services.update(ecs_service)
                print(f"{service_name} stopped (replicas set to 0).")

            else:
                print(f"{service_name} is already stopped.")

            print("ECS Service: ", ecs_service)

    except Exception as e:
        print(f"Error toggling replicas: {e}")
        raise

def lambda_handler(event, context):

    secret_name = "DuploCloudLambdaSecrets"
    service_names = ["", "", "", "", ""]

    try:
        secrets = get_secret(secret_name)
        duplo_token = secrets.get("DUPLO_TOKEN")
        duplo_id = secrets.get("DUPLO_ID")

        if not duplo_token or not duplo_id:
            raise ValueError("Missing DUPLO_TOKEN or TENANT_URL in secrets.")

        action = event.get("action", "").lower()
        if action == "start":
            print("Starting services...")
            start_ecs_services(duplo_token, duplo_id, service_names)
        elif action == "stop":
            print("Stopping services...")
            stop_ecs_services(duplo_token, duplo_id, service_names)
        else:
            return {"statusCode": 400, "body": json.dumps({"error": "Invalid action. Use 'start' or 'stop'."})}

    except Exception as e:
        print(f"Error in lambda_handler: {e}")
        return {
            "statusCode": 500,
            "body": json.dumps({"message": "Error toggling ECS service replicas.", "error": str(e)})
        }

    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Successfully toggled ECS service replicas."})
    }
