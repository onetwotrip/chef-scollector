case node['scollector']['version']
when ''
  package 'scollector' do
    action :install
  end
when 'latest'
  package 'scollector' do
    action :upgrade
  end
else
  package 'scollector' do
    action :install
    version node['scollector']['version']
  end
end
