#!/bin/bash
###########
###################################################################################################################################
## This is Just a small snippet to Check the current SMBD Connections Running on the Particulat samba server                     ##
## you can setup a cron to send an e-mail to Mail DL to check and take the further action accordingly!                           ##
## Author : Karn Kumar (Created on 05/11/2022)                                                                                   ##
## Version: 1.0                                                                                                                  ##
## Email: karn.itguy@gmail.com                                                                                                   ##
###################################################################################################################################
# Check the ESTABLISHED SMBD connections on the SAMBA Server.
##################################################################################################################################
read -rsp $'Please Enter password below: ' SSHPASS
echo -n  ""
export SSHPASS
echo ""
read -rsp $'Please Enter your hostFile name: ' target_File
echo $target_File
###################################################################################################################################
printf "\n"
marker=$(printf "%0.s-" {1..108})
printf "|$marker|\n"
printf "| %-107s|\n"  "                               Java Runtime  Status                                    "
printf "|$marker|\n"
#printf "| %-107s|\n"
printf "| %-32s | %-15s | %-35s | %-15s |\n"  "Hostname" "RedHat Vesrion" "Java Vendor Name" "Java Pkg Name"
printf "|$marker|\n"
remote_collect() {
    ######## color distiction variable ##########
    NC=$'\033[0m'
    RD=$'\033[0;31m'
    BL=$'\033[0;34m'
    GN=$'\033[0;32m'
    #############################################
    target_host=$1
    #read -rsp $'Please hostfile: ' target_File
    {
        read -r rhelInfo
        read -r java_ven
        read -r java_run
    } < <(
          sshpass -e ssh -q -t "${target_host}" \
              -o StrictHostKeyChecking=no -o ConnectTimeout=120 \
              /bin/bash <<-EOF
              cat /etc/redhat-release | awk 'END{print \$7}'
              #/bin/java -XshowSettings 2>&1 | awk "/java.vendor =/"
             java -XshowSettings 2>&1 | awk "/java.vendor =/"|cut -d"=" -f2
             java -version 2>&1| grep "Runtime"|cut -d" " -f1
EOF
          ) 2>/dev/null

         if [[ $? -eq 0 ]] ;then
              printf "| %-32s | %-15s | %-35s | %-15s |\n" "${target_host}" "${rhelInfo}" "${java_ven}" "${java_run}"
         else
              # Use parameter expansion
              printf "| %-32s | %-15s | %-35s | %-15s |\n" "${target_host}" "${rhelInfo:-nologin}" "${java_ven:-None}" "${java_run:-None}"
         fi

} 2>/dev/null
export -f remote_collect
< "$target_File"  xargs -P100 -n1 -d'\n' bash -c 'remote_collect "$@"' --
printf "|$marker|\n"
unset SSHPASS
