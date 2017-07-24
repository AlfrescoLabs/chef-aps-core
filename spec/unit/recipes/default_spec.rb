#
# Cookbook Name:: aps-core
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.describe 'aps-core::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '7.2.1511',
      file_cache_path: '/var/chef/cache'
    ) do |node|
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'includes appserver recipe' do
    expect(chef_run).to include_recipe('aps-appserver::default')
  end

  it 'includes _download_artifacts recipe' do
    expect(chef_run).to include_recipe('aps-core::_download_artifacts')
  end

  it 'creates a activiti app template' do
    expect(chef_run).to create_template('/usr/share/tomcat/lib/activiti-app.properties').with(
      user: 'tomcat',
      group: 'tomcat'
    )
  end

  it 'enable tomcat activiti' do
    expect(chef_run).to enable_service('tomcat-activiti')
  end
end
