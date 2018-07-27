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

rb_tr_file '/etc/apt/sources.list' do
  source_file '/etc/apt/sources.list'
  search_regexp ' http.*/ubuntu/? '
  string_to_be ' https://def-nexus.default.don/repository/ubuntu/ '
  action :translate
end

