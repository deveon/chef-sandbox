name 'base'
description 'basic software'

run_list 'recipe[rsyslog::client]'

default_attributes(
  "rsyslog" => { "server_ip" => "33.33.33.12" }
)
