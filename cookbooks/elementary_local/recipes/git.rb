#
# Cookbook:: elementary_local
# Recipe:: git
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

# Updates APT cache
apt_update 'update' do
  action :update
  only_if { defined? node["git"]["action"] && node["git"]["action"] == "install" }
end

# Installs git
package 'git' do
  action node["git"]["action"].to_sym
end

# Configures Email
execute 'git_email' do
  command 'git config --global user.email "' + node["git"]["email"] + '"'
  not_if 'git config --global --get user.email'
  only_if do defined? node["git"]["action"] && node["git"]["action"] == "install" end
end

# Configures Username
execute 'git_username' do
  command 'git config --global user.name "' + node["git"]["username"] + '"'
  not_if 'git config --global --get user.name'
  only_if do defined? node["git"]["action"] && node["git"]["action"] == "install" end
end
