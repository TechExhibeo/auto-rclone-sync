#!/bin/bash

# Assign values to parameters that will be used in Script
DATE="$(date +%Y-%m-%d)"
NOTIFY_TO=
FROM=
TO=
MID="$(</dev/urandom tr -dc "A-Za-z0-9" | head -c26)"

#Set the PATH variable
export PATH=

echo "~~~~~~~~~~~~~~ Starting Sync ~~~~~~~~~~~~~~"
echo $DATE
start=$SECONDS
cat remotes.txt | while read remote; do
rclone copy $remote > /dev/null 2>> /root/auto-rclone-sync/user.log
wait
if [[ -s /root/auto-rclone-sync/user.log ]]; then
	echo -e "$TO\n$FROM\nMessage-ID: <$MID@bz>\nSubject: Sync Failed\n\n$remote Sync Failed" | ssmtp $NOTIFY_TO
fi
# Update temp.log with user.log
cat /root/auto-rclone-sync/user.log >> /root/auto-rclone-sync/temp.log
# Remove user log file
rm -f /root/auto-rclone-sync/user.log
wait
done
if [[ -s /root/auto-rclone-sync/temp.log ]]; then
        echo -e "$TO\n$FROM\nMessage-ID: <$MID@bz>\nSubject: Sync Failed\n\nFull Sync Failed and Incomplete" | ssmtp $NOTIFY_TO
else
        echo -e "$TO\n$FROM\nMessage-ID: <$MID@bz>\nSubject: Sync Success\n\nFull Sync Success" | ssmtp $NOTIFY_TO
fi
# Update temp.log in back.log and remove temp log file
cat /root/auto-rclone-sync/temp.log >> /root/auto-rclone-sync/backup.log && rm -f /root/auto-rclone-sync/temp.log
echo "~~~~~~~~~~~~~~ Sync Finished ~~~~~~~~~~~~~~"
duration=$(( SECONDS - start ))
echo "Total Time Taken $duration Seconds"

exit
