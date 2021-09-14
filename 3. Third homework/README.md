## Bash script for checking process connections
Script works fine by now, need some time to think about the readme.
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
Example of use: if you want to display 7 connections of the Chrome process with the additional information field, you must type: 
```./script.sh -a -n chrome -s 7```
Output: 
