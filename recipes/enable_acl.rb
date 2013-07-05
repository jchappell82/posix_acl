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
execute 'remount_fs' do
  action :nothing
  command "mount -o remount #{node['posix_acl']['mount_point']}"
  user 'root'
end


## Modify the fstab file provided in attributes to include the acl flag.
# FIXME: Ideally, I'll work out a way to apply this to an array of mount points instead of just one

ruby_block 'modify_fstab' do
  action :create
  block do
    # Back up our original file, because bad things can happen.
    %x[ cp #{node['posix_acl']['fstab_path']} #{node['posix_acl']['fstab_backup']} ]

    # Open our file as specified via attributes and read it to a variable
    f = File.open(node['posix_acl']['fstab_path'], 'r').read

    # Now we're going to split on newlines.
    f = f.split("\n")

    # And again on whitespace!
    f.each_with_index do |line, index|
      f[index] = f[index].split(' ')
    end

    # Now we'll add the requisite 'acl' flag to the fstab opts.
    f.each_with_index do |line, index|
      if f[index][0].include? node['posix_acl']['mount_point_device']
        f[index][3] = f[index][3] + ',acl'
      end
    end

    # Put it all back together
    f.each_with_index do |line, index|
      f[index] = f[index].join(' ')
    end
    # One line per entry
    f = f.join("\n")
    f = f + "\n"

    # SAVE ALL THE THINGS
    out = File.open(node['posix_acl']['fstab_path'], 'w')
    out.write(f)
    out.close
  end
  not_if "grep -e #{node['posix_acl']['mount_point_device']} #{node['posix_acl']['fstab_path']} | grep -e acl"
  notifies :run, 'execute[remount_fs]', :immediately
end

