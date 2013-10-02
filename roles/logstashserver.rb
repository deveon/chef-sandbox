name 'logstash_server'

description 'logstash server'

run_list 'recipe[logstash::server]','recipe[logstash::kibana]' 
