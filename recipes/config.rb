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
template 'config.xml' do
  source 'config.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/config.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  variables(
    config: node['camunda']['jenkins']['config'],
    docker_config: node['camunda']['jenkins']['docker']['config']
  )
end

template 'hudson.tasks.Ant.xml' do
  source 'hudson.tasks.Ant.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/hudson.tasks.Ant.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  variables(
    ants: node['camunda']['jenkins']['config']['tools']['ant']
  )
end

template 'hudson.tasks.Maven.xml' do
  source 'hudson.tasks.Maven.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/hudson.tasks.Maven.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  variables(
    mavens: node['camunda']['jenkins']['config']['tools']['maven']
  )
end

template 'hudson.plugins.groovy.Groovy.xml' do
  source 'hudson.plugins.groovy.Groovy.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/hudson.plugins.groovy.Groovy.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  variables(
    groovys: node['camunda']['jenkins']['config']['tools']['groovy']
  )
end

template 'hudson.tools.JDKInstaller.xml' do
  source 'hudson.tools.JDKInstaller.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/hudson.tools.JDKInstaller.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  variables(
    username: node['camunda']['jenkins']['config']['tools']['jdk_installer']['username'],
    password: node['camunda']['jenkins']['config']['tools']['jdk_installer']['password']
  )
end

template 'jenkins.model.JenkinsLocationConfiguration.xml' do
  source 'jenkins.model.JenkinsLocationConfiguration.xml.erb'
  path "#{node['camunda']['jenkins']['home']}/jenkins.model.JenkinsLocationConfiguration.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  variables(
    admin_email: node['camunda']['jenkins']['admin_email'],
    url: node['camunda']['jenkins']['url']
  )
end

cookbook_file "org.jenkinsci-main.modules.sshd.SSHD.xml" do
  source "#{Chef::Config[:file_path_cache]}/org.jenkinsci-main.modules.sshd.SSHD.xml"
  path "#{node['camunda']['jenkins']['home']}/org.jenkinsci-main.modules.sshd.SSHD.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  backup 1
end

cookbook_file 'hudson.plugins.git.GitSCM.xml' do
  source "#{Chef::Config[:file_path_cache]}/hudson.plugins.git.GitSCM.xml"
  path "#{node['camunda']['jenkins']['home']}/hudson.plugins.git.GitSCM.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  backup 1
end

cookbook_file 'hudson.plugins.emailext.ExtendedEmailPublisher.xml' do
  source "#{Chef::Config[:file_path_cache]}/hudson.plugins.emailext.ExtendedEmailPublisher.xml"
  path "#{node['camunda']['jenkins']['home']}/hudson.plugins.emailext.ExtendedEmailPublisher.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  backup 1
end

cookbook_file 'hudson.maven.MavenModuleSet.xml' do
  source "#{Chef::Config[:file_path_cache]}/hudson.maven.MavenModuleSet.xml"
  path "#{node['camunda']['jenkins']['home']}/hudson.maven.MavenModuleSet.xml"
  mode '0755'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['user']
  backup 1
  notifies :restart, 'service[jenkins]', :immediately
end

#### ATTENTION: last action should always include a restart of service[jenkins]