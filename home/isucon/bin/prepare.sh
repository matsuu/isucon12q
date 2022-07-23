#!/bin/sh
set -ex
################################################################################
echo "# Prepare"
################################################################################

cat > /tmp/prepared_env <<EOF
prepared_time="`date +'%Y-%m-%d %H:%M:%S'`"
nginx_access_log="/var/log/nginx/access.log"
nginx_error_log="/var/log/nginx/error.log"
mysql_slow_log="/var/log/mysql/slow.log"
mysql_error_log="/var/log/mysql/error.log"
result_dir="/result"
data_dir="\${result_dir}/data"
go_binary="/home/isucon/webapp/go/isuports"
EOF

. /tmp/prepared_env

# app
(
  cd ${HOME}/webapp/go
  make
)
sudo systemctl restart isuports

# mysql
# sudo mysql -e "TRUNCATE TABLE performance_schema.events_statements_summary_by_digest"
sudo truncate -s 0 "${mysql_slow_log}"
sudo truncate -s 0 "${mysql_error_log}"
# sudo systemctl restart mysql
ssh 192.168.0.12 sudo truncate -s 0 "${mysql_slow_log}"
ssh 192.168.0.12 sudo truncate -s 0 "${mysql_error_log}"

# nginx
sudo truncate -s 0 "${nginx_access_log}"
sudo truncate -s 0 "${nginx_error_log}"
# sudo systemctl reload nginx

# cleanup
rm -f "${result_dir}"/*.* 
 
echo "OK"
