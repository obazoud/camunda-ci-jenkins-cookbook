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

node.set['jenkins']['master']['version'] = node['camunda']['jenkins']['version']
node.set['jenkins']['master']['home'] = node['camunda']['jenkins']['home']
node.set['jenkins']['master']['user'] = node['camunda']['jenkins']['user']
node.set['jenkins']['executor']['timeout'] = node['camunda']['jenkins']['installation']['timeout']

include_recipe 'jenkins::master'

if node['camunda']['jenkins']['plugins'].any?
  include_recipe 'camunda-ci-jenkins::plugins'
end

include_recipe 'camunda-ci-jenkins::_users'

include_recipe 'camunda-ci-jenkins::config'

include_recipe 'camunda-ci-jenkins::jobs'
