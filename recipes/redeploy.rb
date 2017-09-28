tomcat_home = node['aps-core']['appserver']['tomcat_home']
service_name = "#{node['appserver']['installname']}-#{node['tomcat']['service']}"

service service_name do
  action :stop
end

include_recipe 'aps-core::_download_artifacts'

template "#{tomcat_home}/lib/activiti-app.properties" do
  source 'activiti-properties.erb'
  variables properties: node['aps-core']['activiti-app-properties']
end

template "#{tomcat_home}/lib/activiti-admin.properties" do
  source 'activiti-properties.erb'
  variables properties: node['aps-core']['activiti-admin-properties']
  only_if { node['aps-core']['admin_app']['install'] }
end

service service_name do
  action :start
end
