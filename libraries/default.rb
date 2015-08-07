require 'chef/resource/chef_gem'

module Scollector
  module Helpers
    def self.render_config(hash, run_context, config_file)
      install_toml(run_context)
      require_toml
      config_file(hash, run_context, config_file)
    end

    def self.install_toml(run_context)
      toml_gem = Chef::Resource::ChefGem.new('toml', run_context)
      toml_gem.run_action :install
    end

    def self.require_toml
      require 'toml'
    end

    def self.config_file(hash, run_context, config_file)
      f = Chef::Resource::File.new(config_file, run_context)
      f.owner 'root'
      f.mode  00644
      f.content TOML::Generator.new(hash).body
      f.run_action :create
    end
  end
end
