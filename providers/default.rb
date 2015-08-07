include Scollector::Helpers

def initialize(new_resource, run_context)
  super
  @config = new_resource.config
  @run_context = run_context
end

action :create do
  create_config
end

private

def create_config
  ::Scollector::Helpers.render_config(@config, @run_context, new_resource.config_path)
end
