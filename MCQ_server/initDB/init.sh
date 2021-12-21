#!/bin/bash
RED='\033[0;31m'
Green='\033[0;32m'
lightGray='\033[1;30m'
Purple='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${NC}👉 ${Green} show Docker image databases...${lightGray}"
mysql --protocol=TCP -h $1 -P $2 -u$3 -p$4 <<EOFMYSQL
show databases;
EOFMYSQL

echo -e "${NC}👉 ${RED} ***check database existence *** ${lightGray}..."


RESULT=`mysql --protocol=TCP -h $1 -P $2 -u$3 -p$4  --skip-column-names -e "SHOW DATABASES LIKE '$5'"`
if [ "$RESULT" == "$5" ]; then
    echo -e "${Purple} \e[1m ****Database exist.Drop DB first Done****"
fi
echo -e "${Purple} \e[1m Database does not exist ::>> ${lightGray} start creating DB ..."
mysql --protocol=TCP -h $1 -P $2 -u$3 -p$4 < ./initDB/init.sql
echo -e "${Purple} DONE ... "


echo -e "${lightGray} "
