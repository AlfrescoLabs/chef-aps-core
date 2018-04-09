#
# Cookbook Name:: aps-core
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.describe 'aps-core::_download_artifacts' do
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

  it 'creates if missing a activiti remote file' do
    chef_run.node.normal['aps-core']['version'] = '1.8.1'
    chef_run.converge(described_recipe)
    expect(chef_run).to create_remote_file_if_missing('/var/chef/cache/activiti-app-1.8.1.war').with(
      user: 'tomcat',
      group: 'tomcat'
    )
  end

  it 'creates if missing a activiti file' do
    expect(chef_run).to create_file('/usr/share/tomcat/webapps/activiti-app.war').with(
      user: 'tomcat',
      group: 'tomcat'
    )
  end

  it 'creates if missing a mysql remote file' do
    chef_run.node.normal['aps-core']['mysql_driver']['version'] = '5.1.32'
    chef_run.converge(described_recipe)
    expect(chef_run).to create_remote_file_if_missing('/var/chef/cache/mysql-connector-java-5.1.32.jar').with(
      user: 'tomcat',
      group: 'tomcat'
    )
  end

  it 'creates a mysql file' do
    expect(chef_run).to create_file('/usr/share/tomcat/lib/mysql-connector-java.jar').with(
      user: 'tomcat',
      group: 'tomcat'
    )
  end

  it 'creates if missing a postgres remote file' do
    chef_run.node.normal['aps-core']['db']['engine'] = 'postgres'
    chef_run.node.normal['aps-core']['postgres_driver']['version'] = '42.1.1'
    chef_run.converge(described_recipe)
    expect(chef_run).to create_remote_file_if_missing('/var/chef/cache/postgresql-42.1.1.jar').with(
      user: 'tomcat',
      group: 'tomcat'
    )
  end

  it 'creates a postgres remote file' do
    chef_run.node.normal['aps-core']['db']['engine'] = 'postgres'
    chef_run.converge(described_recipe)
    expect(chef_run).to create_file('/usr/share/tomcat/lib/postgresql.jar').with(
      user: 'tomcat',
      group: 'tomcat'
    )
  end
end
