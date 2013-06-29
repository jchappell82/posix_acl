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


####################################################################################
# We only need to do this block if the required 'acl' flag is not already in place #
####################################################################################

# FIXME: I need to work out a way to apply this to an array of mount points instead of just one
# I think I can do that with something like "#node{posix_acl}{mount_points}".each do |mountpoint|

# Open our file as specified via attributes and read it to a variable
f = File.open("#{node.posix_acl.fstab_path}", 'r').read

# Now we're going to split on newlines.
f = f.split("\n")

# And again on whitespace!
f.each_with_index do |line|
  f[index] = f[index].split(" ")
end

# Now we'll add the requisite 'acl' flag to the fstab opts.
f.each_with_index do |line, index|
  f[index][0].include? 'xvda1'
  f[index][3] = f[index][3] + ',acl'
end

# Put it all back together
f.each_with_index do |line, index|
  f[index] = f[index].join(" ")
end
# One line per entry
f = f.join("\n")

# SAVE ALL THE THINGS
out = File.open("#{node.posix_acl.fstab_path}", 'w')
out.write(f)
out.close

acl_flag_applied = true

execute 'remount_root' do
  action  :run, :immediately
  not_if acl_flag_applied == true
end

####################################################################################


# We can get rid of all of the below once the stuff above works.

# Set acl flag for filesystems

# We are going to set the acl flag for anything that has an "atime" flag in fstab
# as that should account for many normal filesystems.  We will assume this is
# not needed if fstab has any mention of the word acl.

#bash 'root_set_acl' do
#  code <<-EOH
#    cp /etc/fstab /etc/fstab.bak
#    sed -i s/atime/atime,acl/g /etc/fstab
#  EOH
#  cwd '/etc'
#  not_if 'grep -q -e "acl" /etc/fstab'
#  notifies :run, 'execute[remount_root]', :immediately
#  user 'root'
#end
