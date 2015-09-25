# simple docker container backup using [backup gem](https://github.com/backup/backup)

The purpose of this repo is to facilitate backups for docker containers.  
It is possible to backup files and databases linked via docker --link .  
```fabric``` is used to manage the deployment of the container. Whereas it is
a neat way using ```fabric```, it is not mandatory to use it.

## Setup Backup

1. setup the backup in models/default.rb following the [docs](http://meskyanichi.github.io/backup/v4/getting-started/)
2. Deploy repo: Copy it to your server or pull it from your code repository  
3. cd into repo and build the image: ```docker build -t simpleloop-backup .```
4. Setup your environment variables file as mentioned below
5. run the container:

```docker run --rm -v <path-to-backup>:/data/ --name <container-name> --link <db-container-name>:<map-db-host-name> --env-file=<the-env-variables-file> <image-name>```
```docker run --rm -v /srv/simpleloop.com/media/:/data/ --name simpleloop-backup --link postgres_simpleloop:postgres --env-file=/srv/simpleloop.com/.bashrc simpleloop-backup```


Environment File

    BACKUP_SLACK_WEBHOOK_URL=https://hooks.slack.com/services/yourwebhookurl
    BACKUP_SLACK_CHANNEL=theslackchannel
    BACKUP_SLACK_ICON_EMOJI=:ghost:   # icon emoji is used to post the message to slack


## CREDITS

Credits to https://github.com/siuying/docker-backup as this repo is greatly inspired by docker-backup and
adapted to suit our needs.


## LICENSE

The MIT License
===============

Copyright (c) 2009-2014 Stuart Knightley, David Duponchel, Franz Buchinger, António Afonso

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
