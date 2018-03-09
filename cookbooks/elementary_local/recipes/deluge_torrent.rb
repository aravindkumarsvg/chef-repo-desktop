#
# Cookbook:: elementary_local
# Recipe:: deluge_torrent
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Adds the deluge repository
apt_repository "deluge" do
  uri node["deluge"]["apt_repository"]["uri"]
  arch node["deluge"]["apt_repository"]["arch"]
  distribution node["deluge"]["apt_repository"]["distribution"]
  if node["deluge"]["action"] == "install"
    action node["deluge"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Updates APT cache
apt_update 'update' do
  action :update
  only_if { defined? node["deluge"]["action"] && node["deluge"]["action"] == "install" }
end

# Installs deluge package
package node["deluge"]["packages"] do
  action node["deluge"]["action"].to_sym
  if node["deluge"]["action"] == "remove"
    notifies node["deluge"]["apt_repository"]["action"].to_sym, 'apt_repository[deluge]', :immediately 
  end
end