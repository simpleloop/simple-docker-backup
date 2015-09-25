#!/bin/bash
echo running backup
cd /root/Backup && bundle exec backup perform -t filebackup
