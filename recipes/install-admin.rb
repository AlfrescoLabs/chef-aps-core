# Extract zip then move the war file to the tomcat directory
aps_admin_version = node['aps-core']['admin_app']['version']
admin_version = node['aps-core']['admin_app']['version']
zip_location = "#{Chef::Config[:file_cache_path]}/activiti-admin-#{aps_admin_version}.zip"
tomcat_home = node['aps-core']['appserver']['tomcat_home']
war_location = "/tmp/activiti-admin-#{admin_version}/activiti-admin/activiti-admin.war"

package 'unzip'

execute "unzip -q -u -o #{zip_location} -d /tmp" do
  not_if { Dir.exist?("/tmp/activiti-admin-#{admin_version}") }
  only_if { File.exist?(zip_location) }
end

package 'unzip' do
  action :remove
end

execute "mv #{war_location} #{tomcat_home}/webapps" do
  not_if { File.exist?("#{tomcat_home}/webapps/activiti-admin.war") }
  only_if { File.exist?(war_location) }
end

execute "rm #{zip_location}" do
  only_if { File.exist?(zip_location) }
end

execute "rm -rf /tmp/activiti-admin-#{admin_version}" do
  only_if { Dir.exist?("/tmp/activiti-admin-#{admin_version}") }
end
