#
# Cookbook Name:: posix_acl
# Attributes:: default
#
# Copyright 2013, Jon Chappell.
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

# This is the full path to the fstab file you are using.
default['posix_acl']['fstab_path'] = '/etc/fstab'
# This is the full path to the backup file you wish to create.
default['posix_acl']['fstab_backup'] = '/etc/fstab.bak'
# This is the physical device (or partition label) you wish for the cookbook
# to enable ACLs on.  e.g. - "/dev/sda1" (or just "sda1" is ok)
# or "LABEL=server-store
default['posix_acl']['mount_point_device'] = 'LABEL=cloudimg-rootfs'
# This is the actual mount point you are enabling ACLs on.
default['posix_acl']['mount_point'] = '/'
# This is where the cookbook will be storing ACL templates when they are applied.
default['posix_acl']['template_store'] = '/usr/local/lib'