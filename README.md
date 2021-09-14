# How_to_print_all_usernames_on_system
Print usernames of all users on a Linux system together with their home directories and some extra features:

● Runs once every hour. 

● Takes the output of your above script and converts it to an MD5 hash. 

● Stores the MD5 hash into the /var/log/current_users file. 

● On subsequent runs, if the MD5 sum changes, it should log this change in the /var/log/user_changes file with the message, DATE TIME changes occurred, replacing DATE and TIME with appropriate values. Make sure to replace the old MD5 hash in /var/log/current_users file with the new MD5 hash.
