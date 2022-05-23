#!/bin/bash
###################################################################################################################################
## This is Just a small snippet to Check the Critical SAMBA Services and ensure their Running availabity or status and will send ##
## an e-mail to Mail DL to check and take the further action accordingly!                                                        ##
## Author : Karn Kumar (Created on 4/14/2022)                                                                                    ##
## Version: 1.0                                                                                                                  ##
## Email: karn.itguy@gmail.com                                                                                                    ##
###################################################################################################################################
#
# Check the Service Status using systemctl which has an "is-active" subcommand for this.
#
STATUS="$(systemctl is-active smb.service)"
if [ "${STATUS}" = "active" ]; then
    echo "SAMBA Server is running fine"
else
   export MAILTO="groupDL@nxp.com"
   export CC="karn.itguy@gmail.com"
   export SUBJECT="Critical:: SAMBA Service Status $(hostname)"
   export FROM="Mailman@nxp.com"
   export EMAIL_TEMPLATE="
          <html>
            <head>
            <style>
            table, th, td {{font-size:9pt; border:1px solid black; border-collapse:collapse; text-align:left; background-color:LightGray;}} th, td {{padding: 5px;}}
            </style>
            </head>
            <body>
              Dear Team,<br><br>
              SAMBA Service is not running on <strong>$(hostname)</strong> which is Critical for business hence look into it and Fix it Urgently!<br><br>
              You may check the status of the service like: <strong>systemctl status smb.service</strong> , Please take further steps as required!
              <br><br>
              <br><br>
              Kind regards.<br>
              Support Mailman.
            </body>
          </html>"
   (
    echo "Subject: $SUBJECT"
    echo "From: $FROM"
    echo "Cc: $CC"
    echo "To: $MAILTO"
    echo "MIME-Version: 1.0"
    echo "Content-Type: text/html"
    echo "Content-Disposition: inline"
    echo '<HTML><BODY><PRE>'
    echo $EMAIL_TEMPLATE
    echo '</PRE></BODY></HTML>'
   ) | /usr/sbin/sendmail $MAILTO $CC

    exit 1
fi
