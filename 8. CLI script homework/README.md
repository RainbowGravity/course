# Github open pull requests script
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
### Arguments required
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
20

Hours value is set to 20

Enter the snapshot age in miutes:
5

Minutes value is set to 5

Date is set to:
UTC:     2021-09-22 23:01:15 UTC
Local:   2021-09-23 02:01:15 MSK 


Processing...

Description:       Debian 11 (daily build 20210922-773)
Snapshot ID:       snap-06fcd3393cb2e08fb
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-22 05:06:05
Start time (MSK):  2021-09-22 08:06:05
There is no tags

Description:       Debian sid (daily build 20210922-773)
Snapshot ID:       snap-03a604a049155c31c
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-22 05:15:37
Start time (MSK):  2021-09-22 08:15:37
There is no tags

Description:       Debian 10-backports (daily build 20210922-773)
Snapshot ID:       snap-08626de7298184227
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-22 05:19:34
Start time (MSK):  2021-09-22 08:19:34
There is no tags

Description:       Debian 11 (daily build 20210922-773)
Snapshot ID:       snap-0ee1e6eb1455a1724
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-22 05:22:23
Start time (MSK):  2021-09-22 08:22:23
There is no tags

Description:       Debian 10 (daily build 20210922-773)
Snapshot ID:       snap-0a5ee15a33ac1786a
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-09-22 05:38:39
Start time (MSK):  2021-09-22 08:38:39
There is no tags

Date was set to:
UTC:     2021-09-22 23:01:17 UTC
Local:   2021-09-23 02:01:17 MSK

Copy a snapshot?
no

Copying cancelled.
```

* Second example is with pre-set of options and copy operation used.

Input:
```
bash script.sh -r eu-central-1 -d0 -h9 -m28 -o 903794441882 -l5
```
Output:
```
You are logged in! Starting script...


Region is set to eu-central-1

Days value is set to 0

Hours value is set to 9

Minutes value is set to 28

Limit value is set to 5

Date is set to:
UTC:     2021-10-13 09:34:22 UTC
Local:   2021-10-13 12:34:22 MSK 


Processing...

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

Description:       Debian 10-backports (daily build 20211013-794)
Snapshot ID:       snap-03b6282ddccdf3378
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-10-13 05:42:09
Start time (MSK):  2021-10-13 08:42:09
There is no tags

Description:       Debian 10 (daily build 20211013-794)
Snapshot ID:       snap-0066b3daf33049ee4
OwnerID:           903794441882
Volume size:       8 GiB 
Start time (UTC):  2021-10-13 05:58:23
Start time (MSK):  2021-10-13 08:58:23
There is no tags

Date was set to:
UTC:     2021-10-13 09:34:24 UTC
Local:   2021-10-13 12:34:24 MSK

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