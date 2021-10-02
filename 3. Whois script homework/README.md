## Bash script for checking process connections
This script is used to read information about the process connections and displaying it with information from whois and the information from ss.
### Requierments: 
* Installed Whois
* ss
* Bash

### Features:
* Script can display information from whois about an IP address the chosen process connected to. You can enter the process name or PID.
* Script also can display information about connections of all processes.
* Script can display all processes and selected fields, but in the end there will be only organizations field.
* Amount of displayed connections can be specified. Script will display amount of connections which has been porecessed to find ones with the organization whois field.
* You can filter connections by standard ss filter via ```-f``` flag: established, syn-sent, syn-recv, fin-wait-1, fin-wait-2, time-wait, closed, close-wait, last-ack, listening and closing.
* Help option.

### Options
* <b>-n</b> - process name or its PID. Case is ignored. 
* <b>-p</b> - paragraphs from whois which you want to be displayed about the IP address that chosen process using. By default: "organization,netname". You also can display all information form whois by using this: "-p all".
* <b>-s</b> - the amount of connections which will be displayed for organizations and for all connections if -a flag is present You can choose any amount, but script will display not more than actual connections is present. By default: 5.
* <b>-f</b> - filter by state, must be specified as for the ss: established, syn-sent, syn-recv, fin-wait-1, fin-wait-2, time-wait, closed, close-wait, last-ack, listening and closing
* <b>-a</b> - display all connections even without organization info from whois
### Examples and how to use

1. <b> An example of use</b>: if you want to display 3 connections of the Thunderbird process with the "organization","address","city" you must type: 
```
./script.sh -n thunderbird  -p organization,address,city -s3 -f established
```
Output: 

```
============================================================
Information from whois about 104.18.165.34:

City:           San Francisco
Address:        101 Townsend Street
Organization:   Cloudflare, Inc. (CLOUD14)

Information about IP from ss:

tcp         192.168.0.31:51588     104.18.165.34:https   "thunderbird",pid=55524,fd=82
============================================================
Information from whois about 13.32.142.225:

City:           Seattle
City:           SEATTLE
Address:        410 Terry Ave N.
Address:        1918 8th Ave
Organization:   Amazon Technologies Inc. (AT-88-Z)
Organization:   Amazon.com, Inc. (AMAZON-4)

Information about IP from ss:

tcp         192.168.0.31:55066     13.32.142.225:https   "thunderbird",pid=55524,fd=111
============================================================
Information from whois about 172.67.74.82:

City:           San Francisco
Address:        101 Townsend Street
Organization:   Cloudflare, Inc. (CLOUD14)

Information about IP from ss:

tcp         192.168.0.31:41136     172.67.74.82:https   "thunderbird",pid=55524,fd=79
============================================================
 Done! Processed 6/6 connections, displayed 3/6 for "thunderbird" process and "established" state. 

Results for organization field:

======================================
№ Conn: Organization name:

      2 Cloudflare, Inc. (CLOUD14)
      1 Amazon Technologies Inc. (AT-88-Z)
      1 Amazon.com, Inc. (AMAZON-4)

======================================
```
2. <b> Second example</b>: displaying an information of "organization","address","city" and "country" paragraphs from whois for the chrome process, but using PID this time:
```
./script.sh -n 2998 -p organization,address,city,country -s4 -f established
```
Output:
```
============================================================
Information from whois about 140.82.113.25:

Country:        US
City:           San Francisco
Address:        88 Colin P Kelly Jr Street
Organization:   GitHub, Inc. (GITHU)

Information about IP from ss:

tcp         192.168.0.31:55826     140.82.113.25:https   "chrome",pid=2998,fd=45
============================================================
Information from whois about 151.101.193.69:

Country:        US
City:           San Francisco
Address:        PO Box 78266
Organization:   Fastly (SKYCA-3)

Information about IP from ss:

tcp        192.168.0.31:54430     151.101.193.69:https   "chrome",pid=2998,fd=61
============================================================
Information from whois about 151.101.84.193:

Country:        US
City:           San Francisco
Address:        PO Box 78266
Organization:   Fastly (SKYCA-3)

Information about IP from ss:

tcp        192.168.0.31:36478     151.101.84.193:https   "chrome",pid=2998,fd=100
============================================================
Information from whois about 173.194.222.113:

Country:        US
City:           Mountain View
Address:        1600 Amphitheatre Parkway
Organization:   Google LLC (GOGL)

Information about IP from ss:

tcp       192.168.0.31:53510     173.194.222.113:https   "chrome",pid=2998,fd=42
============================================================
 Done! Processed 17/17 connections, displayed 4/17 for "2998" process and "established" state. 

Results for organization field:

======================================
№ Conn: Organization name:

      2 Fastly (SKYCA-3)
      1 Google LLC (GOGL)
      1 GitHub, Inc. (GITHU)

======================================
```
### Known issues: 
- [x] Connection may be terminated while the script works, so there will be no information in the additional field. It happens because of the ping to the whois service, so i need to add the error message about it.
- [x] No error message, when there is no connections to display in case when no process was specified, just ```Done! Displayed 0/0 connections of all processes.``` message in the output.
