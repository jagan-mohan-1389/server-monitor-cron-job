#!/bin/bash

cd /home/mohan_1389/Desktop/server-monitor-cron-job/

server_name=$(hostname)
TS=$(date +"%Y-%m-%d %H:%M:%S")

# -------------------
# Save command history (append)
# -------------------
echo "===== Command history at $TS =====" >> commands_history.log
cat '/home/mohan_1389/.bash_history' >> commands_history.log
echo -e "\n" >> commands_history.log

# -------------------
# Append system checks
# -------------------
{
  echo "===== System check at $TS ====="
  echo "Memory usage on ${server_name}:"
  free -h
  echo ""
  echo "CPU load on ${server_name}:"
  uptime
  echo ""
  echo "TCP connections on ${server_name}:"
  cat /proc/net/tcp | wc -l
  echo ""
  echo "Kernel version on ${server_name}:"
  uname -r
  echo ""
  echo "==============================="
  echo ""
} >> server_check.log

# -------------------
# Push results to GitHub
# -------------------
git add commands_history.log server_check.log
git commit -m "Logs updated at $TS"
git push

