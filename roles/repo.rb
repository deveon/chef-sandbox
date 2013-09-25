name 'repo'
description 'This instance has a bunch of different repo services running (chef server, apt server, etc)'

run_list 'recipe[apt-server::default]', 'recipe[chef-server::default]'
