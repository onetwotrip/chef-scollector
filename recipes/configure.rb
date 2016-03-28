#
# Cookbook Name:: bosun
# Recipe:: default
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

include_recipe 'runit'

chef_gem 'toml' do
  action :remove
end

chef_gem 'toml-rb'

require 'toml'

[
node['scollector']['conf_dir'],
node['scollector']['collectors_dir'],
].each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

file node['scollector']['config_path'] do
  content TOML.dump(node['scollector']['config'])
end

runit_service 'scollector' do
  cookbook node['scollector']['config_cookbook']
  ignore_failure node['scollector']['ignore_failure']
  restart_on_update true
  subscribes :restart, "file[#{node['scollector']['config_path']}]", :delayed
end
