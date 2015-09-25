#!/bin/bash
echo running backup
cd /root/Backup && bundle exec backup perform -t default
#rsyslogd && cron && tail -f /var/log/syslog /var/log/cron.log   # run the cronjob
