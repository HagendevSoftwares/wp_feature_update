#!/bin/bash

##################################################################
#----------------------------------------------------------------#
# Script Name: mysql_install_remove.sh                           #
#----------------------------------------------------------------#
# Description: Program performs the installation and             #
# complete removal of the mysql adn mariadb                      #
# version informed in the case                                   #
#----------------------------------------------------------------#
# Site: https://hagen.dev.br                                     #
#----------------------------------------------------------------#
# Author: João Pedro Hagen <joaopedro@hagen.dev.br>              #
# ---------------------------------------------------------------#
# History:                                                       #
#   V1.0.1 2022-11-11                                            #
#       -Initial release. Installing,                            #
#        repairing and removing mysql                            #
#   V1.1.1 2022-11-15                                            #
#       -Included MariaDB 10.1 installation                      #
#   V1.2.1 2022-11-16                                            #
#       -Included any version MariaDB installation               #
#   V1.2.2 2022-11-16                                            #
#        -Fix erros in mariadb version                           #
#----------------------------------------------------------------#

echo
echo
echo
echo "#########################################################"
echo "#-------------------------------------------------------#"
echo "#                     WARNING!!!                        #"
echo "#                                                       #"
echo "# 1º) Take a snapshot of your server                    #"
echo "#                                                       #"
echo "# 2º) Dump all server databases and store in a secure   #"
echo "# directory                                             #"
echo "#                                                       #"
echo "#-------------------------------------------------------#"
echo "#########################################################"

echo 
sleep 3
echo


echo " ==================================================== "
echo "||--------------------------------------------------||"
echo "||        This program installs and removes         ||"
echo "||                mysql and mariadb.                ||"
echo "||                                                  ||"
echo "|| Select an option:                                ||"
echo "||                                                  ||"
echo "|| 1 = Remove Mysql and MariaDB                     ||"
echo "|| 2 = Install Mysql 5.7 or 5.6                     ||"
echo "|| 3 = Install MariaDB any version                  ||"
echo "|| 4 = Quit                                         ||"
echo "||--------------------------------------------------||"
echo " ==================================================== "

echo
sleep 3
echo

echo -n "Enter the option: "
    read NUM_SELECT


#Beginning of the code, where the user chooses the option to remove or install

case "$NUM_SELECT" in

    1) 
        echo -n "Are you sure you want to remove MySQL?  Yes|No: "
        read YES_NO
        
        echo
        echo

            case "$YES_NO" in

                no|No|NO|N|n)
                
                    sleep 3
        
                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."
        
                    echo
                    echo
                    echo

                        ./mysql_install_remove.sh
            ;;

                yes|Yes|YES|Y|y)
                    
                    echo "WARNING!!!!!!!"
                    echo
                    echo
                    echo -n "Have you already done mysqldump? yes|no: "
                    read MYSQLDUMPS

                        case "$MYSQLDUMPS" in

                            no|No|NO|n|N)
                                
                                echo "SO DO IT !!!!!"
                                sleep 5
                                exit
                            ;;

                            yes|Yes|YES|Y|y)

                                echo "Uninstalling"
                                echo
                                echo
                                echo "God help you if you haven't done mysqldump..."
                                echo
                                echo
                                sleep 5

                                rm -fr /etc/apt/sources.list.d/mariadb.list*; #removes the file mariadb.list
                                rm -fr /etc/apt/sources.list.d/mysql.list*; #removes the file mysql.list
                                systemctl stop mariadb; #stoped the mariadb process
                                systemctl stop mysql;  #stoped the mysql process
                                apt-get purge mariadb*; ##remove mysql software and yours configuration files
                                apt-get purge mysql*; #remove mysql software and yours configuration files
                                apt remove galera-4;
                                apt remove galera-3;
                                apt purge mysql-community-server; 
                                apt-get clean; #removes everything except lock files from directories
                                apt-get autoremove; #remove orphaned packages
                                apt-get update; apt-get upgrade; #atualiza a lista de pacotes
                                apt-get install -f; #try to fix the package dependencies
                                systemctl stop mariadb; #stoped the mariadb process
                                systemctl stop mysql; #stoped the mysql process
                            ;;

                            *)

                                echo "invalid answer"
                                echo
                                echo
        
                                echo -n "Returning to the main menu"
        
                                echo -n "."
                                sleep 2
                                echo -n "."
                                sleep 2
                                echo "."
        
                                echo
                                echo
                                echo

                                    ./mysql_install_remove.sh
                            ;;

                        esac

                    echo
                    echo
                    echo
        
                    echo -n "Finishing Uninstall"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."
        
                    echo
                    echo
        
                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."
        
                    echo
                    echo
                    echo

                        ./mysql_install_remove.sh
            ;;

                *)
                
                    echo "Command not found!"
        
                    echo
                    echo
        
                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."

                    echo
                    echo
                    echo
        
                        ./mysql_install_remove.sh
            ;;
            esac
