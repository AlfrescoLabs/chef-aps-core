tomcat_home = node['aps-core']['appserver']['tomcat_home']

# Probably this can be downloaded in a better way, but at least we are using chef resources.

tmp_activiti_war_path = "#{Chef::Config[:file_cache_path]}/activiti-app.war"
final_activiti_war_path = "#{tomcat_home}/webapps/activiti-app.war"

remote_file tmp_activiti_war_path do
  source "https://#{node['aps-core']['nexus']['username']}:#{node['aps-core']['nexus']['password']}@artifacts.alfresco.com/nexus/service/local/repositories/activiti-enterprise-releases/content/com/activiti/activiti-app/#{node['aps-core']['version']}/activiti-app-#{node['aps-core']['version']}.war"
  owner node['appserver']['username']
  group node['appserver']['group']
  mode 00740
  action :create_if_missing
  retries 2
end

file final_activiti_war_path do
  owner node['appserver']['username']
  group node['appserver']['group']
  mode 00740
  content lazy { ::File.open(tmp_activiti_war_path).read }
  action :create
end

remote_file "#{tomcat_home}/lib/mysql-connector-java-#{node['aps-core']['mysql_driver']['version']}.jar" do
  source node['aps-core']['mysql_driver']['url']
  owner node['appserver']['username']
  group node['appserver']['group']
  mode 00740
  action :create_if_missing
  only_if { node['aps-core']['db']['engine'] == 'mysql' }
  retries 2
end

remote_file "#{tomcat_home}/lib/postgresql-#{node['aps-core']['postgres_driver']['version']}.jar" do
  source node['aps-core']['postgres_driver']['url']
  owner node['appserver']['username']
  group node['appserver']['group']
  mode 00740
  action :create_if_missing
  only_if { node['aps-core']['db']['engine'] == 'postgres' }
  retries 2
end
