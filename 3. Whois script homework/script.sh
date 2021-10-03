#!/bin/bash
		Help()
		{
			echo '	_____________________________________________________________________________________		'
			echo ''
			echo 'This script is used to read information about where is your processes connected to.'
			echo 'You can enter a process name or its PID using -n option.'
			echo 'You also can enable displaying of the additional information about amount of connections, its types'
			echo 'status info, local address and peer info. '
			echo ''
			echo 'Options by default:'
			echo '-n -- not specified. All of the IP addresses of the all processes will be displayed. '
			echo '-p -- "organization,netname". You can enter anything in any order, but follow the same syntax.'
			echo '-s -- 5. 5 connections will be displayed. You can choose any amount.'
			echo '-a -- additional info will not be displayed by default.'
			echo ''
			echo 'Options:'
			echo '-n -- process name or ist PID'
			echo '-p -- paragraphs from whois which you want to be displayed about the IP address that chosen process using.'
			echo '-s -- the amount of connections which will be displayed for organizations. And for all connections if -a flag is present'
			echo 'You can choose any amount, but script will display not more than actual connections is present.'
			echo '-f -- filter by state, must be specified as for the ss: established, syn-sent, syn-recv, fin-wait-1, fin-wait-2, time-wait, closed, close-wait, last-ack, listening and closing '
			echo '-a -- display all connections even without organization info from whois'
			echo '	_____________________________________________________________________________________'
			echo
		}
	# Error message about the option
		Error()
		{
			printf '\033[1;31m Error! Incorrect option\033[0m\n\n'
		}
	# Checking for the s-option argument
		Serror()
		{
			echo $sa | grep -q -i '[a-z]' && { printf '\n\033[1;31m Error! Incorrect option: "'$sa'" is not a number.\033[0m\n\n'; exit; }
		}
	# Checking for the n-option argument
		Nerror()
		{
			ss -ptua | awk '{print $7}' | grep -iq $na && echo -n ||\
			{ printf '\n\033[1;31m Error! Incorrect option: there is no "'$na'" process.\033[0m\n\n'; exit; }
		}
	# Header of the script output
		Header()
		{
			printf '============================================================\nInformation from whois about '$ip1':\n\n'
		}
	# Field of the additional information about IP
		Additional()
		{
				ss state $state -p dst $ip1 | grep -v "Netid" | grep -q -i -E '[a-z]|[0-9]' && \
				{ echo -e "Information about IP from ss:\n" ;   \
				ss state $state -p dst  $ip1 | awk -v OFS='|' '{print $0}' | grep -v "Netid" | sed -e 's/ [[:digit:]]\s\+[[:digit:]]     //' -e 's/users:((//' -e 's/))//'; } ||\
				{ printf ' Additional information:\n' ;\
				printf '\n\033[0;31mUnfortunately, connection was closed or terminated while script was processing other connections. \nIt may be caused by the ping to whois or process was terminated too. \nNo information from ss to display.\033[0m\n\n'; }
		}
		
	# Checking for the paragraphs in the whois info
		Gerror()
		{
			cat $temp_whois | grep -i ^$pa2 && echo -n ||\
			echo -e '\033[0;31mThere is no information about "'$pa2'" for this IP address.\033[0m'
		}
	# Displaying information about amount of the connections displayed (yeah)
		Counter()
		{
			printf "============================================================\n"
			ca=$(echo $ips | wc -w)			
			ss -ptua state $state | awk '{print $'$qwe'}' | grep -v '0.0.0.0' | grep -q '[0-9]' && \
			{ echo $na | grep -q -i -E '[a-z]|[0-9]' && printf '\033[1;32m Done! Processed '$cc'/'$ca' connections, displayed '$cb'/'$ca' for "'$na'" process and "'$state'" state. \033[0m\n\n' ||\
			printf '\033[1;32m Done! Processed '$cc'/'$ca' connections, displayed '$cb'/'$ca' of all processes and "'$state'" state. \033[0m\n\n'; } || \
			printf '\033[1;31m No connections was found for "'$na'" and "'$state'" state \033[0m\n\n'
		}
		Processing(){
			while [ $p -gt 0 ]
                do
               	 	pa2=$(echo $pa | sed -e 's#,# #g' | awk '{print $'$p''})
					Gerror
                	((p--))
			done
			echo
			cat $temp_whois | grep -i "^organization:" >> $temp_org && ((sb++))
			Additional
		}
	# Default options
sa="5"
cb="0"
qwe="6"
sb="0"
pa=$"organization,netname"
state="all"
org="True"
rm -r /tmp/whois_script.* 2>/dev/null
rm -r /tmp/org_script.* 2>/dev/null
temp_whois=$(mktemp /tmp/whois_script.XXXXXXXXXX)
temp_org=$(mktemp /tmp/org_script.XXXXXXXXXX)
while getopts "as:p:n:hf:a" option; do
	case $option in
	a)
		org="False"
		;;	
	f)
		state=$OPTARG
		qwe="5"
		if [ $state == "all" ] 2>/dev/null
			then qwe="6"
		fi
		;;
	h)
		Help
		exit;;
	# PID or process name
	n)
		na=$OPTARG
		Nerror
		;;
	# Selected data from whois
	p)
		pa=$OPTARG
		;;
	# Amount of IP connections to selected process
	s)
        sa=$OPTARG
		Serror
		;;
	# Additional info from ss about socket connections
    *)
		Error
		exit;;
	esac
done
	# Counting the real amount of the IP adresses that in use by the process
ips=$(ss -ptua state $state | grep -i ''$na''| awk '{print $'$qwe'}' | grep -oP '(\d+\.){3}\d+' | sort | uniq -c | sort -r |\
awk '{print $2}' | grep -v '0.0.0.0')
ca=$(echo $ips | wc -w)
	# Processing the information about the IP address
while [ $ca -gt 0 ] && [ $sb -ne $sa ]
	do
	ip1=$(echo $ips | awk '{NF='$ca'}1' | awk '{print $'$ca'}')
    whois $ip1 > $temp_whois 
	# Checking for paragraphs chosen
			if [ "$pa" == "all" ];
				then
					if [ $org == "True" ]
					then 
						cat $temp_whois | grep -iq "^organization:" && \
						{ Header;	cat $temp_whois | grep -i "^.*:"; ((cb++)); cat $temp_whois | grep -i "^organization:" >> $temp_org && ((sb++)); echo; Additional; } || echo -n
					else
						Header
						cat $temp_whois | grep -iq "^organization:"
						echo
						Additional			
						((cb++))
						((sb++))
			fi
		else
			p=$(echo $pa | sed -e 's#,# #g' | wc -w)	
	# Checking for errors in paragraps requests, responding with error if failed
			if [ $org == "True" ] 2>/dev/null
				then 
					cat $temp_whois | grep -iq "^organization:" && \
					{ Header;	Processing; ((cb++)); } || echo -n
				else
					Header
					Processing
					((cb++))
					((sb++))
			fi
		fi
	((cc++))
	((ca--))
done
Counter
echo "Results for organization field:"
echo
echo "======================================"
echo -e "№ Conn:\tOrganization name:"
echo
cat $temp_org | grep -iq "organization" && \
{ cat $temp_org  | sed -e 's/organization:   //iI'| sort | uniq -c | sort -nr -k1,1; echo; } ||\
echo -e "\033[1;31mThere is no organizations was found.\033[0m\n" 
echo "======================================"
echo
trap "rm -- $temp_whois && rm -- $temp_org" exit
exit