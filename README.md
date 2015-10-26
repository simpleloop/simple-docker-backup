# simple docker container backup using [backup gem](https://github.com/backup/backup)

The purpose of this repo is to facilitate backups for docker containers.  
It is a reusable docker container backup utility for multi docker container setups.
Out of the box it provides the possibility to backup files and databases linked via docker --link.  
Extending it to include other backups is easy - just setup a new backup model in /models and adjust the docker entrypoint to include the model.

## Setup Backup

1. setup the backup in models/default.rb following the [docs](http://meskyanichi.github.io/backup/v4/getting-started/)
2. Deploy repo: Copy it to your server or pull it from your code repository  
3. cd into repo and build the image: ```docker build -t simpleloop-backup .```
4. Setup your environment variables file as mentioned below
5. now run the container to execute your backup manually:

```
docker run --rm -v <path-to-backup>:/data/ --name <container-name> --link <db-container-name>:<map-db-host-name> --env-file=<the-env-variables-file> <image-name>  
docker run --rm -v /srv/simpleloop.com/media/:/data/ --name simpleloop-backup --link postgres_simpleloop:postgres --env-file=/srv/simpleloop.com/.bashrc simpleloop-backup
```


Environment File

    BACKUP_NAME_FILES=thenameforthefilesbackup   # The name of the files backup
    BACKUP_NAME_DATABASE=thenameforthedatabasebackup   # The name of the database backup
    BACKUP_DATA_MOUNT_VOLUME=/data    # folder that contains the data to backup in the container mounted via -v /backup/dir:/data/
    BACKUP_ENCRYPTION_PASSWORD=thebackuppassword   # backups are encrypted using openssl

    # POSTGRES
    BACKUP_POSTGRES_DATABASE_NAME=thedatabasename    # the database name of the database to backup
    BACKUP_POSTGRES_USER_NAME=dbusername   # the database user name
    BACKUP_POSTGRES_PASSWORD=dbpassword   # the password to access the database
    BACKUP_POSTGRES_HOST_NAME=postgres   # the hostname as used in docker --link
    BACKUP_POSTGRES_DATABASE_PORT=5432    # the port of the database

    # SLACK
    BACKUP_SLACK_USERNAME=backupuser    # The username to display along with the notification
    BACKUP_SLACK_WEBHOOK_URL=https://hooks.slack.com/services/yourwebhookurl   # the webhook_url
    BACKUP_SLACK_CHANNEL=theslackchannel   # the channel to which the message will be sent
    BACKUP_SLACK_ICON_EMOJI=:ghost:   # icon emoji is used to post the message to slack

    # S3
    BACKUP_S3_ACCESS_KEY_ID=my_access_key_id
    BACKUP_S3_SECRET_ACCESS_KEY=my_secret_access_key
    BACKUP_S3_REGION=eu-west-1
    BACKUP_S3_BUCKET=bucket-name
    BACKUP_S3_BUCKET_PATH=path/to/backups
    BACKUP_S3_KEEP=7   # how many old backups to keep


## Schedule Backup

Create a job on your host system to run regularly. This can be the scheduler app of your choice. For example cron, [whenever gem](https://github.com/javan/whenever), anacron or similar.

This job should execute the command to run the backup container on regular intervals, and remove it as soon as the backup succeeded. Example:
A cronjob running everyday at 1:15 am:

```
15 1 * * * docker run --rm -v <path-to-backup>:/data/ --name <container-name> --link <db-container-name>:<map-db-host-name> --env-file=<the-env-variables-file>
```


## CREDITS

Credits to https://github.com/siuying/docker-backup as this repo is greatly inspired by docker-backup and
adapted to suit our needs. Especially we got rid of crontab and are focusing to build up a container that
can be used in multi-container environments.


## LICENSE

Released under the MIT License
==============================

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
