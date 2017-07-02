#
# Cookbook:: elementary_local
# Recipe:: sublime_text
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

#Includes the Sublime Text apt repository
apt_repository 'sublime-text' do
  uri node["sublime_text"]["apt_repository"]["uri"]
  distribution node["sublime_text"]["apt_repository"]["distribution"]
  key node["sublime_text"]["apt_key"]["uri"]
  if node["sublime_text"]["action"] == "install"
    action node["sublime_text"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Updates APT cache
apt_update 'update' do
  action :update
  only_if { defined? node["sublime_text"]["action"] && node["sublime_text"]["action"] == "install" }
end

# Installs Sublime Text
package "sublime-text" do
  action node["sublime_text"]["action"].to_sym
  if node["sublime_text"]["action"] == "remove"
    notifies node["sublime_text"]["apt_repository"]["action"].to_sym, 'apt_repository[sublime-text]', :immediately
  end
end

# Installs Package Control
remote_file node["sublime_text"]["package_control"]["path"] do
  source node["sublime_text"]["package_control"]["uri"]
  owner node["sublime_text"]["package_control"]["owner"]
  group node["sublime_text"]["package_control"]["group"]
  mode node["sublime_text"]["package_control"]["mode"]
  action node["sublime_text"]["package_control"]["action"].to_sym
  only_if { defined? node["sublime_text"]["action"] && node["sublime_text"]["action"] == "install" && ::File.directory?(node["sublime_text"]["package_control"]["directory"]) }
end

# Installs Sublime Packages
if defined? node["sublime_text"]["package"]
  node["sublime_text"]["package"]["list"].each do |name, repository|
    package_path = ::File.join(node["sublime_text"]["package"]["path"], name)
    git package_path do
      repository repository
      depth 1
      user node["sublime_text"]["package"]["user"]
      group node["sublime_text"]["package"]["group"]
      action :checkout
      only_if { defined? node["sublime_text"]["action"] && node["sublime_text"]["action"] == "install" }
    end
  end
end	
