name 'graylogserver'

description 'graylog server'


# Added rbenv recipe here and commented it out in the graylog2/webinterface.rb...it gives an error there
run_list 'recipe[rbenv::default]','recipe[rbenv::ruby_build]', 'recipe[graylog2::default]', 'recipe[graylog2::apache2]'


default_attributes(
	"graylog2" => {
		"apache" => { 'listen_ports'=> '[4500]' }
	}
  )

