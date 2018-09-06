#! /bin/bash

TIMESTAMP=$(date +"%F")
### update path for backup dir below ###
BACKUP_DIR="###here###/$TIMESTAMP-backup-db"
BACKUP_DIR_main="###here###"
uploadlog=$BACKUP_DIR_main/upload.log
tarlog=$BACKUP_DIR_main/tar.log

### update db credentials below ###
HOST=""
MYSQL_USER=""
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD=""
MYSQLDUMP=/usr/bin/mysqldump


mkdir -p "$BACKUP_DIR/mysql"
#mkdir -p "$BACKUP_DIR/code"

	databases=`$MYSQL -h $HOST --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)" `
echo "~~~~~~~~~~~START~~~~~~~~~~~"

for db in $databases; do

		echo "Now taking backup of "
		echo $db


	$MYSQLDUMP -h $HOST --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db  --skip-triggers  | gzip > "$BACKUP_DIR/mysql/$db.gz"


done

du -hs $BACKUP_DIR/mysql/*


	echo "~~~~~~~~~~~Done~~~~~~~~~~~"
