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