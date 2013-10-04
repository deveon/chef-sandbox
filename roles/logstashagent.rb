name 'logstash_agent'

description 'logstash agent'

default_attributes(
  "logstash" => { 
    "agent" => {
      "server_ipaddress"=>"33.33.33.14",
      "outputs" => [
        "redis" => {
          "host" => "33.33.33.14",
          "data_type" => "list",
          "key" => "logstash"
        }
      ]
    } 
  }
)

run_list 'recipe[logstash::agent]' 
