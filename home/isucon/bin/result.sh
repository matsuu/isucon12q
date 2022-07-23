#!/bin/sh

set -x

################################################################################
echo "# Analyze"
################################################################################

. /tmp/prepared_env

mkdir -p "${data_dir}"
#sudo journalctl --since="${prepared_time}" | xz > "${data_dir}/journal.log.xz"
#sudo cat "${nginx_access_log}" | xz > "${data_dir}/nginx_access.log.xz"
#sudo cat "${nginx_error_log}" | xz > "${data_dir}/nginx_error.log.xz"
#sudo cat "${mysql_error_log}" | xz > "${data_dir}/mysql_error.log.xz"

sudo cat "${nginx_access_log}" | /home/isucon/go/bin/kataribe -f "${HOME}/kataribe.toml" > "${result_dir}/kataribe.txt"
ssh 192.168.0.12 sudo mysqltuner > "${result_dir}/mysqltuner.txt"
ssh 192.168.0.12 sudo cat "${mysql_slow_log}" | /home/isucon/go/bin/go-mysql-query-digest --limit 100% > "${result_dir}/pt-query-digest.txt"

#for file in "${data_dir}"/*.pprof ; do
#  target=`basename ${file}`
#  (
#    echo "# ${target}"
#    echo
#    echo '## -top'
#    echo
#    echo '```'
#    go tool pprof -top ${go_binary} ${file} | head -n 42
#    echo '```'
#    echo
#    echo '## -top -cum'
#    echo
#    echo '```'
#    go tool pprof -top -cum ${go_binary} ${file} | head -n 42
#    echo '```'
#    echo
#    echo '## -list main.'
#    echo
#    echo '```'
#    go tool pprof -list 'main\.' ${go_binary} ${file}
#    echo '```'
#    echo
#    echo '## -peek main.'
#    echo
#    echo '```'
#    go tool pprof -peek 'main\.' ${go_binary} ${file}
#    echo '```'
#    echo
#  )> "${result_dir}/${target}.md"
#done

sudo git add /
sudo git commit -av
sudo git push origin main
