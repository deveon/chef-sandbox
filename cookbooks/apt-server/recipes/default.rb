#
# Cookbook Name:: apt-server
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'nginx'
service 'nginx' do
	supports [:status]
	action :start
end

# TODO use chef attributes for directory names

package 'dpkg-dev'
directory "/usr/share/nginx/www/deb_repo/binary" do
  recursive true
  owner "ubuntu"
  group "ubuntu"
  mode 0755
  action :create
end

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
