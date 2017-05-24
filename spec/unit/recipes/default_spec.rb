#
# Cookbook Name:: aps-core
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aps-core::default' do
  context 'Checks for differents packages and attributes' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes appserver recipe' do
      expect(chef_run).to include_recipe('aps-appserver::default')
    end

    it 'creates a activiti remote file' do
      expect(chef_run).to create_remote_file('/var/lib/tomcat/activiti/webapps/activiti-app.war').with(
        user: 'tomcat',
        group: 'tomcat'
      )
    end

    it 'creates a activiti app template' do
      expect(chef_run).to create_template('/usr/share/tomcat/lib/activiti-app.properties').with(
        user: 'tomcat',
        group: 'tomcat'
      )
    end

    it 'creates a mysql remote file' do
      expect(chef_run).to create_remote_file('/usr/share/tomcat/lib/mysql-connector-java-5.1.39.jar').with(
        user: 'tomcat',
        group: 'tomcat'
      )
    end

    it 'starts tomcat activiti' do
      expect(chef_run).to start_service('tomcat-activiti')
    end
  end
end
