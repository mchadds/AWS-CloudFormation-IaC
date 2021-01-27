# AWS-CloudFormation-IaC
Automated (& programmatic) deployment of an EC2 instance with Security Groups and Web Server via CloudFormation stack - utilizing Infrastructure as Code.

## Description
All commands were executed through the Cloud9 CLI to 
- create an S3 bucket, 
- Bash commands in [update.sh](https://github.com/mchadds/AWS-CloudFormation-IaC/blob/main/update.sh) used for copying the .yaml file to the bucket and creating the CloudFormation stack
- [template.yaml](https://github.com/mchadds/AWS-CloudFormation-IaC/blob/main/template.yaml) holds ine IaC template for the EC2 instance

## Infrastructure as Code
Detailed infrastructure template found in [template.yaml](https://github.com/mchadds/AWS-CloudFormation-IaC/blob/main/template.yaml): 
```yaml
AWSTemplateFormatVersion: 2010-09-09
Description: >- 
    Infrastructure for EC2 Instance
Parameters: 
    ImageId:
        Description: AMI to use eg. ami-047a51fa27710816e
        Default: ami-047a51fa27710816e
        Type: String
    VpcId: 
        Description: The VPC used by the SG
        Type: String
Resources: 
    WebServer:
        Type: AWS::EC2::Instance
        Properties:
            InstanceType: t2.micro
            ImageId: !Ref ImageId
            SecurityGroupIds:
                !GetAtt SecurityGroup.GroupId
            UserData:
                'Fn::Base64':
                    !Sub |
                        #!/usr/bin/env bash
                        yum -y update
                        su ec2-user
                        sudo yum install httpd -y
                        sudo service httpd start
                        sudo service httpd enable
    SecurityGroup:
        Type: AWS::EC2::SecurityGroup
        Properties: 
            VpcId: !Ref VpcId
            GroupDescription: 'Open port 80'
            SecurityGroupIngress:
                -   IpProtocol: tcp
                    FromPort: 80
                    ToPort: 80
                    CidrIp: "0.0.0.0/0"
Outputs:
    PublicIp:
        Value: !GetAtt WebServer.PublicIp
```

## Tools
- [Cloud9](https://aws.amazon.com/cloud9/) Cloud IDE
- [CloudFormation](https://aws.amazon.com/cloudformation/) Cloud provisioning with Infrastructure as Code
- [EC2](https://aws.amazon.com/ec2/?ec2-whats-new.sort-by=item.additionalFields.postDateTime&ec2-whats-new.sort-order=desc) Secure and resizable compute capacity
- [S3](https://aws.amazon.com/s3/) Cloud storage


