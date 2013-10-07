directory "/var/log/redis" do
  recursive true
  owner "ubuntu"
  group "ubuntu"
  mode 0755
  action :create
end