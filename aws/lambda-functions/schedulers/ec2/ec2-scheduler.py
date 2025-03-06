import boto3

# Replace with your EC2 instance IDs
EC2_INSTANCE_IDS = ["", ""]

ec2 = boto3.client("ec2")

def get_instance_names(instance_ids):
    # Fetch instance names from EC2 tags
    try:
        response = ec2.describe_instances(InstanceIds=instance_ids)
        instance_info = {}

        for reservation in response["Reservations"]:
            for instance in reservation["Instances"]:
                instance_id = instance["InstanceId"]
                instance_name = "Unnamed"
                
                # Fetch Name tag if available
                for tag in instance.get("Tags", []):
                    if tag["Key"] == "Name":
                        instance_name = tag["Value"]
                        break
                
                instance_info[instance_id] = instance_name

        return instance_info

    except Exception as e:
        print(f"Error fetching instance names: {str(e)}")
        return {}

def start_ec2_instance():
    # Starts EC2 instances and logs their names
    try:
        instance_names = get_instance_names(EC2_INSTANCE_IDS)
        ec2.start_instances(InstanceIds=EC2_INSTANCE_IDS)

        for instance_id in EC2_INSTANCE_IDS:
            print(f"Started: {instance_id} ({instance_names.get(instance_id, 'Unnamed')})")

    except Exception as e:
        print(f"Error starting instances: {str(e)}")

def stop_ec2_instance():
    # Stops EC2 instances and logs their names
    try:
        instance_names = get_instance_names(EC2_INSTANCE_IDS)
        ec2.stop_instances(InstanceIds=EC2_INSTANCE_IDS)

        for instance_id in EC2_INSTANCE_IDS:
            print(f"Stopped: {instance_id} ({instance_names.get(instance_id, 'Unnamed')})")

    except Exception as e:
        print(f"Error stopping instances: {str(e)}")

def lambda_handler(event, context):
    # Triggered by EventBridge Action to start/stop EC2 instances
    if not EC2_INSTANCE_IDS:
        print("EC2_INSTANCE_IDS list is empty!")
        return
    
    action = event.get("action", "").lower()

    if action == "start":
        start_ec2_instance()
    elif action == "stop":
        stop_ec2_instance()
    else:
        print(f"Invalid action '{action}' received. Expected 'start' or 'stop'.")
