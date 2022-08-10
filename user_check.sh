# Runs once every hour (see the crontab entry elsewhere in this repo).
# Takes the output of the contents of /etc/passwd and converts it to an MD5 hash.
# Stores the current MD5 hash into the /var/log/current_users file.
# On subsequent runs, if the MD5 sum changes, it logs the change in the /var/log/user_changes log file with the message, DATE TIME changes occurred,
# ...replacing DATE and TIME with appropriate values. It also replaces the old MD5 hash in /var/log/current_users file with the new MD5 hash.

#!/bin/bash

ROOT_UID=0     # Only users with $UID 0 have root privileges.
E_NOTROOT=87   # Non-root exit error.

# Run as root
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi  

# Test if the current MD5 hash of the reference file matches the contents of the target file
if grep -q $(awk -F ":" '{OFS=":"} {print $1, $7}' /etc/passwd | md5sum | awk '{print $1}') /var/log/current_users
then 
	# Colon, i.e. do nothing.
	:
	# Use echo for debugging purposes
	#echo "No changes in the MD5 hash of the reference file." >&2
# Else, log the current date and time, and update the contents of the target file with the MD5 hash of the reference file
else   
	# Use echo for debugging purposes
	#echo "The MD5 hash of the reference file has changed. Updating the target file." >&2
	# Log the current date and time as well as the message
	echo $(date +%Y-%m-%d)" "$(date +%H:%M:%S:%N)" changes occurred" >> /var/log/user_changes
	# Update the target file
	awk -F ":" '{OFS=":"} {print $1, $7}' /etc/passwd | md5sum | awk '{print $1}' > /var/log/current_users
fi
