# AWS CLI snapshots script
## About

This script is used for AWS EC2 snapshots listing. You can choose different regions, IDs, set different time and output limit. After listing you can sort snapshots by a tag and copy the snapshot even to the other region. 

## Requirements

* AWS CLI

## Features 

Script is providing a lot of features:

* You can set age of the snapshots by minutes, hours and days. You will see time you've set in a small table with UTC time and your local time:
```
Days value is set to 0

Hours value is set to 9

Minutes value is set to 28

Date is set to:
UTC:     2021-10-13 09:21:34 UTC
Local:   2021-10-13 12:21:34 MSK 
```
* You can use filtering by tags with a ```-t``` flag. After output of all snapshots you will be able to enter a tag key and value. Be careful: key and value are sensitive to case.
* Easy-to-read output. For example: 
```
Description:       Debian sid (daily build 20211001-782)
Snapshot ID:       snap-0901faf6bb0bcd9e7
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-10-01 05:20:20
Start time (MSK):  2021-10-01 08:20:20
There is no tags
```
* You can set many values by options, except tags keys and values.

## Options
Script have many options which you can use:

* ```-t``` - enable tag filtering after the main output.
#### Arguments required
* ```-l``` - limit of the output. By default: 100.
* ```-r``` - you can set the region by argument for this option.
* ```-d``` - days offset.
* ```-h``` - hours offset.
* ```-m``` - minutes offset.
* ```-o``` - owner ID.

## Examples of use
1. First example is for script without options (only limit) set run:

Input:
```
bash script.sh -l5
```
Output:
```
You are logged in! Starting script...

Limit value is set to 5

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

Enter the owner ID:
903794441882

OwnerID value is set to 903794441882

Enter the snapshot age in days:
20

Days value is set to 20

Enter the snapshot age in hours:
15

Hours value is set to 15

Enter the snapshot age in miutes:
5

Minutes value is set to 5

Date is set to:
UTC:     2021-09-23 05:42:36 UTC
Local:   2021-09-23 08:42:36 MSK 

Processing...

Description:       Debian 10 (daily build 20210923-774)
Snapshot ID:       snap-06fef7fc47846fb8d
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-23 05:06:06
Start time (MSK):  2021-09-23 08:06:06
There is no tags

Description:       Debian 11 (daily build 20210923-774)
Snapshot ID:       snap-0328d1321686ad66c
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-23 05:15:53
Start time (MSK):  2021-09-23 08:15:53
There is no tags

Description:       Debian sid (daily build 20210923-774)
Snapshot ID:       snap-098c9017c65a54066
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-23 05:18:50
Start time (MSK):  2021-09-23 08:18:50
There is no tags

Description:       Debian 10 (daily build 20210923-774)
Snapshot ID:       snap-02234e322bac38476
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-23 05:22:09
Start time (MSK):  2021-09-23 08:22:09
There is no tags

Description:       Debian 10-backports (daily build 20210923-774)
Snapshot ID:       snap-0f0b81bcc42250f9e
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-23 05:38:08
Start time (MSK):  2021-09-23 08:38:08
There is no tags

Date was set to:
UTC:     2021-09-23 05:42:38 UTC
Local:   2021-09-23 08:42:38 MSK

Copy a snapshot?
no

Copying cancelled.
```

* Second example is with pre-set of options and copy operation used.

Input:
```
bash script.sh -r eu-central-1 -d0 -h15 -m18 -o 903794441882 -l5
```
Output:
```
You are logged in! Starting script...

Region is set to eu-central-1

Days value is set to 0

Hours value is set to 15

Minutes value is set to 18

Limit value is set to 5

Date is set to:
UTC:     2021-10-13 05:27:15 UTC
Local:   2021-10-13 08:27:15 MSK 

Processing...

Description:       Debian 11 (daily build 20211013-794)
Snapshot ID:       snap-0320e47e72318f410
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-10-13 05:05:23
Start time (MSK):  2021-10-13 08:05:23
There is no tags

Description:       Debian 10-backports (daily build 20211013-794)
Snapshot ID:       snap-03fd9d0c051c81db9
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-10-13 05:05:49
Start time (MSK):  2021-10-13 08:05:49
There is no tags

Description:       Debian sid (daily build 20211013-794)
Snapshot ID:       snap-0dab062fd7fd9926a
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-10-13 05:19:23
Start time (MSK):  2021-10-13 08:19:23
There is no tags

Description:       Debian 11 (daily build 20211013-794)
Snapshot ID:       snap-0137bcf50ddfa2c39
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-10-13 05:20:06
Start time (MSK):  2021-10-13 08:20:06
There is no tags

Description:       Debian 10 (daily build 20211013-794)
Snapshot ID:       snap-06e7dd5e029700f31
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-10-13 05:23:06
Start time (MSK):  2021-10-13 08:23:06
There is no tags

Date was set to:
UTC:     2021-10-13 05:27:16 UTC
Local:   2021-10-13 08:27:16 MSK

Copy a snapshot?
yes

Change destination region?
no

Destination region is set to eu-central-1

Enter the snapshot ID you want to copy:
snap-0137bcf50ddfa2c39

Copying snap-0137bcf50ddfa2c39... 

New snapshot ID in eu-central-1 is:
snap-06083777f9400dc5b

Copy one more snapshot?
no

Exiting process...
```
