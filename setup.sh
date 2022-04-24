#!/bin/bash

# Set email notifcation related details in Auto Script passed in the arguments
sed -i "s/^NOTIFY_TO=.*/NOTIFY_TO='$2'/" /root/auto-rclone-sync/auto.sh
sed -i "s/^FROM=.*/FROM='$3'/" /root/auto-rclone-sync/auto.sh
sed -i "s/^TO=.*/TO='$4'/" /root/auto-rclone-sync/auto.sh
sed -i "s?PATH=.*?PATH=$PATH?" /root/auto-rclone-sync/auto.sh

# Run cron.sh for adding cronjob
bash /root/auto-rclone-sync/cron.sh "$1"

# Install rclone https://rclone.org
curl https://rclone.org/install.sh | bash
wait
