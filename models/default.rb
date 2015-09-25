# encoding: utf-8

##
# Backup Generated: default
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t default [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
Model.new(:default, ENV["BACKUP_NAME"]) do
  ##
  # Archive [Archive]
  #
  # Adding a file or directory (including sub-directories):
  #   archive.add "/path/to/a/file.rb"
  #   archive.add "/path/to/a/directory/"
  #
  # Excluding a file or directory (including sub-directories):
  #   archive.exclude "/path/to/an/excluded_file.rb"
  #   archive.exclude "/path/to/an/excluded_directory
  #
  # By default, relative paths will be relative to the directory
  # where `backup perform` is executed, and they will be expanded
  # to the root of the filesystem when added to the archive.
  #
  # If a `root` path is set, relative paths will be relative to the
  # given `root` path and will not be expanded when added to the archive.
  #
  #   archive.root '/path/to/archive/root'
  #
  # lets archive the data in /data
  # /data has been mounted by docker using -v %(BACKUP_DIR)s:/data/
  archive :data do |archive|
    archive.add "/data"   # docker mounted the folders to backup to /data
  end

  encrypt_with OpenSSL do |encryption|
    encryption.password = 'my_password'
    encryption.base64   = true
    encryption.salt     = true
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #store_with S3 do |s3|
  #   s3.access_key_id     = ENV["BACKUP_S3_ACCESS_KEY_ID"]
  #   s3.secret_access_key = ENV["BACKUP_S3_SECRET_ACCESS_KEY"]
  #   s3.region            = ENV["BACKUP_S3_REGION"]
  #   s3.bucket            = ENV["BACKUP_S3_BUCKET"]
  #   s3.path              = ENV["BACKUP_S3_BUCKET_PATH"]
  #   s3.keep              = ENV["BACKUP_S3_KEEP"] ? ENV["BACKUP_S3_KEEP"].to_i : 5
  #   s3.trunk_size        = ENV["BACKUP_S3_TRUNKSIZE"]  ? ENV["BACKUP_S3_TRUNKSIZE"].to_i 5
  #end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  #notify_by Mail do |mail|
  #  mail.on_success           = true
  #  mail.on_warning           = true
  #  mail.on_failure           = true

  #  mail.from                 = "sender@email.com"
  #  mail.to                   = "receiver@email.com"
  #  mail.address              = "smtp.gmail.com"
  #  mail.port                 = 587
  #  mail.domain               = "your.host.name"
  #  mail.user_name            = "sender@email.com"
  #  mail.password             = "my_password"
  #  mail.authentication       = "plain"
  #  mail.encryption           = :starttls
  #end

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
