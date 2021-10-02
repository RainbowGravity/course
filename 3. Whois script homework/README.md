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
* You can filter connections by standard ss filter via ```-f``` flag: established, syn-sent, syn-recv, fin-wait-1, fin-wait-2, time-wait, closed, close-wait, last-ack, listening and closing.
* Help option.

### Options
* -n -- process name or its PID. Case is ignored. 
* -p -- paragraphs from whois which you want to be displayed about the IP address that chosen process using. By default: "netname,address,country". You also can display all information form whois by using this: "-p all".
* -s -- the amount of the IP addresses which will be processed. You can choose any amount, but script will display not more than actual connections is present. By default: 5.
* -f -- filter by state, must be specified as for the ss: established, syn-sent, syn-recv, fin-wait-1, fin-wait-2, time-wait, closed, close-wait, last-ack, listening and closing

### Examples and how to use

1. <b> An example of use</b>: if you want to display 2 connections of the Thunderbird process with the additional information field, you must type: 
```
script.sh  -n thunderbird -s 20 -f established
```
Output: 

```
____________________________________________

 Information from whois about 13.33.246.121:

Country:        US
Country:        US
Address:        410 Terry Ave N.
Address:        1918 8th Ave
NetName:        AT-88-Z
NetName:        AMAZO-CF


Information about IP from ss:

tcp      0         0             192.168.0.31:59268       13.33.246.121:https    "thunderbird",pid=38414,fd=125                                       
tcp      0         0             192.168.0.31:59266       13.33.246.121:https    "thunderbird",pid=38414,fd=124                                       
tcp      0         0             192.168.0.31:59274       13.33.246.121:https    "thunderbird",pid=38414,fd=129                                       
tcp      0         0             192.168.0.31:59270       13.33.246.121:https    "thunderbird",pid=38414,fd=127                                       
tcp      0         0             192.168.0.31:59272       13.33.246.121:https    "thunderbird",pid=38414,fd=128                                       
tcp      0         0             192.168.0.31:59264       13.33.246.121:https    "thunderbird",pid=38414,fd=63                                        
____________________________________________

 Information from whois about 13.33.246.68:

Country:        US
Country:        US
Address:        410 Terry Ave N.
Address:        1918 8th Ave
NetName:        AT-88-Z
NetName:        AMAZO-CF


Information about IP from ss:

tcp      0         0             192.168.0.31:38994       13.33.246.68:https     "thunderbird",pid=38414,fd=121                                       
tcp      0         0             192.168.0.31:38990       13.33.246.68:https     "thunderbird",pid=38414,fd=100                                       
tcp      0         0             192.168.0.31:38992       13.33.246.68:https     "thunderbird",pid=38414,fd=117                                       
tcp      0         0             192.168.0.31:38984       13.33.246.68:https     "thunderbird",pid=38414,fd=67                                        
tcp      0         0             192.168.0.31:38988       13.33.246.68:https     "thunderbird",pid=38414,fd=99                                        
tcp      0         0             192.168.0.31:38986       13.33.246.68:https     "thunderbird",pid=38414,fd=87                                        
____________________________________________

 Information from whois about 209.85.233.109:

Country:        US
Address:        1600 Amphitheatre Parkway
NetName:        GOOGLE


Information about IP from ss:

tcp     0         0             192.168.0.31:58364       209.85.233.109:imaps    "thunderbird",pid=38414,fd=82                                        
tcp     0         0             192.168.0.31:58398       209.85.233.109:imaps    "thunderbird",pid=38414,fd=68                                        
tcp     0         0             192.168.0.31:58380       209.85.233.109:imaps    "thunderbird",pid=38414,fd=83                                        
tcp     0         0             192.168.0.31:58402       209.85.233.109:imaps    "thunderbird",pid=38414,fd=120                                       
tcp     0         0             192.168.0.31:58386       209.85.233.109:imaps    "thunderbird",pid=38414,fd=112                                       
tcp     0         0             192.168.0.31:58368       209.85.233.109:imaps    "thunderbird",pid=38414,fd=89                                        
tcp     0         0             192.168.0.31:58384       209.85.233.109:imaps    "thunderbird",pid=38414,fd=111                                       
tcp     0         0             192.168.0.31:58382       209.85.233.109:imaps    "thunderbird",pid=38414,fd=79                                        
____________________________________________

 Done! Displayed 3/3 connections for "thunderbird" process and "established" state.
```
2. <b> Second example</b>: displaying an information of "organization","city","country" and "descr" paragraphs from whois for the telegram process, but using PID this time:
```
script.sh  -n 39518 -p organization,city,country,descr -s 20 -f all
```
Output:
```
 bash script.sh  -n 39518 -p organization,city,country,descr -s 20 -f all
____________________________________________

 Information from whois about 149.154.167.51:

descr:          Telegram Messenger Network
descr:          Telegram Messenger Amsterdam Network
Country:        NL
country:        GB
City:           Amsterdam
Organization:   RIPE Network Coordination Centre (RIPE)


Information about IP from ss:

tcp   ESTAB 0       0         192.168.0.31:37296   149.154.167.51:https  "telegram-deskto",pid=39518,fd=45
____________________________________________

 Done! Displayed 1/1 connections for "39518" process and "all" state.  
```
### Known issues: 
- [x] Connection may be terminated while the script works, so there will be no information in the additional field. It happens because of the ping to the whois service, so i need to add the error message about it.
- [ ] No error message, when there is no connections to display in case when no process was specified, just ```Done! Displayed 0/0 connections of all processes.``` message in the output.
