#!/bin/bash

    Help() {
                echo '_____________________________________________________________________________________		'
                echo ''
                echo 'This script is used to process information about the open pull requests in selected repository.'
                echo ''
                echo 'Repositories can be specified in several ways:'
                echo '1. By Github link "https://github.com/spring-projects/atom-boot-java"'
                echo '2. By entering the user/repository link like "spring-projects/atom-boot-java" '
                echo '3. By searching for user. After user is provided to the script the list of the repos will be displayed.'
                echo ''
                echo 'Options:'
                echo ''
                echo '-p -- page number for script to scan. Required to add because of the API Github limit for 100 PRs per page. Default is 1.'
                echo -e 'To skip this in script use \u001B[1m-pn\u001B[0m for defaults or \u001B[1m-p NUMBER\u001B[0m.'
                echo '-s -- amount of the open PRs per page that will bedisplayed, can be specified from 1 to 100. Default is 1.'
                echo -e 'To skip this in script use \u001B[1m-cn\u001B[0m for defaults or \u001B[1m-c NUMBER\u001B[0m.'
                echo '-t -- Github API token option. If there is no token provided, then maximum API request rate will be limited to 60'
                echo 'per hour. With OAuth token provided the limit will be increased to 5000. '
                echo -e 'To skip in script use \u001B[1m-tn\u001B[0m for no token and \u001B[1m-t YOUR_OAUTH_TOKEN\u001B[0m to provide token.'
                echo '-r -- by this option you can set the link or username to skip questions about it during the script running'
                echo '-a -- display titles for pull requests. '
                echo '-b -- display descriptions of repositories.'
                echo '_____________________________________________________________________________________'
                echo
    }
    # Checking for lines per page arguments
    ArgPerPage(){
        echo $perPage | grep -iq "[a-z]"
        if [ $? -eq 0 ] || [ $perPage -gt 100 ] 2>/dev/null || [ $perPage -lt 1 ] 2>/dev/null
            then
                echo -e "\033[0;31mAn argument for lines per page can't be less than 1 and more than 100 or a letter and will be ignored.\u001B[0m"
                page=""
        fi
    }
    # Checking for page arguments
    ArgPage(){
        echo $page | grep -iq "[a-z]"
        if [ $? -eq 0 ] || [ $perPage -lt 1 ] 2>/dev/null
            then
                echo -e "\033[0;31mAn argument for page can't be less than 1 or a letter and will be ignored.\u001B[0m"
                page=""
        fi
    }
    # Error handler
    Error()
		{
			printf '\033[1;31m Error! Incorrect option\033[0m\n\n'
		}
# Getting arguments
while getopts "t:p:s:r:hab" option; do
	case $option in
	# Additonal info for repositories
    b)
        bdd="True"
        ;;
    # Additional info for user
    a)
        add="True"
        ;;
    h)
		Help
		exit;;
	# Repository name/link argument
    r)
        input=$OPTARG
        skipInput="True"
        ;;
    # Page argument
	p)
        page=$OPTARG
        if [ $page == "n" ]
            then 
                page=""
            else
                ArgPage
        fi
        skipPage="True"
        ;;
    # Line per page argument
    s)
        perPage=$OPTARG
        if [ $perPage == "n" ]
            then 
                perPage=""
            else
                ArgPerPage
        fi
        skipPerPage="True"
        ;;
    # Token argument
    t)
		token=$OPTARG
        if [ $token == "n" ]
            then 
                token=""
        fi
        skipToken="True"
        ;;
    # Error
    *)
		Error
		exit;;
	esac
