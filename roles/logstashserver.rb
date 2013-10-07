name 'logstash_server'

description 'logstash server'

default_attributes(
  "logstash" => { 
    "kibana" => {"http_port" => "8050" },  
    "elasticsearch_ip" => "10.123.61.11",
    "elasticsearch_port" => "9200",
    "server" => {
      "xms" => "128M", 
      "xmx" => "128M", 
      "enable_embedded_es" => true,
      "install_rabbitmq" => false,
      "inputs" => [ 
        "redis" => {
          "host" => "0.0.0.0",
          "data_type" => "list",
          "key" => "logstash",
          "type" => "syslog"
        }
      ],
    }
  },
  "elasticsearch" => { 
                       "allocated_memory" => "128m", 
                       "cluster" => {
                         "name" => "logstash"
                       }
  },
  "redisio" => {
    "servers" => [
      {
        "port" => '6379',
        "logfile" => "/var/log/redis/redisio_server.log"
      }
    ]
  }
)

run_list 'recipe[apt::default]', 'recipe[utilities::redis_setup]', 'recipe[redisio::install]', 'recipe[redisio::enable]', 'recipe[logstash::server]', 'recipe[logstash::kibana]', 'recipe[utilities::restart_kibana]'
