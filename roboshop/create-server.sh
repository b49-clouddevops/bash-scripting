#!/bin/bash 

# This script creates servers and the associated route53 internal hosted zone records.

# AMI_ID="ami-0aa718de62aea6fbe"
COMPONENT=$1
SGID="sg-0bf27dd0bb525e6b9"

AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=CloudDevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo $AMI_ID 

create_server() {

    echo "$COMPONENT Server Creation in progress"
    PRIVATE_IP=$(aws ec2 run-instances --security-group-ids $SGID --image-id  $AMI_ID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

    # # Changing the IP Address and DNS Name as per the component

    sed -e "s/IPADDRESS/${PRIVATE_IP}/" -e "s/COMPONENT/${COMPONENT}/" route53.json > /tmp/record.json 
    aws route53 change-resource-record-sets --hosted-zone-id Z09626353E72G6GNQ0R5A --change-batch file:///tmp/record.json | jq 

}

create_server 

