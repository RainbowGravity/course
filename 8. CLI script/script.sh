#!/bin/bash
aws ec2 describe-regions 2>/dev/null 1>/dev/null && echo -e "\033[0;32mYou are logged in! Starting script...\033[0m\n" ||\
{ echo -e "\033[0;31mAWS CLI is not configured or AWS CLI is not installed. Exiting...\033[0m"; exit; }

Limit=$(date -d "$date -0 months -20 days" -Iseconds)
Time=$(date -d "$date -0 months -10 days" -Iseconds)
OwnerId=$"903794441882"

Snapshots=$(aws ec2 describe-snapshots --owner-ids $OwnerId --region=us-west-1 --query "Snapshots[?(StartTime>='$Limit')]|[?(StartTime<='$Time')]")
echo $Snapshots | jq -r 'sort_by(.StartTime) | .[] | 
  "Description:|"        + .Description + "\n" 
+ "Snapshot ID:|"        + .SnapshotId  + "\n" 
+ "OwnerID:|"            + .OwnerId     + "\n"
+ "Start time (UTC):|"   + (.StartTime | strptime("%Y-%m-%dT%H:%M:%S %Z") | strftime ("%Y-%m-%d %H:%M:%S")) + "\n"
+ "Start time (" + (now | strftime("%Z")) + "):|" + (.StartTime | strptime("%Y-%m-%dT%H:%M:%S %Z") | mktime | strflocaltime ("%Y-%m-%d %H:%M:%S")) + "\n"
' | column -ets "|"