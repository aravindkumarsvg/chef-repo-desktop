#
# Cookbook:: elementary_local
# Recipe:: neovim
#
# Copyright:: 2017, Aravind Kumar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Adds the Neovim repository
apt_repository "neovim" do
  uri node["neovim"]["apt_repository"]["uri"]
  arch node["neovim"]["apt_repository"]["arch"]
  distribution node["neovim"]["apt_repository"]["distribution"]
  if node["neovim"]["action"] == "install"
    action node["neovim"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Updates APT cache
apt_update 'update' do
  action :update
  only_if { defined? node["neovim"]["action"] && node["neovim"]["action"] == "install" }
end

# Installs Neovim package
package "neovim" do
  action node["neovim"]["action"].to_sym
  if node["neovim"]["action"] == "remove"
    notifies node["neovim"]["apt_repository"]["action"].to_sym, 'apt_repository[neovim]', :immediately 
  end
end

# Creates the vim-plug directory
directory node["neovim"]["vim_plug"]["path"] do
  recursive true
  owner node["user"]
  group node["group"]
  mode node["neovim"]["vim_plug"]["mode"]
  if node["neovim"]["action"] == "install"
    action node["neovim"]["vim_plug"]["action"].to_sym
  else
    action :nothing
  end
end

# Creates the vim-plug plug-in directory
directory node["neovim"]["vim_plug"]["plugin_path"] do
  recursive true
  owner node["user"]
  group node["group"]
  mode node["neovim"]["vim_plug"]["mode"]
  if node["neovim"]["action"] == "install"
    action node["neovim"]["vim_plug"]["action"].to_sym
  else
    action :nothing
  end
end

# Installs vim-plug Neovim pluggin manager
remote_file node["neovim"]["vim_plug"]["file_path"] do
  source node["neovim"]["vim_plug"]["uri"]
  owner node["user"]
  group node["group"]
  mode node["neovim"]["vim_plug"]["mode"]
  action node["neovim"]["vim_plug"]["action"].to_sym
  if node["neovim"]["action"] == "remove"
    notifies node["neovim"]["vim_plug"]["action"].to_sym, "directory[" + node["neovim"]["vim_plug"]["path"] + "]", :immediately
  end
end

# Creates the Plugin file
cookbook_file node["neovim"]["vim_plug"]["plugin_file_path"] do
  source node["neovim"]["vim_plug"]["plugin_file"]
  owner node["user"]
  group node["group"]
  mode node["neovim"]["vim_plug"]["mode"]
  action node["neovim"]["vim_plug"]["action"].to_sym
  if node["neovim"]["action"] == "remove"
    notifies node["neovim"]["vim_plug"]["action"].to_sym, "directory[" + node["neovim"]["vim_plug"]["plugin_path"] + "]", :immediately
  end
end