service 'elasticsearch' do
	supports [:status]
	action :restart
end
