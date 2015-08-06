default['scollector']['bin_path'] 	= "#{node['go']['gobin']}/scollector"
default['scollector']['conf_dir'] 	= '/etc/scollector'
default['scollector']['log_dir'] 	= '/var/log/scollector'
default['scollector']['collectors_dir'] = '/etc/scollector/collectors'
default['scollector']['config_cookbook'] = 'scollector'
default['go']['packages']           	= ['bosun.org/cmd/scollector']

default['scollector']['custom_repo'] = false
default['scollector']['config'] = {
  'Host' => 'http://127.0.0.1:8070',
  'tags' => {
    'environment' => node.chef_environment,
    'role' => node.run_list.roles.first || 'unknown',
  },
  'ColDir' => node['scollector']['collectors_dir'],
}
