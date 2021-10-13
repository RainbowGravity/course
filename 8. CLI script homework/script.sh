#!/bin/bash
aws ec2 describe-regions 2>/dev/null 1>/dev/null && echo -e "\033[0;32mYou are logged in! Starting script...\033[0m\n" ||\
{ echo -e "\033[0;31mAWS CLI is not configured or AWS CLI is not installed. Exiting...\033[0m"; exit; }

skipRegion=$"0"
skipOwnerId=$"0"
skipDays=$"0"
skipHours=$"0"
skipMinutes=$"0"
Limit="100"
skipTags="1"

CheckDestRegion(){
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $destRegion | grep -q ".*-.*-.*" && { echo $Regions | grep -qw "$destRegion"; }
        if [ $? -eq 0 ]
            then 
                check=$"1"
            else
                echo -e "\n\033[0;31mThere is no \033[1;31m$destRegion\033[0;31m region, try again.\u001B[0m \nEnter one of the displayed regions:" 
                read -e destRegion
        fi
    done  
}
CheckRegion(){
    Regions=$(aws ec2 describe-regions --query "Regions[*].[RegionName]" --output text)
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $Region | grep -q ".*-.*-.*" && { echo $Regions | grep -qw "$Region"; }
        if [ $? -eq 0 ]
            then 
                check=$"1"
        
                echo -e "\n\033[0;32mRegion is set to \033[1;32m$Region\033[0m"
            else
                echo -e "\n\033[0;31mThere is no \033[1;31m$Region\033[0;31m region, try again.\u001B[0m \nEnter one of the displayed regions:" 
                read -e Region
        fi
    done  
}
CheckDays(){
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $Days | grep -q "[0-9]"
        if [ $? -eq 0 ]
            then 
                check=$"1"      
                echo -e "\n\033[0;32mDays value is set to \033[1;32m$Days\033[0m"
            else
                echo -e "\n\033[0;31mDays value must be a number, try again.\u001B[0m \nEnter the snapshot age in days:" 
                read -e Days
        fi
    done
}
CheckHours(){
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $Hours | grep -q "[0-9]"
        if [ $? -eq 0 ]
            then 
                check=$"1"      
                echo -e "\n\033[0;32mHours value is set to \033[1;32m$Hours\033[0m"
            else
                echo -e "\n\033[0;31mHours value must be a number, try again.\u001B[0m \nEnter the snapshot age in days:" 
                read -e Hours
        fi
    done
}
CheckMinutes(){
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $Minutes | grep -q "[0-9]"
        if [ $? -eq 0 ]
            then 
                check=$"1"      
                echo -e "\n\033[0;32mMinutes value is set to \033[1;32m$Minutes\033[0m"
            else
                echo -e "\n\033[0;31mMinutes value must be a number, try again.\u001B[0m \nEnter the snapshot age in days:" 
                read -e Minutes
        fi
    done
}
CheckLimit(){
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $Limit | grep -q "[0-9]"
        if [ $? -eq 0 ]
            then 
                check=$"1"      
                echo -e "\n\033[0;32mLimit value is set to \033[1;32m$Limit\033[0m"
            else
                echo -e "\n\033[0;31mLimit value must be a number, try again.\u001B[0m \nEnter the snapshot age in days:" 
                read -e Limit
        fi
    done
}
Regions(){
    echo -e "\nAvailable regions: \n"
    aws ec2 describe-regions --query "Regions[*].[RegionName]" --output text
    echo -e "\nEnter one of the displayed regions:"
    read -e Region
    CheckRegion  
}
DestRegion(){
    echo -e "\nAvailable regions: \n"
    aws ec2 describe-regions --query "Regions[*].[RegionName]" --output text
    echo -e "\nEnter the destination region:"
    read -e destRegion
    CheckDestRegion  
}
OwnerID(){
    echo -e "Enter the owner ID:\n"
    read -e OwnerId
    echo -e "\n\033[0;32mOwnerID value is set to \033[1;32m$OwnerId\033[0m"
}
Days(){
    echo -e "\nEnter the snapshot age in days:"
    read -e Days
    CheckDays
}
Hours(){
    echo -e "\nEnter the snapshot age in hours:"
    read -e Hours
    CheckHours
}
Minutes(){
    echo -e "\nEnter the snapshot age in miutes:"
    read -e Minutes
    CheckMinutes
}
Tags(){
AllSnapshots
echo -e "\nEnter the tag key:\n"
read -e Key
echo -e "\nEnter the tag Value:\n"
read -e Value
echo -e "\n\033[0;32mProcessing...\033[0m\n"

Snapshots=$(aws ec2 describe-snapshots --owner-ids $OwnerId --region=$Region --query "Snapshots[?(StartTime<='$Time')]")
tags=$(echo $Snapshots | jq -r --arg Key "$Key" --arg Value "$Value" --arg Limit "$Limit" 'sort_by(.StartTime) | .[-($Limit| tonumber):][] | select(.Tags != null) | select(.Tags[] | .Value == $Value and .Key == $Key) |
  "Description:|"        + .Description + "\n" 
+ "Snapshot ID:|"        + .SnapshotId  + "\n" 
+ "OwnerID:|"            + .OwnerId     + "\n"
+ "Volume size:|"        + (.VolumeSize| tostring) + " GiB \n"
+ "Start time (UTC):|"   + (.StartTime | strptime("%Y-%m-%dT%H:%M:%S %Z") | strftime ("%Y-%m-%d %H:%M:%S")) + "\n"
+ "Start time (" + (now | strftime("%Z")) + "):|" + (.StartTime | strptime("%Y-%m-%dT%H:%M:%S %Z") | mktime | strflocaltime ("%Y-%m-%d %H:%M:%S")) + "\n"
+ (if (.Tags | length) !=0 then ("\u001b[33mTags:|\n\u001B[0m" + "Key:|" + "Value:|\n" + (.Tags | map(.Key + "|" + .Value) | join ("\n"))) else "\u001b[33mThere is no tags\u001B[0m" end) + "\n"
')
echo $tags | egrep -iq "[a-z]|[0-9]" && { echo -e "Name:|Value:\n\n$tags" | column -ets "|"; CopyToS3Question; } || echo 'There is no snapshots with key "'$Key'" and value "'$Value'"'
}

AllSnapshots(){
    Time=$(date -d "$date -$Days days -$Hours hours -$Minutes minutes" -u +"%Y-%m-%dT%H:%M:%SZ")

#OwnerId=$"903794441882"

Snapshots=$(aws ec2 describe-snapshots --owner-ids $OwnerId --region=$Region --query "Snapshots[?(StartTime<='$Time')]")
echo $Snapshots | egrep -iq "[a-z]" && { echo $Snapshots | jq -r --arg Limit "$Limit" 'sort_by(.StartTime) | .[-($Limit| tonumber):][] | 
  "Description:|"        + .Description + "\n" 
+ "Snapshot ID:|"        + .SnapshotId  + "\n" 
+ "OwnerID:|"            + .OwnerId     + "\n"
+ "Volume size:|"        + (.VolumeSize| tostring) + " GiB \n"
+ "Start time (UTC):|"   + (.StartTime | strptime("%Y-%m-%dT%H:%M:%S %Z") | strftime ("%Y-%m-%d %H:%M:%S")) + "\n"
+ "Start time (" + (now | strftime("%Z")) + "):|" + (.StartTime | strptime("%Y-%m-%dT%H:%M:%S %Z") | mktime | strflocaltime ("%Y-%m-%d %H:%M:%S")) + "\n"
+ (if (.Tags | length) !=0 then ("\u001b[33mTags:|\n\u001B[0m" + "Key:|" + "Value:|\n" + (.Tags | map(.Key + "|" + .Value) | join ("\n"))) else "\u001b[33mThere is no tags\u001B[0m" end) + "\n"
' | column -ets "|"; } || echo "There is no snapshots"
#select(.Tags[].Value == '\"$Test\"')

echo -e "\033[0;32mDate was set to:\033[0m"
echo -e "UTC:| $(date -d "$date -$Days days -$Hours hours -$Minutes minutes" -u +"%Y-%m-%d %H:%M:%S %Z")
Local:| $(date -d "$date -$Days days -$Hours hours -$Minutes minutes" +"%Y-%m-%d %H:%M:%S %Z")" | column -ets "|"

Key=$"Stack"
Value=$"test"
}

CopyToS3Question(){
    echo -e "\n\033[0;33mCopy a snapshot?\033[0m"
    read -e apply
    apply=$(echo $apply | awk '{print tolower($0)}')
    if [ $apply == "yes" ]
        then 
            CopyToS3
            exit
        else
            echo -e "\nCopying cancelled."
            exit
    fi
}

CopyToS3(){
    echo -e "\n\033[0;33mChange destination region?\033[0m"
    read -e destination
    destination=$(echo $destination| awk '{print tolower($0)}')
    if [ $destination == "yes" ]
        then 
            DestRegion
        else
            destRegion=$Region
    fi
    echo -e "\n\033[0;32mDestination region is set to \033[1;32m$destRegion\033[0m"
    check=$"1"
    while [ $apply == "yes" ]
        do
            echo -e "\nEnter the snapshot ID you want to copy:"
            read -e snapId
            echo $Snapshots | jq -r --arg Limit "$Limit" 'sort_by(.StartTime) | .[-($Limit| tonumber):][] |.SnapshotId' |\
            grep -qw $snapId
            if [ $? -eq 0 ]
                then 
                    echo -e "\n\033[0;32mCopying $snapId... \033[0m"
                    echo -e "\nNew snapshot ID in $destRegion is:"
                    aws ec2 copy-snapshot --source-region $Region --region $destRegion  --source-snapshot-id $snapId --description "This snapshot was copied by Rainbow Gravity script." --output=text
                    echo -e "\n\033[0;33mCopy one more snapshot?\033[0m"
                    read -e apply
                    apply=$(echo $apply | awk '{print tolower($0)}')
                else
                    echo -e "\n\033[0;31mThere is no snapshots with id $snapId\033[0m"
                    echo -e "\n\033[0;33mTry one more time?\033[0m"
                    read -e apply
                    apply=$(echo $apply | awk '{print tolower($0)}')
            fi
        done
    echo -e "\nExiting process..." 
    exit
}

while getopts "l:r:d:h:m:o:tq" option; do
	case $option in
    l)  Limit=$OPTARG
        CheckLimit;;
    r)  Region=$OPTARG
        skipRegion="1"
        CheckRegion;;
    d)  Days=$OPTARG
        skipDays="1" 
        CheckDays;;
    h)  Hours=$OPTARG
        skipHours="1"
        CheckHours;;
    m)  Minutes=$OPTARG
        skipMinutes="1"
        CheckMinutes;;
	# Repository name/link argument
    o)  OwnerId=$OPTARG
        skipOwnerId="1";;
    # Page argument
	t)  skipTags="0";;
    # Error
    *)  Error exit;;
	esac
done

if [ $skipRegion -eq "0" ] 
    then
        Regions
fi
if [ $skipOwnerId -eq "0" ]
    then
        OwnerID
fi
if [ $skipDays -eq "0" ] 
    then
        Days
fi
if [ $skipHours -eq "0" ] 
    then
        Hours
fi
if [ $skipMinutes -eq "0" ] 
    then
        Minutes
fi

echo -e "\n\033[0;32mDate is set to:\033[0m"
echo -e "UTC:| $(date -d "$date -$Days days -$Hours hours -$Minutes minutes" -u +"%Y-%m-%d %H:%M:%S %Z")
Local:| $(date -d "$date -$Days days -$Hours hours -$Minutes minutes" +"%Y-%m-%d %H:%M:%S %Z") \n" | column -ets "|"

if [ $skipTags -eq 1 ]
    then
        echo -e "\n\033[0;32mProcessing...\033[0m\n"
        AllSnapshots
        CopyToS3Question
    else
        Tags
fi