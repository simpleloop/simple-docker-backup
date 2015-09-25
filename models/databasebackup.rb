# encoding: utf-8

Model.new(:databasebackup, ENV["BACKUP_NAME_DATABASE"]) do
  database PostgreSQL do |db|
    db.name               = ENV["BACKUP_POSTGRES_DATABASE_NAME"]
    db.username           = ENV["BACKUP_POSTGRES_USER_NAME"]
    db.password           = ENV["BACKUP_POSTGRES_PASSWORD"]
    db.host               = ENV["BACKUP_POSTGRES_HOST_NAME"]
    db.port               = ENV["BACKUP_POSTGRES_DATABASE_PORT"]
    # db.socket             = "/tmp/pg.sock"
    # db.additional_options = ["-xc", "-E=utf8"]
    # Optional: Use to set the location of this utility
    #   if it cannot be found by name in your $PATH
    # db.pg_dump_utility = "/opt/local/bin/pg_dump"
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  encrypt_with OpenSSL do |encryption|
    encryption.password = ENV["BACKUP_ENCRYPTION_PASSWORD"]
  end

  ##
  # Amazon Simple Storage Service [Storage]
  store_with S3 do |s3|
     s3.access_key_id     = ENV["BACKUP_S3_ACCESS_KEY_ID"]
     s3.secret_access_key = ENV["BACKUP_S3_SECRET_ACCESS_KEY"]
     s3.region            = ENV["BACKUP_S3_REGION"]
     s3.bucket            = ENV["BACKUP_S3_BUCKET"]
     s3.path              = ENV["BACKUP_S3_BUCKET_PATH"]
     s3.keep              = ENV["BACKUP_S3_KEEP"] ? ENV["BACKUP_S3_KEEP"].to_i : 5
  end

  notify_by Slack do |slack|
    slack.on_success = true
    slack.on_warning = true
    slack.on_failure = true

    # The integration token
    slack.webhook_url = ENV["BACKUP_SLACK_WEBHOOK_URL"]   # the webhook_url
    slack.username = ENV["BACKUP_SLACK_USERNAME"]   # the username to display along with the notification
    slack.channel = ENV["BACKUP_SLACK_CHANNEL"]   # the channel to which the message will be sent
    slack.icon_emoji = ENV["BACKUP_SLACK_ICON_EMOJI"]   # the emoji icon to use for notifications
  end

end
