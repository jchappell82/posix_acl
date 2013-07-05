require 'chefspec'

describe 'posix_acl::enable_acl' do
  let(:runner) {
    ChefSpec::ChefRunner.new
  }
  let(:chef_run) {
    runner.node.set['posix_acl'] = {
      :fstab_path => 'file',
      :fstab_backup => '/etc/fstab.bak',
      :mount_point_device => 'LABEL=cloudimg-rootfs',
      :mount_point => '/',
      :template_store => '/usr/local/lib'
    }
    runner.converge 'posix_acl::enable_acl'
  }
  it 'installs the acl package' do
    chef_run.should install_package 'acl'
  end
  it 'runs the ruby block to add the acl param' do
    chef_run.should execute_ruby_block 'modify_fstab'
  end
end
