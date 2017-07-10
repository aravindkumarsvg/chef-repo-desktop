#
# Cookbook:: elementary_local
# Recipe:: virtualbox
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

#Includes the Virtualbox apt repository
apt_repository 'virtualbox' do
  uri node["virtualbox"]["apt_repository"]["uri"]
  arch node["virtualbox"]["apt_repository"]["arch"]
  distribution node["virtualbox"]["apt_repository"]["distribution"]
  components node["virtualbox"]["apt_repository"]["components"]
  key node["virtualbox"]["apt_key"]["uri"]
  if node["virtualbox"]["action"] == "install"
    action node["virtualbox"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Updates APT cache
apt_update 'update' do
  action :update
  only_if { defined? node["virtualbox"]["action"] && node["virtualbox"]["action"] == "install" }
end

# Installs Dependencies
node["virtualbox"]["dependencies"].each do |dependency|
  package "#{dependency}" do
    action :install
    only_if { defined? node["virtualbox"]["action"] && node["virtualbox"]["action"] == "install" }
  end
end

# Installs Virtualbox
package "virtualbox-" + node["virtualbox"]["version"] do
  action node["virtualbox"]["action"].to_sym
  if node["virtualbox"]["action"] == "remove"
    notifies node["virtualbox"]["apt_repository"]["action"].to_sym, 'apt_repository[virtualbox]', :immediately
  end 
end