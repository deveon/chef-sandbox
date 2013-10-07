name 'logstash_agent'

description 'logstash agent'

default_attributes(
  "logstash" => { 
    "agent" => {
      "server_ipaddress"=>"10.123.61.11",
      "outputs" => [
        "redis" => {
          "host" => "10.123.61.11",
          "data_type" => "list",
          "key" => "logstash"
        }
      ]
    } 
  }
)

run_list  'recipe[apt::default]', 'recipe[logstash::agent]' 
