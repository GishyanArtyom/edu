#!/bin/bash

# This function reads from STDIN. It does some interactiveness to make 
# sure that input is yes or no (case insensitive), and exit from script after 5 try

getandcheckanswer () {

    read answ
    declare -u answ=$answ
    local i=0
    while [ "$answ" != YES -a "$answ" != NO ]
    do
        (( i++ ))
        if [ $i -eq 5 ]
      then
            echo "-_- goodbye -_-"
        exit 0
      fi
        echo -n " type yes or no : "
        read answ
        declare -u answ=$answ
    done
 answer=$answ

}

# This function check that imputed group name is valid (not exists in system)
# Have 5 try, before last try prints out all the group names is system
check () {

    echo -n "enter the group name: "
    read gName
    local i=5
    while getent group $gName> /dev/null
    do
        if [ $i -eq 1 ]
        then
            echo "Please enter valid name"
            echo "Here is the all groups in the system:"
             sleep 1
            cut -d: -f1 /etc/group | nl
            echo -n "Last attempt: "
            read gName
         elif [ $i -eq 0 ]
        then echo "You are kidding. GoodBye.";    exit 0
        else
        echo -n "group \"$gName\" exists try another name: "
        read gName
        fi
      (( i-- ))    
    done
}

# This functions checks that imputed username is not exists in system
# after creates user, makes home directory at /, changes ownership
# for full control for user and group, set the sticky bit, create the password for each user
# requires array of usernames

createusers () {

    for i in $1
    do
        getent passwd $i
        if [ $? -ne 0 ]
        then
            echo "creating user \"$i\"..."
            sudo useradd -s /bin/bash -G $gName -mb / $i
            sudo chown $i:$gName /$i
            sudo chmod g+w,o+t /$i
            sudo passwd $i
          sleep 1    
            echo "user \"$i\" created and added to \"$2\" group"
        else
            echo "user \"$i\" already exists"
        fi
    done

}

echo -n "want to create a new group? yes/no : "

getandcheckanswer

if [ $answer = "YES" ]
then
    check
    echo "creating group \"$gName\"..."
  sudo groupadd $gName
    #echo "group \"$gName\" created"
    getent group $gName
else
    echo "This script now only works when you creating a group"
    exit 0
fi

echo -n "enter the usernames of users separated by tab or space : "
read users

createusers "$users" $gName

return 0

