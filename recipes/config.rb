#
# Cookbook Name:: camunda-ci-jenkins
# Recipe:: default
#
# Copyright (C) 2014 Christian Lipphardt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# read credentials from data_bag
credentials_bag_name = 'credentials'
credentials_bag = data_bag(credentials_bag_name)
log "Using credentials '#{credentials_bag}' from data_bag '#{credentials_bag_name}'"

credentials = Hash.new
unless credentials_bag.nil?
  credentials_bag.each do |credentials_item_id|

    begin
      credentials_item = encrypted_data_bag_item(credentials_bag_name, credentials_item_id)
    rescue
      credentials_item = data_bag_item(credentials_bag_name, credentials_item_id)
    end

    log "credentials_item: #{credentials_item.inspect}"

    credentials[credentials_item_id] = credentials_item.to_hash
  end
end

# read docker images configs from data_bag
docker_images_bag_name = 'docker_images'
docker_images_bag = data_bag(docker_images_bag_name)
log "Using docker image configs '#{docker_images_bag}' from data_bag '#{docker_images_bag_name}'"

docker_images_configs = Hash.new
unless docker_images_bag.nil?
  docker_images_bag.each do |docker_image_item_id|

    begin
      docker_image_item = encrypted_data_bag_item(docker_images_bag_name, docker_image_item_id)
    rescue
      docker_image_item = data_bag_item(docker_images_bag_name, docker_image_item_id)
    end

    log "docker_image_item: #{docker_image_item.inspect}"

    docker_images_configs[docker_image_item_id] = docker_image_item.to_hash
  end
end

# create credentials for all data_bag_items with 'docker' in their id
docker_credentials = credentials.select { |key, value| key.start_with?('docker') }
log "Docker Credentials: #{docker_credentials}"
docker_credentials.each_value do |docker_credential|

  log "Docker Credential: #{docker_credential}"

  login = docker_credential['login'] || docker_credential['id']
  private_key = docker_credential['ssh_key']
  password = docker_credential['password']
  credentials_id = docker_credential['credentialsId'] || ''
  description = docker_credential['description'] || docker_credential['id']

  # jenkins_private_key_credentials login do
  #   id credentials_id unless credentials_id.empty?
  #   private_key File.read(private_key)
  #   description description
  #   only_if { !private_key.nil? && ::File.exist?(private_key) }
  # end

  jenkins_password_credentials login do
    id credentials_id unless credentials_id.empty?
    password password
    description description
    not_if { password.nil? }
  end
end

template 'config.xml' do
  source 'config.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/config.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  variables(
    config: node['camunda']['jenkins']['config'],
    docker_config: node['camunda']['jenkins']['docker']['config'],
    docker_images_configs: docker_images_configs,
    docker_credentials: credentials['docker']
  )
  notifies :restart, 'service[jenkins]', :delayed
end

template 'hudson.tasks.Ant.xml' do
  source 'hudson.tasks.Ant.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/hudson.tasks.Ant.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  variables(
    ants: node['camunda']['jenkins']['config']['tools']['ant']
  )
  notifies :restart, 'service[jenkins]', :delayed
end

template 'hudson.tasks.Maven.xml' do
  source 'hudson.tasks.Maven.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/hudson.tasks.Maven.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  variables(
    mavens: node['camunda']['jenkins']['config']['tools']['maven']
  )
  notifies :restart, 'service[jenkins]', :delayed
end

template 'hudson.plugins.groovy.Groovy.xml' do
  source 'hudson.plugins.groovy.Groovy.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/hudson.plugins.groovy.Groovy.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  variables(
    groovys: node['camunda']['jenkins']['config']['tools']['groovy']
  )
  notifies :restart, 'service[jenkins]', :delayed
end

template 'hudson.tools.JDKInstaller.xml' do
  source 'hudson.tools.JDKInstaller.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/hudson.tools.JDKInstaller.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  variables(
    username: credentials['jdk_installer']['login'],
    password: credentials['jdk_installer']['password']
  )
  notifies :restart, 'service[jenkins]', :delayed
  not_if credentials['jdk_installer'].nil?
end

template 'jenkins.model.JenkinsLocationConfiguration.xml' do
  source 'jenkins.model.JenkinsLocationConfiguration.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/jenkins.model.JenkinsLocationConfiguration.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  variables(
    admin_email: node['camunda']['jenkins']['admin_email'],
    url: node['camunda']['jenkins']['url']
  )
  notifies :restart, 'service[jenkins]', :delayed
end

template 'maven-settings-files.xml' do
  source 'maven-settings-files.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/maven-settings-files.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  notifies :restart, 'service[jenkins]', :delayed
end

cookbook_file "org.jenkinsci-main.modules.sshd.SSHD.xml" do
  source "#{Chef::Config[:file_path_cache]}/org.jenkinsci-main.modules.sshd.SSHD.xml"
  path "#{node['camunda']['jenkins']['home']}/org.jenkinsci-main.modules.sshd.SSHD.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  backup 1
  notifies :restart, 'service[jenkins]', :delayed
end

cookbook_file 'hudson.plugins.git.GitSCM.xml' do
  source "#{Chef::Config[:file_path_cache]}/hudson.plugins.git.GitSCM.xml"
  path "#{node['camunda']['jenkins']['home']}/hudson.plugins.git.GitSCM.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  backup 1
  notifies :restart, 'service[jenkins]', :delayed
end

cookbook_file 'hudson.plugins.emailext.ExtendedEmailPublisher.xml' do
  source "#{Chef::Config[:file_path_cache]}/hudson.plugins.emailext.ExtendedEmailPublisher.xml"
  path "#{node['camunda']['jenkins']['home']}/hudson.plugins.emailext.ExtendedEmailPublisher.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  backup 1
  notifies :restart, 'service[jenkins]', :delayed
end

cookbook_file 'hudson.maven.MavenModuleSet.xml' do
  source "#{Chef::Config[:file_path_cache]}/hudson.maven.MavenModuleSet.xml"
  path "#{node['camunda']['jenkins']['home']}/hudson.maven.MavenModuleSet.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  backup 1
  notifies :restart, 'service[jenkins]', :delayed
end

cookbook_file 'jenkins.mvn.GlobalMavenConfig.xml' do
  source "#{Chef::Config[:file_path_cache]}/jenkins.mvn.GlobalMavenConfig.xml"
  path "#{node['camunda']['jenkins']['home']}/jenkins.mvn.GlobalMavenConfig.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
  backup 1
  notifies :restart, 'service[jenkins]', :immediately
end

# ATTENTION: last action should always include a restart of service[jenkins]
