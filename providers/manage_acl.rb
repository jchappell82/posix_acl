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

action :apply do
  if new_resource.recursive
    recursive_flag = '-R '
  else
    recursive_flag = ''
  end
  bash 'apply_acl_template' do
    code <<-EOH
    setfacl -b #{recursive_flag}#{new_resource.apply_to}
    setfacl #{recursive_flag}--set-file=#{node['posix_acl']['template_store']}/#{new_resource.template_name} #{new_resource.apply_to}
    EOH
    user 'root'
  end
  new_resource.updated_by_last_action(true)
end

action :remove do
  if new_resource.recursive
    recursive_flag = '-R '
  else
    recursive_flag = ''
  end
  bash 'remove_acl_template' do
    code <<-EOH
      setfacl -b #{recursive_flag}#{new_resource.apply_to}
    EOH
  end
  new_resource.updated_by_last_action(true)
end
