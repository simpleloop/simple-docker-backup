FROM ruby:2.2.2

# install packages
RUN apt-get update && \
    apt-get install -y ruby-dev vim && \
    rm -rf /var/lib/apt/lists/*

# Volumes - data to backup will be mapped to /data
VOLUME ["/data"]

# Copy App
COPY . /root/Backup
RUN cd /root/Backup && gem install nokogiri && gem install http_parser.rb && gem install unf_ext -v '0.0.6'  && bundle install
WORKDIR /root/Backup

COPY bin/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
