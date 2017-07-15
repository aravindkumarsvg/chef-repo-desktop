#
# Cookbook:: elementary_local
# Recipe:: vlc
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

# Adds the VLC repository
apt_repository "vlc" do
  uri node["vlc"]["apt_repository"]["uri"]
  arch node["vlc"]["apt_repository"]["arch"]
  distribution node["vlc"]["apt_repository"]["distribution"]
  if node["vlc"]["action"] == "install"
    action node["vlc"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Updates APT cache
apt_update 'update' do
  action :update
  only_if { defined? node["vlc"]["action"] && node["vlc"]["action"] == "install" }
end

# Installs VLC package
package "vlc" do
  action node["vlc"]["action"].to_sym
  if node["vlc"]["action"] == "remove"
    notifies node["vlc"]["apt_repository"]["action"].to_sym, 'apt_repository[vlc]', :immediately 
  end
end