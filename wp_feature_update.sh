#!/bin/bash

##################################################################
#----------------------------------------------------------------#
# Script Name: wp_feature_update.sh                              #
#----------------------------------------------------------------#
# Description: This program updates wordpress plugins,           #
# themes and core                                                #
#----------------------------------------------------------------#
# Site: https://hagen.dev.br                                     #
#----------------------------------------------------------------#
# Author: João Pedro Hagen <joaopedro@hagen.dev.br>              #
# ---------------------------------------------------------------#
# History:                                                       #
#   V1.0.1 2022-12-11                                            #
#        -Initial release.                                       #
#   V1.0.2 2022-12-13                                            #
#        -Includes Mysql Dumping                                 #
#----------------------------------------------------------------#
##################################################################

# If your directory is another or domain uses another 
# extension like .net, .co, etc, change the variable SRCSITE.

# Expression to get only the domains, 
# using the cut to get the fields and the tr to delete the empty lines.
SRCSITE=$(ls /srv/ | grep ".com" | cut -d/ -f3 | tr -d "[\:], [\-\>]" | sed -r '/^[\s\t]*$/d')

for BKPDATA in $SRCSITE;
do
    echo;
    echo;

    echo "Dumping the Databases...";

    echo -e "\e[1;36m------------------------------------------------------------------------\e[0m"

    echo;
    echo;

    sleep 2;

    echo -e "Dumping the \e[1;35m$BKPDATA\e[0m database...";

    echo -e "\e[1;36m------------------------------------------------------------------------\e[0m"


    cd /srv/"$BKPDATA"/;

    # If the directory does not exist, create one. 
    if [ -e "/srv/$BKPDATA/bkp_db_$BKPDATA" ]; then
        
        echo -e "\e[1;36m######################\e[0m";
        echo -e "\e[1;36m|\e[0m Existing directory \e[1;36m|\e[0m";
        echo -e "\e[1;36m######################\e[0m";
        sleep 2;
    
    else

        echo -e "\e[1;36m######################\e[0m";
        echo -e "\e[1;36m|\e[0m Creating directory \e[1;36m|\e[0m";
        echo -e "\e[1;36m######################\e[0m"


        mkdir bkp_db_"$BKPDATA";
    
    fi

    echo -e "\e[1;36m------------------------------------------------------------------------\e[0m"

    cd /srv/"$BKPDATA"/bkp_db_"$BKPDATA"/;
    
    # Expression to get the database name.
    SRCDATA=$(ls /srv/"$BKPDATA"/bkp/ | cut -d- -f1 | uniq)
    DATEBKP=$(date +%d%m%Y)
    mysqldump "$SRCDATA" > "$SRCDATA""$DATEBKP".sql

    echo;
    echo;

    sleep 2;

    echo "Dumping Finished"

    echo -e "\e[1;36m------------------------------------------------------------------------\e[0m"

done

# Loop to get the domains.
for WEBSITES in $SRCSITE; 
do
    echo;
    echo;

    echo -e "Updating \e[1;35m$WEBSITES\e[0m core, plugins and themes"

    echo -e "\e[1;36m------------------------------------------------------------------------\e[0m"

    
    cd /srv/$WEBSITES/www/;
    
    echo;
    echo;
    echo "Updating Plugins...";

    echo -e "\e[1;36m------------------------------------------------------------------------\e[0m"


    echo;
    echo;
    
    sleep 2;
    
    # WP-CLI command to update the plugins.
    wp plugin update --all --allow-root;
    
    echo;
    echo;
    
    sleep 2;

    echo "Updating Themes...";

    echo -e "\e[1;36m------------------------------------------------------------------------\e[0m"


    echo;
    echo;
    
    sleep 2;
    
    # WP-CLI command to update the themes.
    wp theme update --all --allow-root;
    
    echo;
    echo;
    
    sleep 2;

    echo "Updating Wordpress Version...";

    echo -e "\e[1;36m------------------------------------------------------------------------\e[0m"


    echo;
    echo;

    sleep 2;

    # WP-CLI command to update the core.
    wp core update --allow-root;

    echo;
    echo;

    sleep 2;
done

echo -e "\e[1;36m------------------------------------------------------------------------\e[0m"


echo "Update Finished"
