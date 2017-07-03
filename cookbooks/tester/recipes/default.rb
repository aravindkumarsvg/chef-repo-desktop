#
# Cookbook:: tester
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

directory '/home/aravind/Documents/hi' do
  recursive true
  action :delete
end