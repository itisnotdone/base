#
# Cookbook:: base
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

include_recipe 'chef-client::default'
include_recipe 'chef-client::config'
include_recipe 'apt::default'
include_recipe 'base::user'

rb_tr_file 'blahblah' do
  source_file '/etc/apt/source.list'
  as_is 'blahblah'
  to_be 'blahblah'
  action :translate
end

