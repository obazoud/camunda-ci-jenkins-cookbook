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
if node['camunda']['jenkins']['security']['enabled'] && node['camunda']['jenkins']['security']['mode'] == 'password'

  jenkins_users_bag_name = 'jenkins_users'
  jenkins_users_bag = data_bag(jenkins_users_bag_name)

  unless jenkins_users_bag.nil?
    defined_users = node['camunda']['jenkins']['security']['jenkins_users']

    defined_users.each do |defined_user|

      jenkins_user = data_bag_item(jenkins_users_bag_name, defined_user)

      unless jenkins_user.nil?
        login = jenkins_user['login'] || jenkins_user['id']
        password = jenkins_user['password'] || login
        full_name = jenkins_user['full_name'] || login
        email = jenkins_user['email'] || "#{login}@camunda.com"
        ssh_keys = jenkins_user['ssh_keys'] || []

        jenkins_user login do
          password password
          full_name full_name
          email email
          public_keys ssh_keys
        end
      end
    end
  end
end
