import fabric
from fabric.api import *

USER = 'simpleloop'
REPO_DIR = '/srv/simpleloop.com/backup/'
BACKUP_DIR = '/srv/simpleloop.com/media/'   # folder to backup
DATABASE_CONTAINER = 'postgres_simpleloop'   # name of the database container
DATABASE_TARGET_HOST = 'postgres'   # host to map DATABASE_CONTAINER to
ENV_FILE = '/srv/simpleloop.com/.bashrc'   # file for environment variables. will be provided to the container
IMAGE_NAME = 'simpleloop-backup'
CONTAINER_NAME = 'simpleloop-backup'

env.hosts = [
    "simpleloop.com:19639"   # the server to connect to
]

def uname():
    run('uname -r')

def pull():
    print fabric.colors.yellow("Pulling from GitHub...")
    with cd(REPO_DIR):
        sudo("git stash && git pull", user=USER)
    print fabric.colors.green("Finished pulling from GitHub!")


def build():
    print fabric.colors.yellow("Building new Docker Image...")
    with cd(REPO_DIR):
        sudo("docker build -t %s ." % IMAGE_NAME, user=USER)
    print fabric.colors.green("Finished building new Docker Image...")


def run_container():
    print fabric.colors.yellow("Running Docker Backup container...")
    sudo("docker run --restart=always -d "
         "-v %(BACKUP_DIR)s:/data/ "
         "--name %(CONTAINER_NAME)s "
         "--link %(DATABASE_CONTAINER)s:%(DATABASE_TARGET_HOST)s "
         "--env-file=[%(ENV_FILE)s] "
         "%(IMAGE_NAME)s" % globals(), user=USER)
    print fabric.colors.green("Started Docker Backup container...")

def remove_container():
    print fabric.colors.yellow("Removing Docker container...")
    sudo("docker rm -f %(CONTAINER_NAME)s" % globals(), user=USER)
    print fabric.colors.green("Removed Docker container...")

def ps():
    sudo("docker ps -a", user=USER)

def deploy():
    pull()
    build()
    remove_container()
    run_container()
