# Pulumi Modules

## VPC Module

## VPC Module
1. Create *vpc* folder.
2. Inside *vpc* folder create *main.py* file.
2. Import the following:
    - pulumi_aws as aws
    - values
3. Call the following functions:
    - aws.ec2.Vpc()
    - aws.get_availability_zones()
    - for public
        - aws.ec2.InternetGateway()
        - aws.ec2.RouteTable()
        - aws.ec2.Subnet()
        - aws.ec2.RouteTableAssociation()
    - for private
        - aws.ec2.RouteTable()
        - aws.ec2.Subnet()
        - aws.ec2.RouteTableAssociation()
4. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/vpc/main.tf) for reference.
5. Now we have completed defining the **VPC Module**.

---

## S3 Module
1. Create *s3* folder.
7. Create *main.tf* file.
8. Import the following:
    - pulumi_aws as aws
    - values
9. Call the following functions:
    - aws.s3.BucketV2
    - aws.s3. BucketVersioningV2
11. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/rds/main.tf) for reference.
12. The definition of *rds.py* file is completed.
13. We have completed defining the **S3 Module**.

---

## RDS Definition
1. Create *rds* folder.
2. Inside *rds* folder, create *data.py* file.
3. Import the following:
    - pulumi_aws as aws
4. Call the following function:
    - aws.ec2.get_ami
5. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/rds/data.tf) for reference.
6. We have completed defining the *data.py* file.
7. Now we will create *main.tf* file.
8. Import the following:
    - pulumi
    - pulumi_aws as aws
    - vpc
    - data
    - values
9. Call the following functions:
    - for database
        - aws.rds.SubnetGroup()
        - aws.ec2.SecurityGroup()
        - aws.rds.Instance()
    - for bastion-host
        - aws.ec2.SecurityGroup()
        - aws.ec2.KeyPair()
        - aws.ec2.Instance()
10. Define the following output:
    - DB_HOST
    - bastion-host-ip
11. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/rds/main.tf) for reference.
12. The definition of *rds.py* file is completed.
13. We have completed defining the **RDS Module**.

---

## Load Balancer Module
Let's start with the Load Balancer Module
1. Create *load-balancer* folder.
2. Inside *load-balancer* folder, create *main.tf* file.
3. In the *main.tf* file, define the following resources:
    - aws_security_group
    - aws_lb
    - aws_lb_target_group
    - aws_lb_listener
4. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/load-balancer/main.tf) for reference.
5. The *main.tf* file for Load Balancer Module has been defined.
6. Now we will define variables.tf file.
7. Create *variables.tf* file inside *load-balancer* folder.
8. Define the following variables:
    - vpc-id
    - vpc-public-subnets
    - vpc-private-subnets
    - load-balancer-properties
9. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/load-balancer/variables.tf) for reference.
10. The *variable.tf* file for Load Balancer Module has been defined.
11. Now we will define outputs.tf file.
12. Create *outputs.tf* file inside *load-balancer* folder.
13. Define the following variables:
    - load-balancer-sg-id
    - target-group-arn
14. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/load-balancer/outputs.tf) for reference.
15. We have completed defining the **Load Balancer Module**.

---
---

## ECS Module
1. Create *ecs* folder.
2. Inside *ecs* folder create *data.tf* file.
3. Import the following:
    - pulumi_aws as aws
3. In *data.tf* file, define the following data:
    - ecs_role_policy_document
4. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/eks/data.tf) for reference.
5. Definition of *data.tf* file is completed.
6. Now we will define *ecs.py* file.
7. Inside *eks* folder create *main.tf* file.
2. Import the following:
    - pulumi
    - pulumi_aws as aws
    - vpc
    - load_balancer
    - data
    - values
    - json
3. Call the following functions:
    - aws.ecs.Cluster()
    - aws.iam.Role()
    - aws.iam.RolePolicyAttachment()
    - aws.ecs.TaskDefinition()
    - aws.ecs.Service()
10. Define the following output:
    - url
9. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/eks/main.tf) for reference.
10. The *main.tf* file for ECS has been defined.
15. We have completed defining the **ECS Module**.

---

## EKS Module
1. Create *eks* folder.
2. Inside *eks* folder create *data.tf* file.
3. Import the following:
    - pulumi_aws as aws
3. In *data.tf* file, define the following data:
    - eks_cluster_role_policy_document
    - eks_node_group_role_policy_document
4. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/eks/data.tf) for reference.
5. Definition of *data.tf* file is completed.
6. Now we will define *main.tf* file.
7. Inside *eks* folder create *main.tf* file.
2. Import the following:
    - pulumi_aws as aws
    - vpc
    - data
    - values
    - json
3. Call the following functions:
    - aws.iam.Role()
    - aws.iam.RolePolicyAttachment()
    - aws.ec2.SecurityGroup()
    - aws.eks.Cluster()
    - aws.iam.Role()
    - aws.iam.RolePolicyAttachment()
    - aws.iam.RolePolicyAttachment()
    - aws.iam.RolePolicyAttachment()
    - aws.eks.NodeGroup()
9. Click [code](https://github.com/sahilphule/terraform/blob/master/modules/aws/eks/main.tf) for reference.
10. The *main.tf* file for EKS has been defined.
15. We have completed defining the **EKS Module**.

---