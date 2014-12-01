#
# Cookbook Name:: factorialapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

begin
  app_path = node[:factorialapp][:app_path]
rescue
  app_path = "/vagrant"
end

package "python-pip"

execute "install-python-module" do
  command "pip install -r #{app_path}/requirements.txt"
end

