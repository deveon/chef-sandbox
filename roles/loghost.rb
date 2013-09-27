name 'loghost'
description 'rsyslog log server'

run_list 'recipe[rsyslog::server]'