done
    # Per page lines input function
    PerPage() {
        echo -e "Enter the number of lines per page, default is 30, can't be more than 100:"
        read -e perPage
        echo "========================================================================="
        check=$"0"
        while [ $check -eq 0 ]
        do
            echo $perPage | grep -iq "[a-z]"
                if [ $? -eq 0 ] || [ $perPage -gt 100 ] 2>/dev/null || [ $perPage -lt 1 ] 2>/dev/null
                    then 
                        echo -e "\033[0;31mNumber of lines per page can't be less than 1 and more than 100 or a letter, try again.\u001B[0m"
                        echo -e "\nEnter the number of lines per page, default is 30, can't me more than 100:"
                        read -e perPage
                        echo "========================================================================="
                    else
                        check=$"1"
                fi
        done
    }
    # Page number input function
    Page() {
        echo -e "Enter the page number, default is 1:"
        read -e page
        echo "========================================================================="
        check=$"0"
        while [ $check -eq 0 ]
        do
            echo $page | grep -iq "[a-z]"
                if [ $? -eq 0 ] || [ $page -lt 1 ] 2>/dev/null
                    then 
                        echo -e "\033[0;31mPage number can't be less than 1 or a letter, try again.\u001B[0m"
                        echo -e "\nEnter the page number, default is 1:"
                        read -e page
                        echo "========================================================================="
                    else
                        check=$"1"
                fi
        done
    }
    # Token input function
    TokenInput() {
        echo -e "\nEnter your Github OAuth token, or press enter to work without it:"
        read -e token
        echo "========================================================================="
    }
    # User/link input function
    Input(){
        echo -e "Enter the Github username or link to repository:"
        read -e input
        echo "========================================================================="        
    }
    # Forming standard PRs info output
    StdPRs(){
        b=$(curl -s -H "$auth" "$apiLink" | jq '.pulls_url + "?page='$page'&per_page='$perPage'"' | sed  "s|{.*}||" | xargs curl -s -H "$auth" | \
        jq -r '.[] | "\u001B[1;32m" + .user.login + "\u001B[0m" + "|" + (if (.labels | length) !=0 then .labels | map("\u001b[33m" + .name + "\u001B[0m") | join (", ") else "\u001b[31mThere is no labels\u001B[0m" end ) + "|" + .html_url' )
        table="Nickname:|Labels:|\n\n"
    }
    # Forming all PRs info output
    AllPRs(){
        b=$(curl -s -H "$auth" "$apiLink" | jq '.pulls_url + "?page='$page'&per_page='$perPage'"' | sed  "s|{.*}||" | xargs curl -s -H "$auth" | \
        jq -r '.[] | "\u001B[1;32m" + .user.login + "\u001B[0m" + "|" + .title + "|" + (if (.labels | length) !=0 then .labels | map("\u001b[33m" + .name + "\u001B[0m") | join (", ") else "\u001b[31mThere is no labels\u001B[0m" end ) + "|" + .html_url ' )
        table="Nickname:|Title:|Labels:|Pull request link:\n\n"
    }
    # Forming standard repos info output
    StdREP(){
        b=$(curl -s -H "$auth" "$userLink?page=$page&per_page=$perPage" | jq -r '.[] | "\u001B[1;34m" + .name + "\u001B[0m" + "|" + (.stargazers_count | tostring) ' | sort -nr -t '|' -k2,2)
        tablerep=$"\u001B[1mRepository:|Stars:\u001B[0m\n\n"
    }
    # Forming all repos info output
    AllREP(){
        b=$(curl -s -H "$auth" "$userLink?page=$page&per_page=$perPage" | jq -r '.[] | "\u001B[1;34m" + .name + "\u001B[0m" + "|" + (.stargazers_count | tostring)  + "|" + .description' | sort -nr -t '|' -k2,2)
        tablerep=$"\u001B[1mRepository:|Stars:|Description:\u001B[0m\n\n"
    }
# Checking for token skip
if [ "$skipToken" != "True" ];
    then
        TokenInput
