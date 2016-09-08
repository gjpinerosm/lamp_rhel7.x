#!/bin/sh

#######################################
# Bash script to install an LAMP stack and PHPMyAdmin plus tweaks. This script is Debian based systems but is modified for RHEL/Centos based systems.
# Original-Based: Written by @AamnahAkram from http://aamnah.com
# Modified: Modified and Written by @clayctux from horulab.com

# In case of any errors (e.g. MySQL) just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################
#######################################
# Is necesary for wget functional in downloads in terminal, modified:  /etc/wgetrc
#
#######################################



#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

VERSION_PiHP='php -v'
# Clear Terminal ann line salt
clear
echo -e "\n  \n"

echo -e "##################################################################################"
echo -e "$Cyan \n Welcome to Script install LAMP in Operative System based in RHEL/Censtos 7.x $Color_Off"
echo -e "##################################################################################"
echo -e "Script version v1.0 - date: 07/09/2016 - From: Bogota, Colombia"
echo -e "License: GPLv2"
echo -e "Modified and Written - Twitter:@clayctux - Email:gjpinerosm@gmail.com "

echo -e "\n  \n"

echo -e "====== ====== ====== "
echo -e "||  || ||  || ||  || "
echo -e "||  || ||  || ||  || "
echo -e "||  || ||  || ||  || "
echo -e "====== ====== ====== "

echo -e "\n \n"
# Update packages and Upgrade system
echo -e "$Cyan \n Update System.. $Color_Off"
sudo yum update -y && sudo yum upgrade -y

## Install HTTP (Apache2)
echo -e "$Cyan \n Install httpd (Apache2) Demon $Color_Off"
sudo yum install httpd apr apr-util httpd-tools mailcap memcached openssl -y
systemctl start httpd.service
systemctl enable httpd.service

# Install available PHP version in repos
# Based: http://tecadmin.net/install-mysql-on-centos-redhat-and-fedora/
#
echo -e "$Cyan \n Install available PHP version in repos by defect ...  $Color_Off"
sudo yum install php php-pear php-gd php-ldap php-odbc php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel php-mysql
echo -e "$Purple \n Available php version is php ... \n $Color_Off"
#php -v
$VERSION_PHP

#######################
# Install Mysql 5.5


echo -e "$Cyan \n Checkin and/or install Mysql 5.5.x.. $Color_Off"
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -Uvh mysql57-community-release-el5-7.noarch.rpm
yum install mysql-community-server -y
echo -e "//////////////////////////////////////////////////"
echo -e " $Cyan \n The Service Mysql is starting now \n $Color_Off "
echo -e "//////////////////////////////////////////////////"
systemctl start mysqld.service

echo -e "//////////////////////////////////////////////////"
echo -e " $Cyan \n The Service Mysql is start now \n $Color_Off "
echo -e "//////////////////////////////////////////////////"

echo -e "$Cyan \n The Service Mysql is status $Color_Off"
systemctl status mysqld.service

echo -e "$Cyan \n The Service Mysql is enabled now $Color_Off"
systemctl enable mysqld.service

## TWEAKS and Settings
# Permissions files and directories in /var/www/html

echo -e "$Cyan \n Permissions for /var/www $Color_Off"
sudo chown -R apache:apache /var/www
echo -e "$Green \n Permissions have been set $Color_Off"

# Enabling Mod Rewrite, required for WordPress permalinks and .htaccess files
#echo -e "$Cyan \n Enabling Modules $Color_Off"
#sudo a2enmod rewrite
#sudo php5enmod mcrypt

# Restart Apache
echo -e "$Cyan \n Reload http (Apache) $Color_Off"
sudo systemctl reload httpd.service
