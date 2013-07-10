#
# Cookbook Name:: posix-acl
# Provider:: manage
#
# Copyright (C) 2013 Jon Chappell
#
# All rights reserved - Do Not Redistribute
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
