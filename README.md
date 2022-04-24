# auto-rclone-sync
Automate Syncing of Files across rclone remotes and send email notifications.

1) Install and Setup SSMTP on cPanel Server
   [Steps to install and configure SSMTP](https://www.basezap.com/send-an-email-from-cli-using-smtp-in-linux/).

2) Clone this repo in /root directory of the server with directory name auto-rclone-sync using following Command
 
 > git clone https://github.com/TechExihibeo/auto-rclone-sync -b sync+email auto-rclone-sync
 
 or you can use wget to download Zip Archive and Extract.
 
 > wget 'https://github.com/xaksh/auto-rclone-sync/archive/sync+email.zip'

 > unzip -j sync+email.zip -d auto-rclone-sync

3) Run setup.sh with Cron Job Time and email details as arguments.

 > cd auto-rclone-sync

 > source setup.sh "30 5 * * *" "notify@domain.com" "From: Backups<backups@domain.com>" "To: notify@domain.com"

   30 5 * * * = Sync Script will run daily @5:30 AM

   notify@domain.com = Email address where notifications will be sent

   'From: Backups<backups@domain.com>' = Email addresses of the SMTP Sender for setting headers

   'To: notify@domain.com' = Email address of notification reciever for setting headers

   Example: 
 > source setup.sh "30 5 * * *" "sys-admin@basezap.com" "From: Backups<backups@basezap.com>" "To: sys-admin@basezap.com"

4) Run `rclone config` to create remotes and add them in remotes.txt file.

   Example of remotes.txt file:
 > source_gdrive:source_folder destination_gdrive:destination_folder
 > source_gdrive:source_folder destination_s3:destination_folder
 > source_s3:source_folder destination_onedrive:destination_folder
