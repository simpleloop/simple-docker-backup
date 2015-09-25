FROM ruby:2.2.2

# setup crontab
RUN apt-get update && \
    apt-get install -y cron rsyslog rsync ruby-dev vim && \
    rm -rf /var/lib/apt/lists/*
COPY ./crontab /etc/crontab
RUN touch /var/log/cron.log

# Volumes - backup gem defaults location is ~/Backup/
VOLUME ["/data", "/root/Backup/logs"]

# Copy App
COPY . /root/Backup
RUN cd /root/Backup && gem install nokogiri && gem install http_parser.rb && gem install unf_ext -v '0.0.6'  && bundle install
WORKDIR /root/Backup

COPY bin/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
