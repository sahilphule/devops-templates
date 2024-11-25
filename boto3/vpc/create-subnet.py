import logging
import boto3
from botocore.exceptions import ClientError
import json
import values

logger = logging.getLogger()
logging.basicConfig(level = logging.INFO,
                    format = '%(asctime)s: %(levelname)s: %(message)s')
vpc_resource = boto3.resource("ec2", region_name = values.aws_region)

def create_custom_subnet(az, vpc_id, cidr_block):
    try:
        response = vpc_resource.create_subnet(
            TagSpecifications = [
                {
                    'ResourceType': 'subnet',
                    'Tags': [{
                        'Key': 'Name',
                        'Value': values.vpc_properties['vpc-public-subnet-name']
                    }]
                },
            ],
            AvailabilityZone = az,
            VpcId = vpc_id,
            CidrBlock = cidr_block)
    
    except ClientError:
        logger.exception(f'could not create a custom subnet')
        raise
    
    else:
        return response

if __name__ == '__main__':
    cidr_block = values.vpc_properties["vpc-public-subnet-cidr-block"]
    vpc_id = ''
    az = values.availability_zones[0]
    logger.info(f'creating a custom Subnet...')
    custom_subnet = create_custom_subnet(az, vpc_id, cidr_block)
    logger.info(f'custom subnet is created with subnet id: {custom_subnet.id}')