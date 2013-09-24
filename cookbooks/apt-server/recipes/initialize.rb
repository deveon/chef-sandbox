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
package 'dpkg-dev'
directory "/usr/share/nginx/www/deb_repo/binary" do
  recursive true
  owner "ubuntu"
  group "ubuntu"
  mode 0755
  action :create
end
