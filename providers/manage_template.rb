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
  directory "#{node['posix_acl']['template_store']}" do
    action :create
    owner 'root'
    mode 00775
    group 'root'
  end

  cookbook_file "#{node['posix_acl']['template_store']}/#{new_resource.template_name}" do
    action :create
    owner 'root'
    mode 00664
    group 'root'
    source "#{new_resource.template_name}"
  end
end

action :delete do
  cookbook_file "#{node['posix_acl']['template_store']}/#{new_resource.template_name}" do
    action :delete
  end
end