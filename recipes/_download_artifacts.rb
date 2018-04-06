tomcat_home = node['aps-core']['appserver']['tomcat_home']
appserver_username = node['appserver']['username']
appserver_group = node['appserver']['group']
nexus_username = node['aps-core']['nexus']['username']
nexus_password = node['aps-core']['nexus']['password']
aps_version = node['aps-core']['version']
major_minor_version = aps_version[0, aps_version.rindex('.')]
aps_admin_version = node['aps-core']['admin_app']['version']
is_mysql = node['aps-core']['db']['engine'] == 'mysql'
is_postgres = node['aps-core']['db']['engine'] == 'postgres'
admin_enabled = node['aps-core']['admin_app']['install']
files_to_override = node['aps-core']['war_file_paths_to_override'].dup # dup creates a new instance and does not preserve the frozen state

tmp_activiti_war_path = "#{Chef::Config[:file_cache_path]}/activiti-app-#{aps_version}.war"
final_activiti_war_path = "#{tomcat_home}/webapps/activiti-app.war"

tmp_admin_zip_path = "#{Chef::Config[:file_cache_path]}/activiti-admin-#{aps_admin_version}.zip"

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

remote_file tmp_admin_zip_path do
   source "https://s3.amazonaws.com/aps-quickstart/activiti-admin-1.6.4.zip"
#  source "https://releases.alfresco.com/Activiti/ProcessServices-1.6/1.6.4/activiti-admin-1.6.4.zip"
#  source "http://eu.dl.alfresco.com.s3.amazonaws.com/release/enterprise/process-services-#{major_minor_version}/#{aps_admin_version}/activiti-admin-#{aps_admin_version}.zip"
  owner appserver_username
  group appserver_group
  mode 00740
  action :create_if_missing
  retries 2
  only_if { admin_enabled }
end

directory "#{Chef::Config[:file_cache_path]}/WEB-INF/classes/activiti" do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

directory "#{Chef::Config[:file_cache_path]}/WEB-INF/classes/activiti" do
  owner appserver_username
  group appserver_group
  mode 00740
  recursive true
  action :create
end

whitelist_templates = %w(beans-whitelist.conf javascript-whitelist-classes.conf
                         whitelisted-classes.conf whitelisted-scripts.conf
                         shell-commands-whitelist.conf call-whitelist.conf
)

whitelist_templates.each do |template|
  attribute_name = template.tr('.', '-')
  template_path = "WEB-INF/classes/activiti/#{template}"
  next unless node['aps-core'][attribute_name]['override']
  template "#{Chef::Config[:file_cache_path]}/#{template_path}" do
    source "#{template}.erb"
    owner appserver_username
    group appserver_group
    mode 00740
    variables values: node['aps-core'][attribute_name]['values']
  end
  files_to_override.push(template_path)
end
files_to_override_tos = files_to_override.join(' ')

execute 'Replace whitelist files' do
  command "jar uf #{tmp_activiti_war_path} #{files_to_override_tos}"
  cwd Chef::Config[:file_cache_path]
  action :run
  only_if { !files_to_override_tos.empty? }
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
