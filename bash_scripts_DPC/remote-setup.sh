#!/bin/bash
# sending script file and executing script on remote server

USR="devops"

for hosts in `cat hostnames`
do
    echo "################################"
    echo "Connecting to $hosts ...."
    echo 
    echo "Copying script to $hosts ..."
    scp remote-install $USR@$hosts:/tmp
    echo "Script copied to $hosts successfully"
    echo
    echo "Running Script on $hosts"
    ssh $USR@$hosts /tmp/remote-install
    echo "Installation completes on $hosts"

done
