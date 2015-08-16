#!/bin/bash -       
##########################################
#title           :drop_all_tables_mysql.sh
#description     :This script will drop all tables from a MySQL database
#author		 :sysdocs
#website	 :sysdocs.net
#date            :20150816
#version         :0.1    
#usage		 :bash drop_all_tables_mysql.sh.sh {MySQL-User-Name} {MySQL-User-Password} {MySQL-Database-Name} {MySQL-Database-Host}
#notes           :Install MySQL Client to run this script
##########################################
MUSER="$1"
MPASS="$2"
MDB="$3"
HOST="$4"
 
# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)
 
if [ $# -ne 4 ]
then
    echo "Usage: $0 {MySQL-User-Name} {MySQL-User-Password} {MySQL-Database-Name} {MySQL-Database-Host}"
    echo "Drops all tables from a MySQL"
exit 1
fi
 
TABLES=$($MYSQL -u $MUSER -p$MPASS -h $HOST $MDB -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )
 
for t in $TABLES
    do
    echo "Deleting $t table from $MDB database..."
    $MYSQL -u $MUSER -p$MPASS -h $HOST $MDB -e "drop table $t"
done