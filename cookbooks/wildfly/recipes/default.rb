#
# Cookbook Name:: wildfly
# Recipe:: default
#
# Copyright 2014, Reltask Inc<reltask@gmail.com>
#
# Cheers!
#

include_recipe "ark"

user node[:wildfly][:user] do
  comment "Wildfly User"
  home "/home/#{node[:wildfly][:user]}"
  shell "/bin/bash"
  supports :manage_home=>true
end

group node[:wildfly][:group] do
  action :create
  members "#{node[:wildfly][:user]}"
end

ark "wildfly" do
  url node[:wildfly][:zip_url]
  version node[:wildfly][:version]
  prefix_root node[:wildfly][:install_path]
  home_dir node[:wildfly][:home]
  owner node[:wildfly][:user]
  group node[:wildfly][:group]
  action :install
end

script "add_wildfly_user" do
  interpreter "bash"
  user "#{node[:wildfly][:user]}"
  cwd "#{node[:wildfly][:home]}/bin"
  code <<-EOH
    ./add-user.sh -m -u #{node[:wildfly][:adminuser]} -p #{node[:wildfly][:adminuserpwd]} --silent
  EOH
end

template "#{node[:wildfly][:home]}/standalone/configuration/standalone.xml" do
  source "standalone.xml.erb"
  mode 0744
  owner node[:wildfly][:user]
end

template "/etc/default/wildfly.conf" do
  source "init.d.wildfly.conf.erb"
  mode 0744
  owner node[:wildfly][:user]
end

link "/etc/init.d/wildfly" do
  to "/opt/wildfly/bin/init.d/wildfly-init-redhat.sh"
end

#
=begin
cookbook_file "#{node[:wildfly][:jdbcjar]}" do
  path "#{node[:wildfly][:home]}/standalone/lib/ext/#{node[:wildfly][:jdbcjar]}"
  owner node[:wildfly][:user]
  group node[:wildfly][:group]
  action :create_if_missing
end
=end
#
service "wildfly" do
  supports :start => true, :stop => true, :restart => true
  action [:enable, :start]
end