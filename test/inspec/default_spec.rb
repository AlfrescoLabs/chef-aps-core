services = ['tomcat']

control 'alfresco-01' do
  impact 0.7
  title 'Tomcat configuration'
  desc 'Checks Tomcat connection'

  describe user('tomcat') do
    it { should exist }
  end

  describe 'Tomcat' do
    services.each do |service|
      it "Has a running #{service} service" do
        expect(service(service)).to be_running
      end
    end
  end
end
