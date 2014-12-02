#
# Cookbook Name:: factorialapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

app_path = "/opt/airpair-devops-toolstack"
if not ::File.exists?(app_path)
  app_path = "/vagrant"
end

package "python-pip"

execute "install-python-module" do
  command "pip install -r #{app_path}/requirements.txt"
end

