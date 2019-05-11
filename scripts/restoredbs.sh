#!/bin/bash

USER="root"
PASSWORD="vagrant"

cd /vagrant/db-backups/

databases=`ls -1 *.sql`

for db in $databases; do
        echo "Importing $db ..."
        mysql -u $USER -p$PASSWORD < $db
done
