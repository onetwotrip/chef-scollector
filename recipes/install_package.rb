case node['scollector']['version']
when ''
  package 'scollector' do
    action :install
    notifies :restart, "service[scollector]"
  end
when 'latest'
  package 'scollector' do
    action :upgrade
    notifies :restart, "service[scollector]"
  end
else
  package 'scollector' do
    action :install
    version node['scollector']['version']
    notifies :restart, "service[scollector]"
  end
end
