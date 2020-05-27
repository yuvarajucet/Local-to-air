#!/bin/bash
clear

yellow='\033[1;33m'
nc='\033[0m'
red='\033[0;31m'
blue='\033[0;34m'
nono='\033[0;35m'
green='\033[0;32m'

banner()
{
echo "
'||'                              '||     |''||''|                |     '||' '||''|.   
 ||         ...     ....   ....    ||        ||      ...         |||     ||   ||   ||  
 ||       .|  '|. .|   '' '' .||   ||        ||    .|  '|.      |  ||    ||   ||''|'   
 ||       ||   || ||      .|' ||   ||        ||    ||   ||     .''''|.   ||   ||   |.  
.||.....|  '|..|'  '|...' '|..'|' .||.      .||.    '|..|'    .|.  .||. .||. .||.  '|' 
                                                                                       

					Code : yuvi_white_hat
					Email : publictechnic@gmail.com
"
}

#Chekcing Dependecnceiess..
checkdependence()
{
	#PHP check
	echo -e "${yellow}[?] ${nc}Checking PHP..."
	which php > /dev/null 2>&1
	if [ "$?" -eq "0" ]; 	then 
		sleep 1
		echo -e "${green}[+]${nc} PHP Found......"
	else
		echo -e "${red}[-] ${nc}PHP Not Found...."
		echo -e "${yellow}[!] ${nc}You want to install(Y/N)?"
		read op
		if [ "$op" == "Y" ];then
			apt-get install php
		elif [ "$op" == "y" ];then
			apt-get install php
		fi
	fi
	#python check
	sleep 1
	echo -e "${yellow}[?] ${nc}Checking python3..."
	which python3 > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
		sleep 1
		echo -e "${green}[+]${nc} Python Found..."
	else
		echo -e "${red}[-] ${nc}Python Not Found..."
		echo -e "${yellow}[!] ${nc}You want to install(Y/N)?"
		read op
		if [ "$op" == "Y" ]; then
			apt-get install python3 
		elif [ "$op" == "y" ];then
			apt-get install python3
		fi
	fi
	sleep 1
	#ngrok check
	echo -e "${yellow}[?] ${nc}Checking Ngrok..."
	if [[ -e ngrok ]]; then
		sleep 1
		echo -e "${green}[+]${nc} Ngrok Found...."
	else
		printf "\e[1;92m[\e[0m*\e[1;92m] Downloading Ngrok...\n"
		arch=$(uname -a | grep -o 'arm' | head -n1)
		arch2=$(uname -a | grep -o 'Android' | head -n1)
		if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
			command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
			wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

			if [[ -e ngrok-stable-linux-arm.zip ]]; then
				unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
				chmod +x ngrok
				rm -rf ngrok-stable-linux-arm.zip
			else
				printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
				exit 1
			fi
		else
			wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
			if [[ -e ngrok-stable-linux-386.zip ]]; then
				command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
				unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
				chmod +x ngrok
				rm -rf ngrok-stable-linux-386.zip
			else
				printf "\e[1;93m[!] Download error... \e[0m\n"
			exit 1
			fi
		fi
	fi
}

#checking internet connection.....
checkinternet() 
{
	ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo -e "${green}[+] ${yellow}Checking For Internet:${green} CONNECTED" || echo -e "${red}[-] ${yellow}Checking For Internet: ${red}FAILED\n${red}[-] ${yellow}This Script Needs An Active Internet Connection\n${red}[-] ${yellow}Local To AIR Exiting.."
    sleep 2
  
}

permission()
{
	echo 
	echo -e "${yellow}[+]${nc} Select Method"
	echo -e "${yellow}1.${blue} File Host\n${yellow}2.${blue} Website Host (include PHP)"
	read op
	echo -e "${yellow}[?]${nc}Start the server(Y/N)"
	read st
	if [ "$st" == "Y" -a "$op" == '1' ]; then
		xterm -T "Python Server" -geometry -0+0 -bg "black" -fg "green" -e python3 -m http.server 1234 | xterm -T "Ngrok Server" -geometry +0-0  -bg "black" -fg "green" -e ./ngrok http 1234 
	elif [ "$st" == "y" -a "$op" == '1' ]; then
		xterm -T "Python Server" -geometry -0+0 -bg "black" -fg "green" -e python3 -m http.server 1234 | xterm -T "Ngrok Server" -geometry +0-0  -bg "black" -fg "green" -e ./ngrok http 1234 
	elif [ "$st" == "Y" -a "$op" == '2' ]; then
		xterm -T "PHP Server" -bg "black" -geometry +0+0 -fg "green" -e php -S 127.0.0.1:1234 | xterm -T "Ngrok Server" -geometry +0-0  -bg "black" -fg "green" -e ./ngrok http 1234 
	elif [ "$st" == "y" -a "$op" == '2' ]; then
		xterm -T "PHP Server" -bg "black" -geometry +0+0 -fg "green" -e php -S 127.0.0.1:1234 | xterm -T "Ngrok Server" -geometry +0-0  -bg "black" -fg "green" -e ./ngrok http 1234
	elif [ "$st" == "N" ];then
		exit
	elif [ "$st" == "n" ];then
		exit
	fi
}

#functioncalls
banner
sleep 1 
checkinternet
checkdependence
permission


