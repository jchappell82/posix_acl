





# This is the full path to the fstab file you are using.
default['posix_acl']['fstab_path'] = "/etc/fstab"
# This is the full path to the backup file you wish to create.
default['posix_acl']['fstab_backup'] = "/etc/fstab.bak"
# This is the physical device (or partition label) you wish for the cookbook
# to enable ACLs on.  e.g. - "/dev/sda1" or "LABEL=server-store"
default['posix_acl']['mount_point_device'] = "LABEL=cloudimg-rootfs"
# This is the actual mount point you are enabling ACLs on.
default['posix_acl']['mount_point'] = "/"
# This is where the cookbook will be storing ACL templates when they are applied.
default['posix_acl']['template_store'] = "/usr/local/lib"