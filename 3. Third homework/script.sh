#!/bin/bash
		Help()
		{
			echo '	_____________________________________________________________________________________		'
			echo ''
			echo '	This script is used to read information about where is your processes connected to.'
			echo '	You can enter a process name or its PID using -n option.'
			echo '	You also can enable displaying of the additional information about amount of connections, its types'
			echo '	status info, local address and peer info. '
			echo '	'
			echo '	Options by default:'
			echo '	-n -- not specified. All of the IP addresses of the all processes will be displayed. '
			echo '	-p -- "netname,address,country". You can enter anything in any order, but follow the same syntax.'
			echo '	-s -- 5. Last 5 adresses will be processed. You can choose any amount. (Maybe not really any)'
			echo '	-a -- additional info will not be displayed by default.'
			echo '	'
			echo '	Options:'
			echo '	-n -- process name or ist PID'
			echo '	-p -- paragraphs from whois which you want to be displayed about the IP address that chosen process using.'
			echo '	-s -- the amount of the IP addresses which will be processed. You can choose any amount, but script will display not more than actual connections is present.'
			echo '	-a -- show additional info from ss about the ip address.'
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
			printf '____________________________________________\n\n Information from whois about '$ip1':\n\n'
		}
	# Field of the additional information about IP
		Additional()
		{
			if [ "$a" == "True" ];
				then
				printf ' Additional information:\n\nNetid:	State:	Local Address:				Peer Address:				Process:\n' 
				ss -p dst $ip1 | awk -v OFS='\t' '{print $1,$2,$5,"\t",$6,"\t",$7}' | grep -v "Netid" | sed -e 's/users:((//' -e 's/))//'
			fi
		}
	# Checking for the paragraphs in the whois info
		Gerror()
		{
			cat ./cache | grep -i ^$pa2 && echo -n ||\
			echo -e '\033[0;31mThere is no information about "'$pa2'" for this IP address.\033[0m'
		}
	# Displaying information about amount of the connections displayed (yeah)
		Counter()
		{
			printf "____________________________________________\n\n"
			ca=$(echo $ips | wc -w)
			sa=$(echo $ips | awk '{NF='$sa'}1' | wc -w)
			echo $na | grep -q -i -E '[a-z]|[0-9]' && printf '\033[1;32m Done! Displayed '$sa'/'$ca' connections for "'$na'" process. \033[0m\n\n' ||\
			printf '\033[1;32m Done! Displayed '$sa'/'$ca' connections of all processes. \033[0m\n\n'
		}
	# Default options
pa=$(echo "netname,address,country")
sa="5"
while getopts "as:p:n:h" option; do
	case $option in
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
	a)
		a="True"
		;;
    *)
		Error
		exit;;
	esac
done
	# Counting the real amount of the IP adresses that in use by the process
ips=$(ss -ptua | grep -i ''$na''| awk '{print $6}' | grep -oP '(\d+\.){3}\d+' | sort | uniq -c | sort -r |\
awk '{print $2}' | grep -v '0.0.0.0')
ca=$(echo $ips | awk '{NF='$sa'}1' | wc -w)

	# Processing the information about the IP address
while [ $ca -gt 0 ]
	do
	ip1=$(echo $ips | awk '{NF='$sa'}1' | awk '{print $'$ca'}')
    whois $ip1 > cache 
	# Checking for paragraphs chosen
		if [ "$pa" == "all" ];
			then
			Header
			cat ./cache
			echo
		else
			Header
			p=$(echo $pa | sed -e 's#,# #g' | wc -w)	
	# Checking for errors in paragraps requests, responding with error if failed
			while [ $p -gt 0 ]
                do
                pa2=$(echo $pa | sed -e 's#,# #g' | awk '{print $'$p''})
				Gerror
                ((p--))
			done
			echo
		fi
	# Calling the function that will be display or not the additional info
		Additional
	((ca--))
done
Counter
rm ./cache 2> /dev/null
