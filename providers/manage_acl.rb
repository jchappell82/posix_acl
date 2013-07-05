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
