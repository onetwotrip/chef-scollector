default['scollector']['bin_path']        = "#{node['go']['gobin']}/scollector"
default['scollector']['conf_dir']        = '/etc/scollector'
default['scollector']['log_dir']         = '/var/log/scollector'
default['scollector']['collectors_dir']  = '/etc/scollector/collectors'

# 'source' for go get or 'package' if you have custom repository
default['scollector']['install_method'] = 'source'

# '' for install, 'latest' for upgrade, or specific e.g. '0.3.0'
# only works with package install
default['scollector']['version'] = ''

default['go']['packages']                = ['bosun.org/cmd/scollector']

default['scollector']['config'] = {
  'Host' => 'http://127.0.0.1:8070',
  'tags' => {
    'environment' => node.chef_environment,
    'role' => node.run_list.roles.first || 'unknown',
  },
  'ColDir' => node['scollector']['collectors_dir'],
}
