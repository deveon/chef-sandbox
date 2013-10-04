name 'logstash_server'

description 'logstash server'

default_attributes(
  "logstash" => { 
    "kibana" => {"http_port" => "8050" },  
    "elasticsearch_ip" => "127.0.0.1",
    "elasticsearch_port" => "9200",
    "server" => {"xms" => "128M", "xmx" => "128M", "enable_embedded_es" => false}
    },
  "elasticsearch" => {"allocated_memory" => "128m"}
)

run_list 'recipe[elasticsearch]', 'recipe[logstash::server]', 'recipe[logstash::kibana]'
