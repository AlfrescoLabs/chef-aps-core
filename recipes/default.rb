#
# Cookbook Name:: aps-core
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'aps-appserver::default'

include_recipe 'aps-core::_download_artifacts'

tomcat_home = node['aps-core']['appserver']['tomcat_home']

template "#{tomcat_home}/lib/activiti-app.properties" do
  source 'activiti-app.properties.erb'
  owner 'tomcat'
  group 'tomcat'
  mode 00740
  variables properties: node['aps-core']['activiti-app-properties']
end

service "#{node['appserver']['installname']}-#{node['tomcat']['service']}" do
  action [:enable]
end
