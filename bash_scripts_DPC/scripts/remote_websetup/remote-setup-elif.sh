#!/bin/bash

# Variable Declaration
URL='https://www.tooplate.com/zip-templates/2098_health'
ART_NAME='2098_health'
TEMPDIR="/tmp/webfiles"

# Check if the system is CentOS or Ubuntu
if [ -n "$(command -v yum)" ]; then
    # CentOS
    PACKAGE="httpd wget unzip"
    SVC="httpd"
    sudo yum install $PACKAGE -y > /dev/null
    sudo systemctl start $SVC
    sudo systemctl enable $SVC
    sudo systemctl restart $SVC
elif [ -n "$(command -v apt-get)" ]; then
    # Ubuntu
    PACKAGE="apache2 wget unzip"
    SVC="apache2"
    sudo apt-get install $PACKAGE -y > /dev/null
    sudo systemctl start apache2
    sudo systemctl enable apache2
    sudo systemctl restart apache2
else
    echo "Unsupported distribution. Exiting."
    exit 1
fi

    # Installing Dependencies
    echo "########################################"
    echo "Installing packages."
    echo "########################################"
    sudo yum install $PACKAGE -y > /dev/null
    echo

    # Start & Enable Service
    echo "########################################"
    echo "Start & Enable HTTPD Service"
    echo "########################################"
    sudo systemctl start $SVC
    sudo systemctl enable $SVC
    echo

    # Creating Temp Directory
    echo "########################################"
    echo "Starting Artifact Deployment"
    echo "########################################"
    mkdir -p $TEMPDIR
    cd $TEMPDIR
    echo

    wget $URL > /dev/null
    unzip $ART_NAME.zip > /dev/null
    sudo cp -r $ART_NAME/* /var/www/html/
    echo

    # Bounce Service
    echo "########################################"
    echo "Restarting HTTPD service"
    echo "########################################"
    systemctl restart $SVC
    echo

    # Clean Up
    echo "########################################"
    echo "Removing Temporary Files"
    echo "########################################"
    rm -rf $TEMPDIR
    echo

    sudo systemctl status $SVC
    ls /var/www/html/