#!/usr/bin/env bash

aws s3 cp template.yaml s3://cd-dev-buck/template.yaml

aws cloudformation create-stack \
--region us-east-1 \
--stack-name CloudFormation-EC2-Stack \
--template-url https://cd-dev-buck.s3.amazonaws.com/template.yaml \
--parameters \
ParameterKey=VpcId,ParameterValue=vpc-941db8e9