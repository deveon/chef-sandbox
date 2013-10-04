service 'redis-server' do
	supports [:status]
	action :restart
end
