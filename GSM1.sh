#!/bin/bash

###########################################################################
# START OF OPERATOR SPECIFIC SETTINGS

# If more than one modem is used and they have different operator specific
# settings, move this section to the files for each modem and include the#!/bin/bash

[ -z "$DEVICENAME" ] && tmp=${0##*/} && DEVICENAME=${tmp%%.*}
balance_file="/var/log/smstools/smsd_stats/${DEVICENAME}.balance"
regular_run_cmdfile="/opt/sms/regular_run/${DEVICENAME}.cmdfile"
regular_run_statfile="$2"

# Fix this if a different command is required in your network:
ussd_command="AT+CUSD=1,\"*100#\""

if [ "$1" = "PRE_RUN" ]; then
	echo "$ussd_command" > "$regular_run_cmdfile"
else

	result=""
	if [ -r "$regular_run_statfile" ]; then
		tmp=${ussd_command//\"/\\\"}
		tmp=${tmp//\*/\\*}
		result=$(cat "$regular_run_statfile" | grep "$tmp")
	fi

	echo "$result" > "$balance_file"
fi

exit 0
