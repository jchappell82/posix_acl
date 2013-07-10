#
# Cookbook Name:: posix-acl
# Provider:: manage
#
# Copyright (C) 2013 Jon Chappell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  directory node['posix_acl']['template_store'] do
    action :create
    owner 'root'
    mode 00775
    group 'root'
  end

  template "#{node['posix_acl']['template_store']}/#{new_resource.template_name}" do
    action :create
    cookbook 'posix_acl'
    owner 'root'
    mode 00664
    group 'root'
    source 'acl_template.erb'
    variables :template_content => new_resource.template_content
  end

  new_resource.updated_by_last_action(true)
end

action :delete do
  file "#{node['posix_acl']['template_store']}/#{new_resource.template_name}" do
    action :delete
  end
end
