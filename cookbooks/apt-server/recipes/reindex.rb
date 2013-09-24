cookbook_file "/etc/init/apt-index.conf" do
  owner "ubuntu"
  group "ubuntu"
  mode "0755"
  action :create
  source "apt-index.conf"  
end

service 'apt-index' do
  provider Chef::Provider::Service::Upstart
  action :start
end