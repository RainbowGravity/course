#!/bin/bash
Help() {
    echo -e "_____________________________________________________________________________________

This script is used to setup main variables of the terraform template.

Variables that can be specified:"
    echo -e "
    - \u001B[1mRegion\u001B[0m|-- region of the VPC.
    - \u001B[1mInstance_Type\u001B[0m|-- After selection of the instance script will check for support of this instance in selected region.
    - \u001B[1mAmount_of_Zones\u001B[0m|-- Amount of availability zones in selected region for selected instance type.
    - \u001B[1mEC2_Per_Zone\u001B[0m|-- Amount of instances per each availability zone.
    - \u001B[1mS3_Bucket_Name\u001B[0m|-- Environment tag will be added to the beginning and region name to the end.
    - \u001B[1mEnable_NAT\u001B[0m|-- False or true. Nat is needed for internet connection of instances from private zones, but not in our case.
    - \u001B[1mEnvironment_Tag\u001B[0m|-- This tag is used as prefix for several resources, can't be empty or more than 5 symbols.
    - \u001B[1mProject_Tag\u001B[0m|-- Project tag.
    - \u001B[1mOwner_Tag\u001B[0m|-- Owner tag." | column -ets "|"
    echo -e "
Options:

    -r -- Region (string)
    -i -- Instance type (string)
    -a -- Amount of availability zones (number)
    -e -- Instances per zone (number)
    -s -- S3 Bucket name. No spaces and uppercase letters are allowed.
    -n -- NAT setting. (bool)
    -h -- help
_____________________________________________________________________________________
"
    exit
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
                echo -e 'Region = "'$Region'"' >> varscript.tfvars
                echo -e "\n\033[0;32mRegion is set to \033[1;32m$Region\033[0m"
            else
                echo -e "\n\033[0;31mThere is no \033[1;31m$Region\033[0;31m region, try again.\u001B[0m \nEnter one of the displayed regions:" 
                read -e Region
        fi
    done  
}
CheckInstance(){
    Instances_Available=$(aws ec2 describe-instance-type-offerings --region=$Region --query "InstanceTypeOfferings[].InstanceType" --output text )
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $Instances_Available | grep -qw "$Instance_Type"
        if [ $? -eq 0 ]
            then 
                check=$"1"
                echo 'Instance_Type = "'$Instance_Type'"' >> varscript.tfvars
                echo -e "\n\033[0;32mEC2 Instance type is set to \033[1;32m$Instance_Type\033[0m"
            else
                echo -e "\n\033[0;31mEC2 Instance type \033[1;31m$Instance_Type\033[0;31m is not available in \033[1;31m$Region\033[0;31m. Try again or restart the script and choose different region.\u001B[0m \nEnter the EC2 instance type:" 
                read -e Instance_Type
        fi
    done  
}
CheckZones(){
    Zones_Available=$(aws ec2 describe-instance-type-offerings --location-type availability-zone --filter Name=instance-type,Values=$Instance_Type --region=$Region --query "InstanceTypeOfferings[*].[Location]" --output text | sort -n)
    zones=$(echo $Zones_Available | wc -w)
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $Amount_of_Zones | grep -q "[0-9]"
        if [ $? -eq 0 ] && [ $Amount_of_Zones -le $zones ] && [ $Amount_of_Zones -ge 2 ]
            then 
                check=$"1"
                Selected_Zones=$(echo $Zones_Available | cut -d " " -f -$Amount_of_Zones | sed "s/\s/, /g")
                echo "Amount_of_Zones = $Amount_of_Zones" >> varscript.tfvars
                echo -e "\n\033[0;32mAvailability zones for \033[1;32m$Region\033[0;32m is set to \033[1;32m$Selected_Zones\033[0m"
            else
                echo -e "\n\033[0;31mAmount of zones for \033[1;31m$Region\033[0;31m cannot be more than \033[1;31m$zones\033[0;31m and less than \033[1;31m2\033[0;31m, try again.\u001B[0m \nEnter amount of Availability zones:" 
                read -e Amount_of_Zones
        fi
    done
}
CheckInstances(){
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $EC2_Per_Zone | grep -q "[0-9]"
        if [ $? -eq 0 ] && [ $EC2_Per_Zone -ge 1 ]
            then 
                check=$"1"
                echo "EC2_Per_Zone = $EC2_Per_Zone" >> varscript.tfvars
                echo -e "\n\033[0;32mAmount of EC2 Instances per availability zone is set to \033[1;32m$EC2_Per_Zone\033[0m"
            else
                echo -e "\n\033[0;31mAmount of EC2 Instances per availability zone cannot be less than \033[1;31m1\033[0;31m, try again.\u001B[0m \nEnter amount of EC2 Instances per availability zone:" 
                read -e EC2_Per_Zone
        fi
    done
}
CheckNAT(){
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $Enable_NAT | egrep -qw "true|false"
        if [ $? -eq 0 ]
            then 
                check=$"1"
                echo "Enable_NAT = $Enable_NAT" >> varscript.tfvars
                echo -e "\n\033[0;32mSetting of NAT is set to \033[1;32m$Enable_NAT\033[0m"
            else
                echo -e "\n\033[0;31mOnly boolean 'true' of 'false' is valid, try again.\u001B[0m \nEnable or disable NAT. Only 'true' or 'false':" 
                read -e Enable_NAT
        fi
    done
}
CheckBucket(){
    check=$"0"
    while [ $check -eq 0 ]
    do
        echo $S3_Bucket_Name | egrep -q "\s|[A-Z]"
        if [ $? -eq 1 ]
            then 
                check=$"1"
                echo 'S3_Bucket_Name = "'$S3_Bucket_Name'"' >> varscript.tfvars
                tag=$(echo "$Environment_Tag" | awk '{print tolower($0)}')
                echo -e "\n\033[0;32mName of the S3 Bucket is set to \033[1;32m$tag-$S3_Bucket_Name-$Region\033[0m"
            else
                echo -e "\n\033[0;31mBucket name must not contain spaces or uppercase letters, try again.\u001B[0m \nEnter the S3 Bucket name that will be used:" 
                read -e 3_Bucket_Name
        fi
    done
}
echo -e "#===========================================================================================
# Rainbow Gravity's Template homework
# 
# Created by a script
#===========================================================================================
" > varscript.tfvars
while getopts "r:i:a:e:s:n:h" option; do
	case $option in
    h)  Help;;
    # Region option
    r)  Region=$OPTARG
        skipRegion=$"True"
        CheckRegion;;
    # Instance type option
    i)  Instance_Type=$OPTARG
        skipInstance=$"True" 
        CheckInstance;;
    # Additonal info for repositories 
    a)  Amount_of_Zones=$OPTARG
        skipZones=$"True"
        CheckZones;;
    # Additional info for user
    e)  EC2_Per_Zone=$OPTARG
        skipEC2="True"
        CheckInstances;;
	# Repository name/link argument
    s)  S3_Bucket_Name=$OPTARG
        # Placeholder for S3 bucket if its name was specified from option argument
        Environment_Tag=$"placeholder"
        skipBucket="True"
        CheckBucket;;
    # Page argument
	n)  Enable_NAT=$OPTARG
        skipNAT="True"
        CheckNAT;;
    # Error
    *)  Error exit;;
	esac
done
Regions(){
    echo -e "Available regions: \n"
    aws ec2 describe-regions --query "Regions[*].[RegionName]" --output text
    echo -e "\nEnter one of the displayed regions:"
    read -e Region
    CheckRegion  
}
Instance(){
    echo -e "\nEnter the EC2 instance type:"
    read -e Instance_Type
    CheckInstance
}
Zones(){
    echo -e " \nAvailability zones in $Region for $Instance_Type EC2 Instance type: \n"  
    aws ec2 describe-instance-type-offerings --location-type availability-zone --filter Name=instance-type,Values=$Instance_Type --region=$Region --query "InstanceTypeOfferings[*].[Location]" --output text | sort -n
    echo -e "\nEnter amount of Availability zones:"
    read -e Amount_of_Zones
    CheckZones
}
Instances(){
    echo -e "\nEnter amount of EC2 Instances per availability zone:"
    read -e EC2_Per_Zone
    CheckInstances
}
Bucket(){
    echo -e "\nEnter the S3 Bucket name that will be used:"
    read -e S3_Bucket_Name
    CheckBucket
}
NAT(){
    echo -e "\nEnable or disable NAT. Only 'true' or 'false':"
    read -e Enable_NAT
    CheckNAT
}
# Tags only can be specified manually
Tags(){
    echo -e "\nEnter the Environment tag value. Cannot be more than 5 symbols:"
        read -e Environment_Tag
        check=$"0"
        while [ $check -eq 0 ]
        do
            len=$(echo $Environment_Tag | wc -c)
            echo $Environment_Tag | egrep -q "\s"
            if [ $? -eq 1 ] && [ $len -le 6 ] && [ $len -ge 1 ]
                then 
                    check=$"1"
                    echo 'Environment_Tag = "'$Environment_Tag'"'  >> varscript.tfvars
                    echo -e "\n\033[0;32mEnvironment tag is set to \033[1;32m$Environment_Tag\033[0m"
                else
                    echo -e "\n\033[0;31mEnvironment tag value cannot be more than 5 symbols or empty and contain spaces because some resources are used it as name prefix.\u001B[0m \nEnter the Environment tag value:" 
                    read -e Environment_Tag
            fi
        done
    echo -e "\nEnter the Project tag value:"
    read -e Project_Tag
    echo 'Project_Tag = "'$Project_Tag'"' >> varscript.tfvars
    echo -e "\n\033[0;32mProject tag is set to \033[1;32m$Project_Tag\033[0m"

    echo -e "\nEnter the Owner tag value:"
    read -e Owner_Tag
    echo 'Owner_Tag = "'$Owner_Tag'"' >> varscript.tfvars
    echo -e "\n\033[0;32mOwner tag is set to \033[1;32m$Owner_Tag\033[0m"
}
Tags
# Skiping questions about variables if they was specified by options arguments 
if [ $skipRegion != "True" ] 2>/dev/null
    then
        Regions
fi
if [ $skipInstance != "True" ] 2>/dev/null
    then
        Instance
fi
if [ $skipZones != "True" ] 2>/dev/null
    then
        Zones
fi
if [ $skipEC2 != "True" ] 2>/dev/null
    then
        Instances
fi
if [ $skipBucket != "True" ] 2>/dev/null
    then
        Bucket
    else
    # Displaying a full name of the S3 Bucket after tag was finally specified 
    tag=$(echo "$Environment_Tag" | awk '{print tolower($0)}')
    echo -e "\n\033[0;32mName of the S3 Bucket is set to \033[1;32m$tag-$S3_Bucket_Name-$Region\033[0m"
fi
if [ $skipNAT != "True" ] 2>/dev/null
    then
        NAT
fi
# Displaying the table of settings which will be applied
echo -e "\nThis settings will be applied: \n"
echo -e "Name:|Value: \n
Selected region|\033[0;32m$Region\033[0m
Availability zones|\033[0;32m$Selected_Zones\033[0m
EC2 per zone|\033[0;32m$EC2_Per_Zone\033[0m
S3 Bucket name|\033[0;32m$tag-$S3_Bucket_Name-$Region\033[0m
NAT setting|\033[0;32m$Enable_NAT\033[0m

Tag key:|Tag value:
Environment|\033[0;32m$Environment_Tag\033[0m
Project|\033[0;32m$Project_Tag\033[0m
Owner|\033[0;32m$Owner_Tag\033[0m" | column -ets "|"

# Starting 'terraform plan' with variables which was specified during script running
echo -e "\nWriting a plan..."
terraform plan -no-color -var-file=varscript.tfvars -out=template_homework_apply > template_homework_plan.txt
if [ $? -eq 0 ]
    then 
        echo -e "\n\033[1;32mDone!\033[0;32m The output of 'terraform plan' is saved as \033[1;32mtemplate_homework_plan.txt\033[0;32m
and as \033[1;32mtemplate_homework_apply\033[0;32m for 'terraform apply'.\033[0m

You can read this plan and then apply it answering 'yes' on the next question.
"
    else
        echo -e "\n\033[0;31mAn error occured: failed to write a plan.\033[0m"
        exit    
fi

echo -e "Terraform will perform the actions described in template_homework_plan.txt.
Only 'yes' will be accepted to approve.

\033[0;33mApply this plan?\033[0m"
read -e apply

apply=$(echo $apply | awk '{print tolower($0)}')
if [ $apply == "yes" ]
    then 
        echo -e "\nApplying the plan...\n"
        terraform apply template_homework_apply
        exit
    else
        echo -e "\nApply cancelled."
        exit
fi