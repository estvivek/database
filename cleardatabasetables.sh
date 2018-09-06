# database Credentials :
HOST=""
DATABASE=""
USER=""
PASS=""

#clear a database:
  { echo "SET FOREIGN_KEY_CHECKS = 0;" ; \
  mysql -h $HOST -u $USER -p$PASS "$DATABASE" --skip-column-names -e \
  "SELECT concat('DROP TABLE IF EXISTS ', table_name, ';') FROM information_schema.tables WHERE table_schema = '$DATABASE';";\
  echo "SET FOREIGN_KEY_CHECKS = 1;";\
  } | mysql -h $HOST -u $USER -p$PASS "$DATABASE"
