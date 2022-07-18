#!/bin/bash 

# This script creates servers and the associated route53 internal hosted zone records.

# AMI_ID="ami-0aa718de62aea6fbe"
AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=CloudDevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo $AMI_ID 
echo "$COMPONENT Server Creation in progress"
aws ec2 run-instances --image-id  $AMI_ID --instance-type t2.micro --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]'  | jq 