fi
# Checking for token
echo $token | grep -qi "[a-z]\|[0-9]"
if [ $? -eq 1 ];
    # Checking for the remainig requests without token if no token was provided, exit if 0 left. 
    then
        b=$(curl -s -I https://api.github.com/users/octocat | grep -i "x-ratelimit-remaining:" | sed "s/x-ratelimit-//")
        echo $b | grep -iq "remaining: 0" && { echo -e "\n\033[0;31mYou can't work with Github API without OAuth token for now.\033[0m \n\033[0;33mCheck this out: https://docs.github.com/rest/overview/resources-in-the-rest-api#rate-limiting\n\033[0m"; exit;} ||\
        { auth=$""; echo -e "\033[0;33mWorking without Github API OAuth token. Rate limit $b\033[0m\n"; }
    # Checkin for token validaty if token was provided.
    else
        curl --fail -s -H "Authorization: token "$token"" "https://api.github.com" > /dev/null
        if [ $? -ne 22 ];
            # Displaying a message about successfull check.
            then
                auth=$"Authorization: token "$token""; echo -e "\033[0;32mWorking with Github API OAuth token\n\033[0m"
            # Displaying an error message if incorrect token was provided.
            else
                echo -e "\n\033[0;31m401. Incorrect token \033[1;31m$token\033[0;31m. Enter the correct token.\u001B[0m\n"
                exit
        fi
fi
# Checking for input skip
if [ "$skipInput" != "True" ];
    then
        Input
fi
# Removing / at the beginning and at the end of the input
input=$(echo $input | sed -e "s|/$||" -e "s|^/||")
# Checking for the "user/repo" format or for the link
echo $input | egrep -q "github.com/.*/.*|.*/.*"
if [ $? -eq 0 ];
    # Forming the link to the repository if succeded check 
    then
        repoLink=$(echo $input | sed "s|.*github.com/||" ) 
        apiLink=$"https://api.github.com/repos/"$repoLink""
    # Searching for user and forming the link for the repositories to display 
    else
        # Checking for user existance 
        userLink=$"https://api.github.com/users/$input/repos" 
        curl --fail -s -H "$auth" "$userLink" > /dev/null
        if [ $? -ne 22 ]
            # Displaying the list of the repos if user was found
            then
                echo -e "\033[0;32mFound\033[1;32m $input\033[0;32m user!\033[0m\n"
                # Checking for the lines per page skip
                if [ "$skipPerPage" != "True" ];
                    then
                    PerPage
                fi     
                echo $perPage | grep -iq "[0-9]" && echo -n || perPage=$"30"
                # Checking for the page number skip
                if [ "$skipPage" != "True" ];
                    then
                        Page
                fi        
                echo $page | grep -iq "[0-9]" && echo -n || page=$"1"                   
                # Searching for repositories and forming the list of them
                echo -e "\033[0;32mSearching for\033[1;32m $input\033[0;32m repositories...\033[0m\n" 
                # Checking for additional fields
                if [ $bdd == "True" ] 2>/dev/null
                    then
                        AllREP
                    else
                        StdREP
                fi
                # Displaying the list or an error and exiting if no repositories for the user was found
                echo $b | grep -q -i '[a-z]' && \
                echo -e "$tablerep$b" | column -e -t -s "|" ||\
                { echo -e "\u001b[31mThere is no repositories for \033[1;31m$input\033[0;31m to show.\u001B[0m\n"; exit; }
                # Reading the repository name
                echo -e "\nEnter one of the displayed repositories:"
                read -e repoLink
                echo "========================================================================="
                # Forming the links for next stage
                repoLink=$(echo $repoLink | sed -e "s|/$||" -e "s|^/||")  
                apiLink=$"https://api.github.com/repos/$input/$repoLink"
            # Displaying an error message if no user was found and exiting
            else
                echo -e "\n\033[0;31m404. Incorrect username or link \033[1;31m$input\033[0;31m.\u001B[0m\n"
                exit
        fi
fi
# Checking for repository existance
curl --fail -s -H  "$auth" "$apiLink" > /dev/null
if [ $? -ne 22 ];
    then
        echo -e "\033[0;32mFound\033[1;32m $repoLink\033[0;32m repository!\033[0m\n"
        # Checking for the lines per page skip
        if [ "$skipPerPage" != "True" ];
            then
                PerPage
        fi
        echo $perPage | grep -iq "[0-9]" && echo -n || perPage=$"30"
        # Checking for the page number skip
        if [ "$skipPage" != "True" ];
            then
                Page
        fi        
        echo $page | grep -iq "[0-9]" && echo -n || page=$"1"
        # Searching for the most productive contributors and forming the list of them
        echo -e "\033[0;32mWorking on\033[1;32m $repoLink\033[0;32m repository...\033[0m\n" 
        b=$(curl -s -H "$auth" "$apiLink" | jq '.pulls_url + "?page='$page'&per_page='$perPage'"' | sed  "s|{.*}||" | xargs curl -s -H "$auth" | \
        jq -r '.[] | "\u001B[1;32m" + .user.login  + "\u001B[0m" + " " + .user.html_url ' | grep -v null | sort | uniq -dc | sed -e 's| *||'| awk -v OFS='|' '{print $2,$1,$3}' | sort -nr -t '|' -k2,2)
        # Displaying the list of the most productive contributors or an error message if there is no users with more tha 1 PRs 
        echo $b | grep -q -i '[a-z]' && \
        { echo -e "\033[0;32mDone!\033[0m Most productive contributors list:\n";\
        echo -e "Nickname:|Pull requests:|Profile link:\n\n$b" | column -e -t -s "|"; } ||\
        echo -e "\u001b[31mThere is no users with more than 1 pull request on $page page with $perPage per page results.\u001B[0m"  
        echo -e "\n=========================================================================\n"
        # Checking for additional fields
        if [ $add == "True" ] 2>/dev/null
            then
            AllPRs
            else
            StdPRs
        fi
        # Displaying the list of the open pull requests or an error message if there is no open PRs was found 
        echo $b | grep -q -i '[a-z]' && \
        { echo -e "\033[0;32mDone!\033[0m Open pull requests list:\n";\
        echo -e "$table$b" | column -e -t -s "|"; echo; } ||\
        echo -e "\u001b[31mThere is no pull requests in this repository on $page page.\u001B[0m\n"
        
    else
        # Displaying an error message if no repository was found
        echo -e "\n\u001b[31m404. There is no \033[1;31m$repoLink\033[0;31m repository.\u001B[0m\n"
fi
exit