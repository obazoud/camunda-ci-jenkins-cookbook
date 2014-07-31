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
include_recipe 'chef-sugar::default'

user_account node['camunda']['jenkins']['user'] do
  password node['camunda']['jenkins']['password']
  ssh_keygen true
end

if includes_recipe?('docker::default')
  group 'docker' do
    action :manage
    members node['camunda']['jenkins']['user']
    append true
    notifies :restart, 'service[docker]', :immediately
    # only_if { node.has_recipe?('docker') }
  end
end

remote_file "/home/#{node['camunda']['jenkins']['user']}/.ssh/jenkins-ci-insecure" do
  source 'https://raw.githubusercontent.com/camunda-ci/camunda-docker-ci-base/master/keys/jenkins-ci-insecure'
  use_last_modified false # true by default
  mode '600'
  owner node['camunda']['jenkins']['user']
  group node['camunda']['jenkins']['group']
end
