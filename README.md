scollector Cookbook
===================

This cookbook downloads and installs [scollector](https://github.com/bosun-monitor/bosun/tree/master/cmd/scollector) for [Bosun](bosun.org).


Requirements
------------
- Chef Client 11.x or better

### Platforms
Currently tested only on Ubuntu 14.04. Probably works on Debain and may work on other.


### Dependent Cookbooks
- runit
- golang

Attributes
----------

* `node['scollector']['bin_path']` - Sets path to scollector executable
* `node['scollector']['conf_dir']` - Sets dir for scollector config dir
* `node['scollector']['log_dir']` - Sets dir for logs dir
* `node['scollector']['collectors_dir']`  - Sets dir for external collectors (scollector runs all executables every `interval` sec in collectors_dir/`interval`/)
* `node['scollector']['config]` - sets a hash of configuration values that are marshaled to conf_dir/scollector.toml
* `node['scollector']['install_method']` - Installation method, 'source' for `go get`, `package` uses standard Chef `package` resource, you must provide a repository that contains `scollector` package
* `node['scollector']['version']` - Package version, only works with `package` installation method, use:
* * '' for plain `:install`
* * `latest` for `:upgrade`
* * `0.2.0` for specific version install

Recipes
-------
This section describes the recipes in the cookbook and how to use them in your environment.

### default
Includes the `scollector::configure` and either `golang::packages` or `scollector::install_package` depending on `node['scollector']['install_method']` attribute value.

### configure
Enables runit service for scollector and marshals `node['scollector']['config']` content into `scollector.toml` file.

Usage
-----

You can include `scollector::default` in your company cookbook and redefine attributes there like
### companyname-scollector/attributes/default.rb:
```ruby
default['scollector']['host'] = '192.168.169.21'
default['scollector']['port'] = 8070
default['scollector']['config'] = {
    'Host' => 'https://user:password@bosun.example.com/',
    'tags' => {
      'environment' => node.chef_environment,
      'role' => node.run_list.roles.first || 'unknown',
    },
    'ColDir' => node['scollector']['collectors_dir'],
    'ICMP' => [
      {'Host'  => 'google.com' },
      {'Host'  => 'test.example.com' },
    ],
}
```

Or you can redefine it in your role or environment.

NOTE: Make sure that you are using golang cookbook from github (see Berksfile).

You can also append configuration snippets in other cookbooks (e.g. include metrics collection for nginx in nginx cookbook), just make sure `scollector::default` is included into run_list.
```ruby
### companyname-nginx/attributes/default.rb:
default['scollector']['config'] = node['scollector']['config']
                                  .merge({
                                           'Process' => [
                                             {
                                               'Name' => 'nginx',
                                               'Command' => '/usr/sbin/nginx',
                                               'Args' => '.*',
                                             },
                                           ]
                                         })
```                                         

Testing
-----
[Kitchen](http://kitchen.ci) tests via [busser-serverspec](https://github.com/test-kitchen/busser-serverspec):

* `kitchen test`


License & Authors
-----------------
- Author:: Tony Nyurkin (<ptqa.mail@gmail.com>)
- Author:: Dima Medvedev (<dima@medvedev.io>)

```text

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