;;

    2)
        echo -n "Are you sure you want to install MySQL?  Yes|No: "
        read YES_NO
        
        echo
        echo
            
            case "$YES_NO" in
                
                no|No|NO|n|N)

                    sleep 3
        
                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."
        
                    echo
                    echo
                    echo

                        ./mysql_install_remove.sh
            ;;

                yes|Yes|YES|Y|y)

                    echo "WARNING"
                    sleep 2
                    echo
                    echo "It is recommended to uninstall all older versions of MySQL or MariaDB."
                    echo
                    sleep 2
                    echo
                    read -p "Which version do you want to install? (Example: 5.7 or 5.6) :" VERSION_MYSQL

                        case "$VERSION_MYSQL" in
                            
                            # downloads and installs the repository and mysql

                            5.7) 

                                apt update;
                                apt-get install -y mysql-server;
                                sleep 3;
                                systemctl start mysql;
                                systemctl enable mysql;
                            ;;

                            5.6)
                            
                                wget https://dev.mysql.com/get/mysql-apt-config_0.8.0-1_all.deb;
                                dpkg -i mysql-apt-config_0.8.0-1_all.deb;
                                apt-get update
                                apt install mysql-client mysql-server;
                                sleep 3;
                                systemctl start mysql;
                                systemctl enable mysql;
                                rm -rf mysql-apt-config_0.8.0-1_all.deb;
                            ;;

                            *)

                                echo "This version you will have to install manually (if it exists) ¬¬"
                                
                                echo
                                echo

                                echo -n "Returning to the main menu"
        
                                echo -n "."
                                sleep 2
                                echo -n "."
                                sleep 2
                                echo -n "."
        
                                echo
                                echo
                                echo

                                    ./mysql_install_remove.sh
                        esac

                    echo -n "Installation completed"

                    echo
                    echo

                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo -n "."
        
                    echo
                    echo
                    echo

                        ./mysql_install_remove.sh
            ;;

                *)
                
                    echo "Command not found!"
        
                    echo
                    echo
        
                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."

                    echo
                    echo
                    echo
        
                        ./mysql_install_remove.sh
            ;;
            esac
;;

    3)
        echo -n "Are you sure you want to install MariaDB?  Yes|No: "
        read YES_NO
        
        echo
        echo
            
            case "$YES_NO" in
                
                no|No|NO|n|N)

                    sleep 3
        
                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."
        
                    echo
                    echo
                    echo

                        ./mysql_install_remove.sh
            ;;

                yes|Yes|YES|Y|y)

                    echo "WARNING"
                    sleep 2
                    echo
                    echo "It is recommended to uninstall all older versions of MySQL or MariaDB."
                    echo
                    sleep 2
                    echo
                    echo
                    echo "Downloading repositories..."
                    echo
                    echo
                    wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup;
                    echo "733cf126b03f73050e242102592658913d10829a5bf056ab77e7f864b3f8de1f mariadb_repo_setup" | sha256sum -c -;
                    chmod +x mariadb_repo_setup;
                    echo
                    echo
                    read -p "Which version do you want to install? (Example: 10.1, 10.3 or 10.6) :" VERSION_MARIADB
                    echo
                    echo
                    ./mariadb_repo_setup --mariadb-server-version="mariadb-$VERSION_MARIADB";
                    apt update;
                    apt install -y mariadb-server;
                    sleep 3;
                    systemctl start mariadb;
                    systemctl enable mariadb;
                    rm -rf mariadb_repo_setup;
                    
                    echo
                    echo

                    echo -n "Installation completed"

                    echo
                    echo

                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo -n "."
        
                    echo
                    echo
                    echo

                        ./mysql_install_remove.sh
            ;;

                *)
                
                    echo "Command not found!"
        
                    echo
                    echo
        
                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."

                    echo
                    echo
                    echo
        
                        ./mysql_install_remove.sh
            ;;
            esac
;;

    4)
        echo -n "Are you sure you want to go out?  Yes|No: "
        read YES_NO
        
        echo
        echo
            
            case "$YES_NO" in
            
                no|No|NO|N|n)

                    sleep 3
        
                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."
        
                    echo
                    echo
                    echo

                        ./mysql_install_remove.sh
            ;;

                yes|Yes|YES|Y|y)

                    echo "See you later!  =D "
        
                    echo
                    echo
                    sleep 3
                    exit;
            ;;

                *)
                    echo "Command not found!"
        
                    echo
                    echo
        
                    echo -n "Returning to the main menu"
        
                    echo -n "."
                    sleep 2
                    echo -n "."
                    sleep 2
                    echo "."

                    echo
                    echo
                    echo
        
                        ./mysql_install_remove.sh
            ;;
            esac
;;
esac