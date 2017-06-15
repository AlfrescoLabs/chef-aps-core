tomcat_home = node['aps-core']['appserver']['tomcat_home']

template "#{tomcat_home}/lib/activiti-app.properties" do
  source 'activiti-app.properties.erb'
  variables properties: node['aps-core']['activiti-app-properties']
end

service 'tomcat-activiti' do
  action [:restart]
end
