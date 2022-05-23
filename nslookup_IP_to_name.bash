#!/bin/bash
###########
###################################################################################################################################
## This is Just a small snippet to Check if the name record of the host exits or not for an IP address  via `nslookup` utility   ##
## Author : Karn Kumar (Created on 4/15/3222)                                                                                    ##
## Version: 1.0                                                                                                                  ##
## Email: karn.itguy@gmail.com                                                                                                   ##
###################################################################################################################################
read -rsp $'Please Enter your hostFile name: ' target_File
echo $target_File
###################################################################################################################################
printf "\n"
marker=$(printf "%0.s-" {1..68})
printf "|$marker|\n"
printf "| %-25s | %-38s |\n" "IP Address" "Hostname"
printf "|$marker|\n"
while read -r host; do
    result=$(nslookup $host | awk '/name = /{print $4}')
    printf "| %-25s | %-38s |\n" "$host" "${result:-no dns record}"
#
# You need to provide file with hostnames
done < "$target_File"
printf "|$marker|\n"
