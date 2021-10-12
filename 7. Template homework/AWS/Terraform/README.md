## Files and template files

In this folder you will find some different files and folders, there is a description for them: 

* [files](files) folder is containing the [index.html](files/index.html) page that you will see if you will connect to the VPC ALB after deployment.
* [templates](templates) folder is containing [web-server.tpl](templates/web-server.tpl) with a commands for instances to update software, install the Nginx server, copy files from S3 Bucket, install the SSM and start and enable the Nginx server. This file is dynamic and have some variables for Terrafrom which will be applied during ```terraform plan``` and ```terraform apply```. For example, link to the S3 Bucket will be automatically updated depends on current region and S3 Bucket name. 
* Every .tf file is named for its purpose, so there is no point to describe them all individually. 
* [template_homework_apply](template_homework_apply) is a file that will be created/updated after you run the [wrapper-script](wrapper-script.sh). It will be used by script to apply deployment.
* [template_homework_plan.txt](template_homework_plan.txt) is a file that will be created/updated after you run the [wrapper-script](wrapper-script.sh) too. In this file plan is saved in readable no-color form, so you can open it and check all the changes that Terraform will apply.
* [varscript.tfvars](varscript.tfvars) is a file with values for the template variables. File is creating/updating automatically after you write last tag during the wrapper-script run and according to this file Terarform will initiate the ```terrafrom plan``` command and update files described above too. 

## About wrapper script
Wrapper script is used for easy variables management. You can use the script with and without options arguments, or set not all of them. Tag arguments can't be set, you must enter the manually every time. 

Every entered variable will be written to the [varscript.tfvars](varscript.tfvars) file only after your apply for this action. You will see a table with variables you have set and decide then decide to write or not this changes. If you will enter 'yes' then script will start ```terrafrom plan``` with this variables. You can read this plan in [template_homework_plan.txt](template_homework_plan.txt) and then apply it from script answering 'yes' too.

## Script requirements

* Installed and configured AWS CLI. Without your credentials provided to the AWS CLI script will be unable to get information about regions, availability zones and available instance types in selected region.

## Script features

* You can set every template variable from this script, just run it and enter the values. You are unable to set something wrong because script is checking every sensitive setting.
* Ability to run template with applied settings.
* Clear output with colors. You can see every setting applied and error message with describes. If you've enter something wrong then script will give you another chance to do that right even if wrong setting was declared by option argument.

## Examples of use

* First example is for script without options set run:

Input:
```
bash wrapper-script.sh
```
Output:
```
You are logged in! Starting script...

This is a wrapper script for Terraform template homework. 
Changes to varscript.tfvars will be applied only after input of last parameter.

Enter the Environment tag value. Cannot be more than 5 symbols:
Dev

Environment tag is set to Dev

Enter the Project tag value:
Andersen DevOps course

Project tag is set to Andersen DevOps course

Enter the Owner tag value:
Rainbow Gravity

Owner tag is set to Rainbow Gravity

Available regions: 

eu-north-1
ap-south-1
eu-west-3
eu-west-2
eu-west-1
ap-northeast-3
ap-northeast-2
ap-northeast-1
sa-east-1
ca-central-1
ap-southeast-1
ap-southeast-2
eu-central-1
us-east-1
us-east-2
us-west-1
us-west-2

Enter one of the displayed regions:
eu-central-1

Region is set to eu-central-1

Enter the EC2 instance type:
t2.micro

EC2 Instance type is set to t2.micro

Availability zones in eu-central-1 for t2.micro EC2 Instance type: 

eu-central-1a
eu-central-1b
eu-central-1c

Enter amount of Availability zones:
2

Availability zones for eu-central-1 is set to eu-central-1a, eu-central-1b

Enter amount of EC2 Instances per availability zone:
3

Amount of EC2 Instances per availability zone is set to 3

Enter the S3 Bucket name that will be used:
my-cool-bucket

Name of the S3 Bucket is set to dev-my-cool-bucket-eu-central-1

Enable or disable NAT. Only 'true' or 'false':
true

Setting of NAT is set to true

This settings will be applied: 

Name:               Value: 

Selected region     eu-central-1
Availability zones  eu-central-1a, eu-central-1b
EC2 Instance type   t2.micro
EC2 per zone        3
S3 Bucket name      dev-my-cool-bucket-eu-central-1
NAT setting         true

Tag key:            Tag value:
Environment         Dev
Project             Andersen DevOps course
Owner               Rainbow Gravity

Write this changes to varscript.tfvars?

Only 'yes' will be accepted to approve.
yes

Writing changes to varscript.tfvars...

Writing a plan...

Done! The output of 'terraform plan' is saved as template_homework_plan.txt
and as template_homework_apply for 'terraform apply'.

You can read this plan and then apply it answering 'yes' on the next question.

Terraform will perform the actions described in template_homework_plan.txt.
Only 'yes' will be accepted to approve.

Apply this plan?
no

Apply cancelled.

```

* Second example is for options with one wrong variable:

Input:
```
bash wrapper-script.sh -r eu-north-1 -i t2.micro -a 2 -e 1 -s my-cool-bucket -n false
```
Output:
```
You are logged in! Starting script...

This is a wrapper script for Terraform template homework. 
Changes to varscript.tfvars will be applied only after input of last parameter.

Region is set to eu-north-1

EC2 Instance type t2.micro is not available in eu-north-1. Try again or restart the script and choose different region. 
Enter the EC2 instance type:
t3.micro

EC2 Instance type is set to t3.micro

Availability zones for eu-north-1 is set to eu-north-1a, eu-north-1b

Amount of EC2 Instances per availability zone is set to 1

Name of the S3 Bucket is set to placeholder-my-cool-bucket-eu-north-1

Setting of NAT is set to false

Enter the Environment tag value. Cannot be more than 5 symbols:
Dev

Environment tag is set to Dev

Enter the Project tag value:
Andersen DevOps course

Project tag is set to Andersen DevOps course

Enter the Owner tag value:
Rainbow Gravity

Owner tag is set to Rainbow Gravity

Name of the S3 Bucket is set to dev-my-cool-bucket-eu-north-1

Writing changes to vascript.tfvars...

This settings will be applied: 

Name:               Value: 

Selected region     eu-north-1
Availability zones  eu-north-1a, eu-north-1b
EC2 Instance type   t3.micro
EC2 per zone        1
S3 Bucket name      dev-my-cool-bucket-eu-north-1
NAT setting         false

Tag key:            Tag value:
Environment         Dev
Project             Andersen DevOps course
Owner               Rainbow Gravity

Write this changes to varscript.tfvars?

Only 'yes' will be accepted to approve.
yes

Writing changes to varscript.tfvars...

Writing a plan...

Done! The output of 'terraform plan' is saved as template_homework_plan.txt
and as template_homework_apply for 'terraform apply'.

You can read this plan and then apply it answering 'yes' on the next question.

Terraform will perform the actions described in template_homework_plan.txt.
Only 'yes' will be accepted to approve.

Apply this plan?
no

Apply cancelled.
```
* And third example is for no credentials or AWS CLI on machine:

Input:
```
bash wrapper-script.sh
```
Output:
``` 
AWS CLI is not configured or AWS CLI is not installed. Exiting...
```