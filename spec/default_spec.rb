require 'chefspec'

describe 'posix_acl::default' do
  let(:chef_run) {
    ChefSpec::ChefRunner.new.converge 'posix_acl::default'
  }
  it 'includes enable_acl' do
    chef_run.should include_recipe 'posix_acl::enable_acl'
  end
end