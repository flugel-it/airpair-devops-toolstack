cookbook_path    ["cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "cookbooks"

log_level                :info
log_location             STDOUT
syntax_check_cache_path  '~/.chef/syntax_check_cache'

if ::File.exist?(File.expand_path("~/.chef/knife.local.rb", __FILE__))
  unless Chef::Config[:local_mode]
    Chef::Config.from_file(File.expand_path("~/.chef/knife.local.rb", __FILE__))
  end
end

