describe file('/usr/share/tomcat/webapps/activiti-admin.war') do
  it { should be_file }
  it { should exist }
end

describe file('/usr/share/tomcat/lib/activiti-admin.properties') do
  it { should be_file }
  it { should be_readable }
  it { should exist }
end
