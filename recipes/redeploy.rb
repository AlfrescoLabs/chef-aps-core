tomcat_home = node['aps-core']['appserver']['tomcat_home']

include_recipe 'aps-core::_download_artifacts'

template "#{tomcat_home}/lib/activiti-app.properties" do
  source 'activiti-app.properties.erb'
  variables properties: node['aps-core']['activiti-app-properties']
end

service "#{node['appserver']['installname']}-#{node['tomcat']['service']}" do
  action [:restart]
end
