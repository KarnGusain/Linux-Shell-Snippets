#!/bin/bash
###################################################################################################################################
## This is Just a small snippet to Check the host availability based on the ping command which runs in parallel mode while \     ##
## invoking in the background                                                                                                    ##
## Author : Karn Kumar (Created on 4/15/3222)                                                                                    ##
## Version: 1.0                                                                                                                  ##
## Email: karn.itguy@gmail.com                                                                                                   ##
## Last modified: 05/22/2022                                                                                                     ##
###################################################################################################################################
read -rp $'Please Enter your hostFile name: ' target_hostfile
# Don't use variables in the printf format string. Use printf '..%s..' "$(date)".
printf "Starting the Ping Check %s ....\n" "$(date)"
icmp_echo  () {
    target_host=${1}
    ping -c2 "${target_host}"  >/dev/null 2>&1 &&
    printf "%-32s %-10s\n" "host ${target_host}" "ping SUCCESS" ||
    printf "%-32s %-10s\n" "host ${target_host}" "ping FAILED"
}
# Use a while loop and the read command. Where The -r option to read prevents backslash interpretation.By default, i
# read modifies each line read, by removing all leading and trailing whitespace characters (spaces and tabs, if present in IFS).    # If that is not desired, the IFS variable may be cleared
while IFS= read -r line
do
    icmp_echo  "$line" &
# Double quote to prevent globbing and word splitting.
done < "$target_hostfile"
wait
# Don't use variables in the printf format string. Use printf '..%s..' "$(date)".
printf "Completed at: %s" "$(date)"
printf "\n"
