#
# Cookbook Name:: dir_s3_sync
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if Dir.exists? node['dir_s3_sync']['dir']

  # Create cron.d/dir_s3_sync
  cron_d "dir_s3_sync" do
    user "vagrant"

    # Working 1 minute example
    #command "cd #{node['dir_s3_sync']['dir']}; find -mindepth 1 -maxdepth 1 -type d -cmin -1 -exec tar -cvf {}.tar {} \\; > /dev/null;     s3cmd mb s3://#{node['dir_s3_sync']['bucket']};   s3cmd put *.tar s3://#{node['dir_s3_sync']['bucket']}/;    rm *.tar"

    # For each day at 00:10 AM
    minute 10
    hour 0

    # Minutes in a day = 60*24 = 1440
    command "cd #{node['dir_s3_sync']['dir']}; find -mindepth 1 -maxdepth 1 -type d -cmin -1440 -exec tar -cvf {}.tar {} \\; > /dev/null;     s3cmd mb s3://#{node['dir_s3_sync']['bucket']};   s3cmd put *.tar s3://#{node['dir_s3_sync']['bucket']}/;    rm *.tar"
  end


  # Restart cron
  execute "restart_cron" do
    command "service cron restart"
  end

end
