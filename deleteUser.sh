#!/bin/bash

file=~/names.csv

sudo rm -r /etc/skel/.ssh
echo
echo '.ssh folder deleted'
echo

while read user
  do 	sudo userdel $user
	  sudo rm -r /home/$user
  done < $file
echo deleted users successfully

sudo groupdel developers
echo
echo 'developers group deleted successfully'
