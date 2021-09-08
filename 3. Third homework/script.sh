#!/bin/bash

	Help()
	{
		echo '	_____________________________________________________________________________________		'
		echo ''
		echo '	This script is used to read information about where is your processes connected to.'
		echo '	You can enter a process name or its PID using -n option.'
		echo '	You also can enable additional information about amount of connections, its types'
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

	Error()
	{
			echo | tee -a log.txt
			echo $now' Error: Incorrect option' | tee -a log.txt
			echo
	}

	# Header of the script output

	Header()
	{
		echo "______________________________________________________________________________________________"
		echo
		echo "Information from WHOIS about $ip1:"
		echo
	}

	# Field of additional information about IP
	
	Additional()
	{
		echo 'Additional information:'
		echo
		echo 'Netid:	State:	Local Address:		Peer Address:		Process:'
		ss -p dst $ip1 | awk -v OFS='\t' '{print $1,$2,$5,$6,$7}' | grep -v "Netid"
		echo
	}

	# Grep error

	Gerror()
	{
		echo -e '\033[0;31mThere is no information about "'$pa2'" for this IP adress.\033[0m'
	}

	# Default options

pa=$(echo "netname,address,country")
sa="5"

while getopts "as:p:n:h" option; do
	case $option in
	h)
		Help
		exit;;
	n)
		#PID or process name
		na=$OPTARG
		;;
	p)
		#Selected data from whois
		pa=$OPTARG
		;;
	s)
		#Amount of IP connections to selected process
        sa=$OPTARG
        ;;
	a)	
		#Additional info from ss about socket connections
		a="True"
		;;
    *)
		Error
		exit;;
	esac
done

	# Counts the actual amount of connections

sa=$(ss -ptua | awk '/'$na'/ {print $6}' | grep -oP '(\d+\.){3}\d+' | grep -v '0.0.0.0' | tail -n$sa | wc -l)

while [ $sa -gt 0 ]
	do
	p1=$(ss -ptua | awk '/'$na'/ {print $6}' | grep -oP '(\d+\.){3}\d+' | grep -v '0.0.0.0' |\
	sort | uniq -c | sort -r | grep -m$sa -oP '(\d+\.){3}\d+' | tail -1)
    whois $ip1 > cache
		if [ "$pa" == "all" ];
			then
			Header
			cat ./cache
			echo
		else
			Header
			p=$(echo $pa | sed -e 's#,# #g' | wc -w)
			while [ $p -gt 0 ]
                do
                pa2=$(echo $pa | sed -e 's#,# #g' | awk '{print $'$p''})
                cat ./cache.txt | grep -i $pa2
                if [ "$?" == "1" ]
				    then
				    Gerror
			    fi
                ((p--))
			done
			echo
		fi
		if [ "$a" == "True" ];
			then
			Additional
		fi
	((sa--))
done
rm ./cache