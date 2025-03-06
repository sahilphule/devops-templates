import logging
import boto3
from botocore.exceptions import ClientError
import json
import values

logger = logging.getLogger()
logging.basicConfig(level = logging.INFO,
                    format = '%(asctime)s: %(levelname)s: %(message)s')
vpc_client = boto3.client("ec2", region_name = values.aws_region)

def delete_subnet(subnet_id):
    try:
        response = vpc_client.delete_subnet(SubnetId = subnet_id)
    except ClientError:
        logger.exception('could not delete the subnet')
        raise
    else:
        return response

if __name__ == '__main__':
    subnet_id = ''
    subnet = delete_subnet(subnet_id)
    logger.info(f'subnet {subnet_id} is deleted successfully')