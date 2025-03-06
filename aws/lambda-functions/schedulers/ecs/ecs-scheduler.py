import boto3

ECS_CLUSTER_NAME = "your-cluster-name"
ECS_SERVICE_NAMES = ["service-1", "service-2"]

ecs = boto3.client("ecs")

def update_service_desired_count(service_name, desired_count):
    try:
        response = ecs.update_service(
            cluster=ECS_CLUSTER_NAME,
            service=service_name,
            desiredCount=desired_count
        )
        print(f"Updated service {service_name} in cluster {ECS_CLUSTER_NAME} to desired count {desired_count}")

    except Exception as e:
        print(f"Error updating ECS service {service_name}: {str(e)}")

def lambda_handler(event, context):
    if not ECS_SERVICE_NAMES:
        print("ECS_SERVICE_NAMES list is empty!")
        return

    action = event.get("action", "").lower()

    for service_name in ECS_SERVICE_NAMES:
        if action == "start":
            update_service_desired_count(service_name, 1)
        elif action == "stop":
            update_service_desired_count(service_name, 0)
        else:
            print(f"Invalid action '{action}' received. Expected 'start' or 'stop'.")
