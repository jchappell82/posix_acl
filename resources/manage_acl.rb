#
# Cookbook Name:: posix-acl
# Resources:: manage
#
# Copyright (C) 2013 Jon Chappell
#
# All rights reserved - Do Not Redistribute
#

# You'll need to explicitly use an "action": "remove" to delete an ACL template
actions :apply, :remove

default_action :apply

attribute :apply_to, :kind_of => String
attribute :template_name, :kind_of => String, :required => true
attribute :wrapper_cookbook, :kind_of => String, :default => "posix-acl"

