#!/bin/bash

: '
	Author: Luke Chikkala

	The bash script logs the system monitor
	messgages of grandMA3 application to a text
	file.

		Log File Location	: ~/Desktop/gMA3_Logs
		File Name Scheme	: <Station Name>_syslog_<Date>_<Time>
		File Name Example	: Luke-MBP_syslog_04-Jun-20_2346

	WARNING: The script has no alert system in place
	to verify whether or not the grandMA3 system is
	online.
'

clear

WHITE='\033[0;37m'
NC='\033[0m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
RED='\033[0;31m'

if [ ! -d ~/Desktop/gMA3_Logs ]; then
  mkdir -p ~/Desktop/gMA3_Logs;
fi

function text_dialog()\
{
	local version=$(osascript << EOT
		tell application "Finder"
			activate
			set response to text returned of (display dialog "First 3 digits of gMA3 Software Version" default answer "1.7.2")
			return response
		end tell
	EOT)

	local IPAddress=$(osascript << EOT
		tell application "Finder"
			activate
			set response to text returned of (display dialog "Station's IP Address" default answer "127.0.0.1")
			return response
		end tell
	EOT)

	local StationName=$(osascript << EOT
		tell application "Finder"
			activate
			set response to text returned of (display dialog "Station's Name" default answer "Luke-MBP")
			return response
		end tell
	EOT)


	local TimeStamp=$(date "+%d-%b-%y_%H%M")

	echo -e "${PURPLE} ╭───────────────────╮"
	echo -e "╭┤${WHITE} Log File Location ${PURPLE}├───────────────────────────────────────╮"
	echo -e "│╰───────────────────╯					     │"
	echo -e "│\t${CYAN}~/Desktop/gMA3_Logs${PURPLE}				     │"
	echo -e "${PURPLE}│╭───────────────────╮			 		     │"
	echo -e "├┤${WHITE} File Name	     ${PURPLE}├───────────────────────────────────────┤"
	echo -e "│╰───────────────────╯					     │"
	echo -e "│${CYAN}\t${StationName}_syslog_$TimeStamp.txt${PURPLE}		     │"
	echo -e "╰────────────────────────────────────────────────────────────╯${NC}"
	echo -e "${RED}╭────────────────────────────────────────────────────────────╮"
	echo -e "│${WHITE}     System Monitor Messages are currently being logged.${RED}    │"
	echo -e "│${WHITE}           To stop logging, press: ${CYAN}control${WHITE}(⌃) + ${CYAN}C${WHITE} ${RED}	     │"
	echo -e "╰────────────────────────────────────────────────────────────╯"
	echo -e "${NC}"
	echo -e "..."

	/Applications/grandMA3.app/Contents/MacOS/gma3_$version/app_terminal "sysmon $IPAddress" > ~/Desktop/gMA3_Logs/${StationName}_syslog_$TimeStamp.txt
}

text_dialog

echo -e '\n'