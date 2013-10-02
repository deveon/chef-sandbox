name 'logstash_agent'

description 'logstash agent'

default_attributes(
  "logstash" => { "agent" => {"server_ipaddress"=>"33.33.33.14"} }
)

run_list 'recipe[logstash::agent]' 
