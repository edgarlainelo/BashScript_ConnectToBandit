#!/bin/bash


#Function that connects to local sqlite database file
get_pswd(){



ssh  edgar@192.168.1.152 << EOF| tail -n 1
cd databases

pswd_sql=\$(sqlite3 bandit.db "SELECT pswd FROM passwords WHERE levelTo = $1;") 

echo \$pswd_sql

EOF

}

#Variable that stores input from the user
pswd_input=""

read -p "Select Level: " pswd_input


#Exucting function to retrive the password for bandit level
pswd=$(get_pswd $pswd_input)

#Connecting to bandit level
sshpass -p "$pswd" ssh bandit.labs.overthewire.org -p 2220 -l bandit$pswd_input
