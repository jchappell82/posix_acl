#
# Cookbook Name:: posix_acl
# Recipe:: enable_acl
#
# Copyright 2013, Jon Chappell.
#
# All rights reserved - Do Not Redistribute
#

# Enables ACL support for filesystems

# Install the ACL package
package 'acl'

# Remounts the root filesystem when called
execute 'remount_root' do
  action :nothing
  command 'mount -o remount /'
end


# Set acl flag for filesystems

# We are going to set the acl flag for anything that has an "atime" flag in fstab
# as that should account for many normal filesystems.  We will assume this is
# not needed if fstab has any mention of the word acl.

bash 'root_set_acl' do
  code <<-EOH
    cp /etc/fstab /etc/fstab.bak
    sed -i s/atime/atime,acl/g /etc/fstab
  EOH
  cwd '/etc'
  not_if 'grep -q -e "acl" /etc/fstab'
  notifies :run, 'execute[remount_root]', :immediately
  user 'root'
end
