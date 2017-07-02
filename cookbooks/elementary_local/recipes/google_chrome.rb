#
# Cookbook:: elementary_local
# Recipe:: default
#
# Copyright:: 2017, Aravind Kumar, All Rights Reserved.

#Includes the Google Chrome apt repository
apt_repository 'google-chrome' do
  uri node["chrome"]["apt_repository"]["uri"]
  arch node["chrome"]["apt_repository"]["arch"]
  distribution node["chrome"]["apt_repository"]["distribution"]
  components node["chrome"]["apt_repository"]["components"]
  key node["chrome"]["apt_key"]["uri"]
  if node["chrome"]["action"] == "install"
    action node["chrome"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Updates APT cache
apt_update 'update' do
  action :update
  only_if { defined? node["chrome"]["action"] && node["chrome"]["action"] == "install" }
end

# Installs Google Chrome
package "google-chrome-" + node["chrome"]["release"] do
  action node["chrome"]["action"].to_sym
  if node["chrome"]["action"] == "remove"
    notifies node["chrome"]["apt_repository"]["action"].to_sym, 'apt_repository[google-chrome]', :immediately
  end 
end
