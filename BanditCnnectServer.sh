#!/bin/bash


#Function that connects to local sqlite database file
get_pswd(){

#Connecting to server
ssh  [name_of_server]@[ip_address] << EOF| tail -n 1
cd databases

#Using SQLite getting the password of the level, that user wanted
pswd_sql=\$(sqlite3 bandit.db "SELECT pswd FROM passwords WHERE levelTo = $1;") 

#Echoing password so we can capture it in the future
echo \$pswd_sql

EOF

}

#Variable that stores level input desired from the user
pswd_input=""

#Function that allows user to enter the desired level and stores input in pswd_input variable
read -p "Select Level: " pswd_input


#Exucting function to retrive the password for bandit level, the password is stored into pswd variable
pswd=$(get_pswd $pswd_input)

#Connecting to bandit level
sshpass -p "$pswd" ssh bandit.labs.overthewire.org -p 2220 -l bandit$pswd_input
