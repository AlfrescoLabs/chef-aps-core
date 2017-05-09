#
# Cookbook Name:: aps-core
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

# Probably tomcat should be a pinned version...
yum_package 'tomcat' do
  action :install
end

# Probably this can be downloaded in a better way, but at least we are using chef resources.
remote_file '/usr/share/tomcat/webapps/activiti-app.war' do
  source "https://#{node['aps-core']['nexus']['username']}:#{node['aps-core']['nexus']['password']}@artifacts.alfresco.com/nexus/service/local/repositories/activiti-enterprise-releases/content/com/activiti/activiti-app/#{node['aps-core']['version']}/activiti-app-#{node['aps-core']['version']}.war"
  owner 'tomcat'
  group 'tomcat'
  mode '0740'
  action :create
end

remote_file '/usr/share/tomcat/lib/mysql-connector-java-5.1.39.jar' do
  source 'http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.39/mysql-connector-java-5.1.39.jar'
  owner 'tomcat'
  group 'tomcat'
  mode '0740'
  action :create
end

template '/usr/share/tomcat/lib/activiti-app.properties' do
  source 'activiti-app.properties.erb'
  owner 'tomcat'
  group 'tomcat'
  mode '0740'
  variables properties: node['aps-core']['activiti-app-properties']
end

service 'tomcat' do
  action [:enable, :start]
end
