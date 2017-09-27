#
# Cookbook Name:: aps-core
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'aps-appserver::default'

include_recipe 'aps-core::_download_artifacts'

tomcat_home = node['aps-core']['appserver']['tomcat_home']

template "#{tomcat_home}/lib/activiti-app.properties" do
  source 'activiti-properties.erb'
  owner 'tomcat'
  group 'tomcat'
  mode 00740
  variables properties: node['aps-core']['activiti-app-properties']
end

template "#{tomcat_home}/lib/activiti-admin.properties" do
  source 'activiti-properties.erb'
  owner 'tomcat'
  group 'tomcat'
  mode 00740
  variables properties: node['aps-core']['activiti-admin-properties']
  only_if { node['aps-core']['admin_app']['install'] }
end

service "#{node['appserver']['installname']}-#{node['tomcat']['service']}" do
  action [:enable]
end

include_recipe  'aps-core::install-admin' if node['aps-core']['admin_app']['install']
