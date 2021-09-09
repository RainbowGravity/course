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

	# Error message about option
		Error()
		{
			echo -e '\033[0;31mError! Incorrect option\033[0m'
			echo
		}

	# Cheching for the s-option argument
		Serror()
		{
			echo $sa | grep -q -i '[a-z]' 
			if [ "$?" == "0" ]
				then 
				echo
				echo -e '\033[0;31mError! Incorrect option: "'$sa'" is not a number.\033[0m'		
				echo
				exit
			fi	
		}

	# Cheching for the n-option argument
		Nerror()
		{
			ss -ptua | awk '{print $7}' | grep -q $na
			if [ "$?" == "1" ]
				then 
				echo
				echo -e '\033[0;31mError! Incorrect option: there is no "'$na'" process.\033[0m'		
				echo
				exit
			fi
		}

	# Header of the script output
		Header()
		{
			echo "____________________________________________"
			echo
			echo "Information from whois about $ip1:"
			echo
		}

	# Field of the additional information about IP
		Additional()
		{
			if [ "$a" == "True" ];
				then
				echo 'Additional information:'
				echo
				echo 'Netid:	State:	Local Address:		Peer Address:		Process:'
				ss -p dst $ip1 | awk -v OFS='\t' '{print $1,$2,$5,$6,$7}' | grep -v "Netid"
				echo
			fi
		}

	# Cheching for the paragraphs in the whois info
		Gerror()
		{
			cat ./cache | grep -i ^$pa2
			if [ "$?" == "1" ]
				then
				echo
				echo -e '\033[0;31mThere is no information about "'$pa2'" for this IP address.\033[0m'
				echo
			fi
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
sa=$(ss -ptua | awk '/'$na'/ {print $6}' | grep -oP '(\d+\.){3}\d+' | grep -v '0.0.0.0' | tail -n$sa | wc -l)


	# Processing the information about the IP address
while [ $sa -gt 0 ]
	do
	ip1=$(ss -ptua | awk '/'$na'/ {print $6}' | grep -oP '(\d+\.){3}\d+' | grep -v '0.0.0.0' |\
	sort | uniq -c | sort -r | grep -m$sa -oP '(\d+\.){3}\d+' | tail -1)
    whois $ip1 > cache
		
	# Checking for the paragraphs chosen
		if [ "$pa" == "all" ];
			then
			Header
			cat ./cache
			echo
		else
			Header
			p=$(echo $pa | sed -e 's#,# #g' | wc -w)
			
	# Checking for errors in the paragraps request, responding with an error if failed
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
	((sa--))
done
rm ./cache 2&> tee /dev/null
