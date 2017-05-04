services = ['tomcat']

control 'alfresco-01' do
  impact 0.7
  title 'Tomcat configuration'
  desc 'Checks Tomcat connection'

  describe user('tomcat') do
    it { should exist }
  end

  describe group('tomcat') do
    it { should exist }
  end

  describe file('/usr/share/tomcat/lib/mysql-connector-java-5.1.39.jar') do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0740' }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' }
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('nginx') }
    it { should_not be_readable.by_user('nginx') }
    it { should_not be_executable.by_user('nginx') }
  end

  describe file('/usr/share/tomcat/lib/activiti-app.properties') do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0740' }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' }
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('nginx') }
    it { should_not be_readable.by_user('nginx') }
    it { should_not be_executable.by_user('nginx') }
  end

  describe file('/usr/share/tomcat/webapps/activiti-app.war') do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0740' }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' }
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('nginx') }
    it { should_not be_readable.by_user('nginx') }
    it { should_not be_executable.by_user('nginx') }
  end
  
  describe 'Tomcat' do
    services.each do |service|
      it "Has a running #{service} service" do
        expect(service(service)).to be_running
      end
    end
  end
end
