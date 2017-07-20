#
# Cookbook Name:: aps-core
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'aps-appserver::default'

tomcat_home = node['aps-core']['appserver']['tomcat_home']

# Probably this can be downloaded in a better way, but at least we are using chef resources.
remote_file "#{tomcat_home}/webapps/activiti-app.war" do
  source "https://#{node['aps-core']['nexus']['username']}:#{node['aps-core']['nexus']['password']}@artifacts.alfresco.com/nexus/service/local/repositories/activiti-enterprise-releases/content/com/activiti/activiti-app/#{node['aps-core']['version']}/activiti-app-#{node['aps-core']['version']}.war"
  owner 'tomcat'
  group 'tomcat'
  mode 00740
  action :create_if_missing
  retries 2
end

remote_file "#{tomcat_home}/lib/mysql-connector-java-#{node['aps-core']['mysql_driver']['version']}.jar" do
  source node['aps-core']['mysql_driver']['url']
  owner 'tomcat'
  group 'tomcat'
  mode 00740
  action :create_if_missing
  only_if { node['aps-core']['db']['engine'] == 'mysql' }
  retries 2
end

remote_file "#{tomcat_home}/lib/postgresql-#{node['aps-core']['postgres_driver']['version']}.jar" do
  source node['aps-core']['postgres_driver']['url']
  owner 'tomcat'
  group 'tomcat'
  mode 00740
  action :create_if_missing
  only_if { node['aps-core']['db']['engine'] == 'postgres' }
  retries 2
end

template "#{tomcat_home}/lib/activiti-app.properties" do
  source 'activiti-app.properties.erb'
  owner 'tomcat'
  group 'tomcat'
  mode 00740
  variables properties: node['aps-core']['activiti-app-properties']
end

service 'tomcat-activiti' do
  action [:enable, :start]
end
