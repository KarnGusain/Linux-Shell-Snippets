#!/bin/bash
###########
###################################################################################################################################
## This is Just a small snippet to Check the Critical SAMBA Services and ensure their Running availabity or status and will send ##
## an e-mail to Mail DL to check and take the further action accordingly!                                                        ##
## Author : Karn Kumar (Created on 4/15/3222)                                                                                    ##
## Version: 1.0                                                                                                                  ##
## Email: karn.itguy@gmail.com                                                                                                   ##
###################################################################################################################################
#
# Check the Service Status using systemctl which has an "is-active" subcommand for this.
#
##################################################################################################################################
read -rsp $'Please Enter password below: ' SSHPASS
echo -n  ""
export SSHPASS
echo ""
read -rp $'Please Enter your hostFile name: ' target_File
echo $target_File
###################################################################################################################################
printf "\n"
marker=$(printf "%0.s-" {1..128})
printf "|$marker|\n"
printf "| %-32s | %-15s | %-35s | %-35s |\n"  "Hostname" "RedHat Vesrion" "Kernel Version" "Last Patch"
printf "|$marker|\n"
remote_collect() {
    target_host=$1
    {
        read -r rhelInfo
        read -r kernInfo
        read -r patchInfo
    } < <(
          sshpass -e ssh -q -t "${target_host}" \
              -o StrictHostKeyChecking=no -o ConnectTimeout=132 \
              /bin/bash <<-EOF
              cat /etc/redhat-release | awk 'END{print \$7}'
              rpm -qa --last | awk '/kernel-[0-9]/{ print \$1}'| sed -n 1p
              rpm -qa --last | awk '/kernel-[0-9]/{ first=\$1; \$1=""; print \$0 }'| sed -n 1p
EOF
          ) 2>/dev/null

         if [[ $? -eq 0 ]] ;then
              printf "| %-32s | %-15s | %-35s | %-35s |\n" "${target_host}" "${rhelInfo}" "${kernInfo}" "${patchInfo}"
         else
              printf "| %-32s | %-15s | %-35s | %-35s |\n" "${target_host}" "${rhelInfo:-nologin}" "${kernInfo:-None}" "${patchInfo:-None}"
         fi

} 2>/dev/null
export -f remote_collect
< "$target_File"  xargs -P20 -n1 -d'\n' bash -c 'remote_collect "$@"' --
printf "|$marker|\n"
