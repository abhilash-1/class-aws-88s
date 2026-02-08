#!/bin/bash

echo "Instance creation"

#Instance_ID="i-0bd866075fd00e6b3"
SG_ID="sg-07afeb4dfbab74912"
AMI_ID="ami-0220d79f3f480ecf5"
Domain_name="100pushups.online"

for instance in "$@"
do
    echo "Creating Instance"
    Instance_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --query 'Instances[0].InstanceId' --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --output text )
    echo "Created the Instance successfully=========="
    aws ec2 wait instance-running --instance-ids "$Instance_ID" --region us-east-1
    echo "Waiting until tge Instnace Ip available" 
    if [ $instance == "Frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids $Instance_ID --query 'Reservations[*].Instances[*].PublicIpAddress' --output text --region us-east-1)
        echo "IP:$IP"
        Record_name="$Domain_name"
    else
        IP=$(aws ec2 describe-instances --instance-ids $Instance_ID --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text --region us-east-1)
        echo "IP:$IP"
        Record_name="$instance.$Domain_name"
    fi

    echo "creating A record"
    aws route53 change-resource-record-sets --hosted-zone-id Z07005823OXCP6HOGBEO5 --change-batch '{
    "Comment": "Creating an A record",
    "Changes": [
        {
        "Action": "UPSERT",
        "ResourceRecordSet": {
            "Name": "'$Record_name'",
            "Type": "A",
            "TTL": 1,
            "ResourceRecords": [
            {
                "Value": "'$IP'"
            }
            ]
        }
        }
    ]
    }
    '
    echo "Created A record for : $instance instance"

done
