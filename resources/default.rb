actions(:create, :delete)
default_action(:create)
attribute(:config_path, kind_of: String, required: false,
          default: "#{node['scollector']['conf_dir']}/scollector.toml")
attribute(:config, kind_of: Hash, required: false, default: {})
