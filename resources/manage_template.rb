#
# Cookbook Name:: posix-acl
# Resources:: manage
#
# Copyright (C) 2013 Jon Chappell
#
# All rights reserved - Do Not Redistribute
#

# You'll need to explicitly use an "action": "remove" to delete an ACL template
actions :create, :delete

default_action :create

attribute :template_name, :kind_of => String, :required => true, :default => name
attribute :template_content, :kind_of => Array, :required => true
