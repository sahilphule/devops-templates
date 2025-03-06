import boto3

RDS_INSTANCE_IDS = [""]

rds = boto3.client("rds")

def start_rds_instances():
    # Starts all specified RDS instances and logs their status
    try:
        for instance_id in RDS_INSTANCE_IDS:
            rds.start_db_instance(DBInstanceIdentifier=instance_id)
            print(f"Started RDS instance: {instance_id}")
    except Exception as e:
        print(f"Error starting RDS instances: {str(e)}")

def stop_rds_instances():
    # Stops all specified RDS instances and logs their status
    try:
        for instance_id in RDS_INSTANCE_IDS:
            rds.stop_db_instance(DBInstanceIdentifier=instance_id)
            print(f"Stopped RDS instance: {instance_id}")
    except Exception as e:
        print(f"Error stopping RDS instances: {str(e)}")

def lambda_handler(event, context):
    # Triggered by EventBridge to start/stop RDS instances
    if not RDS_INSTANCE_IDS:
        print("RDS_INSTANCE_IDS list is empty!")
        return

    action = event.get("action", "").lower()

    if action == "start":
        start_rds_instances()
    elif action == "stop":
        stop_rds_instances()
    else:
        print(f"Invalid action '{action}' received. Expected 'start' or 'stop'.")
