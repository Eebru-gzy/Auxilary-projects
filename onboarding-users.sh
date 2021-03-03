#!/bin/bash

# Created by: Opeyemi Alao
# Date      : 3/03/2021
# Purpose   : Onboarding users and adding to a specific group, then creating an authorize key file for ssh remote login


clear 

#ssh as a variable
ssh=/etc/skel/.ssh


# path to users name file
file=~/names.csv

#Create a group
sudo groupadd developers

#The group as a variable
group='developers'

#the public key as a variable
key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzKZyicHxIkklSrNlxsJyyTrcIdBIt84Z0cQb3R4k0jH53kxkaT5hP8tfWTe62LXi7vV86fY+SX7TBNM76XGCbw/6vrMGegm6J1x2i1AiLNwq5nqTjOGn0AIwku4IlCCLAB7tdfRyVuCarmBlwny3lzRyybIUAWXR/D6vpN09MsDILbKdhay+Q/p9OUBMSLPqXdY/QIh/Oe3rVv1lwY3AohNfq7V3tO88zKswfA5iiexNiSYX1myT0OrX8cBE771j9quoNZhQgaLI1mIMtAvnHQChrn9k2nUaO/BMBCQGol5XzGv1ado7hgoVPoluIUD+FGNo/pH4zcmDLICH6drXY/C9MESnkMUPLFxBXKO/OitApY71vRao9nAhAwpVMsy6FqiOb5uawhvhoHYIHTV/f4EtagVagRMP2PxYMYR6jykIV4MPJTkCm+lGhTyMlRu+qRQjdLn8AAtHf4aEV8dIkoGh088DI7eA/4o0wz4OV4upH5ewSFS+5IHmRECEW5Nc='



# populate skel directory with ssh folder and authorized_keys file
if [ -d "$ssh" ] ;
then
    echo
    echo "ssh folder already exist."
    echo
else
    sudo mkdir -p $ssh
    sudo bash -c "echo $key >> $ssh/authorized_keys"
    echo "$ssh directory is now created and ready for use"
    echo
fi


while read user
    do
        # check if user already exists
        if [ $(getent passwd $user) ] ;  
        then
            echo " This user - $user already exists."
            echo
        else
            #create user
            sudo useradd -g $group -s /bin/bash -m -d "/home/$user" $user
            echo
            echo "User with username: $user created..."
            echo 
        fi
        done < $file 
        echo "20 users created successfully."
