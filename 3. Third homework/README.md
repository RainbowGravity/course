## Bash script for checking process connections
This script is used to read information about the process connections and displaying it with information from whois and the optional information from ss.
### Requierments: 
* Installed Whois
* ss
* Bash

### Features:
* Script can display information from whois about an IP address the chosen process connected to. You can enter the process name or PID.
* Script also can display information about connections of all processes.
* Amount of displayed IP adresses can be specified. 
* You can choose the additional information that will be displayed. There in additional information field is information about protocol, connection status, seed and peer addresses and ports, processes that is connected to that IP.
* Help option.

### Options
* -n -- process name or its PID. Case is ignored. 
* -p -- paragraphs from whois which you want to be displayed about the IP address that chosen process using. By default: "netname,address,country". You also can display all information form whois by using this: "-p all".
* -s -- the amount of the IP addresses which will be processed. You can choose any amount, but script will display not more than actual connections is present. By default: 5.
* -a -- show additional info from ss about the ip address.

### Examples and how to use

1. <b> An example of use</b>: if you want to display 2 connections of the Thunderbird process with the additional information field, you must type: 
```
./script.sh -a -n Thunderbird -s 2
```
Output: 

```
____________________________________________

 Information from whois about 17.42.251.56:

Country:        US
Address:        20400 Stevens Creek Blvd., City Center Bldg 3
NetName:        APPLE-WWNET

 Additional information:

Netid:	State:	Local Address:				Peer Address:				Process:
tcp	ESTAB	192.168.0.28:32774			17.42.251.56:imaps			"thunderbird",pid=2337,fd=83
____________________________________________

 Information from whois about 173.194.222.109:

Country:        US
Address:        1600 Amphitheatre Parkway
NetName:        GOOGLE

 Additional information:

Netid:	State:	Local Address:				Peer Address:				Process:
tcp	ESTAB	192.168.0.28:35546			173.194.222.109:imaps			"thunderbird",pid=2337,fd=85
tcp	ESTAB	192.168.0.28:35574			173.194.222.109:imaps			"thunderbird",pid=2337,fd=41
tcp	ESTAB	192.168.0.28:35576			173.194.222.109:imaps			"thunderbird",pid=2337,fd=77
____________________________________________

 Done! Displayed 2/3 connections for "thunderbird" process. 
```
2. <b> Second example</b>: displaying an information of "organization","city","country" and "descr" paragraphs from whois for the telegram process, but using PID this time:
```
./script.sh -a -n 2290 -p organization,city,country,descr
```
Output:
```
____________________________________________

 Information from whois about 149.154.167.51:

descr:          Telegram Messenger Network
descr:          Telegram Messenger Amsterdam Network
Country:        NL
country:        GB
City:           Amsterdam
Organization:   RIPE Network Coordination Centre (RIPE)

 Additional information:

Netid:	State:	Local Address:				Peer Address:				Process:
tcp	ESTAB	192.168.0.28:40044			149.154.167.51:https			"telegram-deskto",pid=2290,fd=37
____________________________________________

 Done! Displayed 1/1 connections for "2290" process. 
```
### Known issues: 
*  ~~Connection may be terminated while the script works, so there will be no information in the additional field. It happens because of the ping to the whois service, so i need to add the error message about it. ~~
:heavy_check_mark: Fixed 
* No error message, when there is no connections to display in case when no process was specified, just ```Done! Displayed 0/0 connections of all processes.``` message in the output.
