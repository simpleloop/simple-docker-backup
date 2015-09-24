# simple docker container backup using backup gem https://github.com/backup/backup

The purpose of this repo is to facilitate backups for docker containers.
It is possible to backup files and databases linked via docker --link .
```fabric``` is used to manage the deployment of the container. Whereas it is
a neat way using ```fabric```, it is not mandatory to use it.

## Setup Backup

Fabric settings

USER # the server user with which we will execute the cmds
REPO_DIR # the directory in which we will pull the repo from
BACKUP_DIR # folder to backup
DATABASE_CONTAINER # name of the database container
DATABASE_TARGET_HOST # host to map DATABASE_CONTAINER to
ENV_FILE # file for environment variables. will be provided to the container
IMAGE_NAME # the name of the docker image to be created
CONTAINER_NAME = # the name of the docker container to be created


# Using fabric

```pip install Fabric```

1. modify the fabfile to suit your requirements
2. setup the backup in models/default.rb
3. setup the repo on the server in REPO_DIR
4. fab deploy



# Not using fabric








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
