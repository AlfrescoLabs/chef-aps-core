tomcat_home = node['aps-core']['appserver']['tomcat_home']
appserver_username = node['appserver']['username']
appserver_group = node['appserver']['group']
nexus_username = node['aps-core']['nexus']['username']
nexus_password = node['aps-core']['nexus']['password']
aps_version = node['aps-core']['version']
is_mysql = node['aps-core']['db']['engine'] == 'mysql'
is_postgres = node['aps-core']['db']['engine'] == 'postgres'

tmp_activiti_war_path = "#{Chef::Config[:file_cache_path]}/activiti-app-#{aps_version}.war"
final_activiti_war_path = "#{tomcat_home}/webapps/activiti-app.war"

tmp_mysql_connector_path = "#{Chef::Config[:file_cache_path]}/mysql-connector-java-#{node['aps-core']['mysql_driver']['version']}.jar"
final_mysql_connector_path = "#{tomcat_home}/lib/mysql-connector-java.jar"

tmp_postgresql_connector_path = "#{Chef::Config[:file_cache_path]}/postgresql-#{node['aps-core']['postgres_driver']['version']}.jar"
final_postgresql_connector_path = "#{tomcat_home}/lib/postgresql.jar"

remote_file tmp_activiti_war_path do
  source "https://#{nexus_username}:#{nexus_password}@artifacts.alfresco.com/nexus/service/local/repositories/activiti-enterprise-releases/content/com/activiti/activiti-app/#{aps_version}/activiti-app-#{aps_version}.war"
  owner appserver_username
  group appserver_group
  mode 00740
  action :create_if_missing
  retries 2
end

file final_activiti_war_path do
  owner appserver_username
  group appserver_group
  mode 00740
  content lazy { ::File.open(tmp_activiti_war_path).read }
  action :create
end

remote_file tmp_mysql_connector_path do
  source node['aps-core']['mysql_driver']['url']
  owner appserver_username
  group appserver_group
  mode 00740
  action :create_if_missing
  only_if { is_mysql }
  retries 2
end

file final_mysql_connector_path do
  owner appserver_username
  group appserver_group
  mode 00740
  content lazy { ::File.open(tmp_mysql_connector_path).read }
  only_if { is_mysql }
  action :create
end

remote_file tmp_postgresql_connector_path do
  source node['aps-core']['postgres_driver']['url']
  owner appserver_username
  group appserver_group
  mode 00740
  action :create_if_missing
  only_if { is_postgres }
  retries 2
end

file final_postgresql_connector_path do
  owner appserver_username
  group appserver_group
  mode 00740
  content lazy { ::File.open(tmp_postgresql_connector_path).read }
  only_if { is_postgres }
  action :create
end
