name 'dir_s3_backup'
description 'Backup directory to S3'


default_attributes(
  "s3cmd" => {
    "access_key" => "AKIAJ3B3SD36NFMTZMPA",
    "secret_key" => "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",
    "user" => "vagrant",
    "bucket_location" => "US"
  },
  "dir_s3_sync" => {
    "dir" => "/home/vagrant/json_dir",
    "bucket" => "my_unique_bucket_name_abc"
  }
)

run_list 'recipe[s3cmd]', 'recipe[dir_s3_sync]'
