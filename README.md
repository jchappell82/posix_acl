# posix-acl cookbook

# Requirements
This cookbook is only being tested against Chef 11.4.4 at this time.

# Usage
In order to use this cookbook, you'll need to "wrap" it in an implementing cookbook with all of the
ACL templates, or specific ACL patterns you wish to apply.

To begin, simply add ```include_recipe "posix-acl::default"``` to your implementing cookbook.  This
will ensure that acl support is enabled and that the requisite OS package is installed.

This is an example of how to create a template from within your wrapper cookbook:

```ruby
posix_acl_manage_template 'vagrant_template' do
  action :create # This can also be :delete
  template_name 'vagrant_template'
  template_content %w{
    user::rwx
    user:vagrant:rwx
    group::rwx
    group:vagrant:rwx
    mask::rwx
    other::r-X
    default:user::rwx
    default:user:vagrant:rwx
    default:group::rwx
    default:group:vagrant:rwx
    default:mask::rwx
    default:other::r-X
  }
end
```

This is an example of applying ACLs from a template that has been created:

posix_acl_manage_acl 'apply_vagrant' do
  action :apply  # This can also be :remove
  apply_to '/opt'
  template_name 'vagrant_template' # If you are removing ACLs, you don't need this.
  recursive true
end

# Attributes

#### This is the full path to the fstab file you are using.
```default['posix_acl']['fstab_path'] = '/etc/fstab'```
#### This is the full path to the backup file you wish to create.
```default['posix_acl']['fstab_backup'] = '/etc/fstab.bak'```
#### This is the physical device (or partition label) you wish for the cookbook to enable ACLs on. e.g. - "/dev/sda1" (or just "sda1" is ok) or "LABEL=server-store
```default['posix_acl']['mount_point_device'] = 'LABEL=cloudimg-rootfs'```
#### This is the actual mount point you are enabling ACLs on.
```default['posix_acl']['mount_point'] = '/'```
#### This is where the cookbook will be storing ACL templates when they are applied.
```default['posix_acl']['template_store'] = '/usr/local/lib'```

# Author

Author:: Jon Chappell (jon@jchome.us)
