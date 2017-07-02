#
# Cookbook:: elementary_local
# Recipe:: vim
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

# Adds the Vim repository
apt_repository "vim" do
  uri node["vim"]["apt_repository"]["uri"]
  arch node["vim"]["apt_repository"]["arch"]
  distribution node["vim"]["apt_repository"]["distribution"]
  components node["vim"]["apt_repository"]["components"]
  if node["vim"]["action"] == "install"
    action node["vim"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Updates APT cache
apt_update 'update' do
  action :update
  only_if { defined? node["vim"]["action"] && node["vim"]["action"] == "install" }
end

# Installs Vim package
package "vim" do
  action node["vim"]["action"].to_sym
  if node["vim"]["action"] == "remove"
    notifies node["vim"]["apt_repository"]["action"].to_sym, 'apt_repository[vim]', :immediately 
  end
end
