#
# Cookbook:: elementary_local
# Recipe:: ansible
#
# Copyright:: 2018, Aravind Kumar.S
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

# Adds the ansible repository
apt_repository "ansible" do
  uri node["ansible"]["apt_repository"]["uri"]
  arch node["ansible"]["apt_repository"]["arch"]
  distribution node["ansible"]["apt_repository"]["distribution"]
  cache_rebuild true
  if node["ansible"]["action"] == "install"
    action node["ansible"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Installs ansible package
package "ansible" do
  action node["ansible"]["action"].to_sym
  if node["ansible"]["action"] == "remove"
    notifies node["ansible"]["apt_repository"]["action"].to_sym, 'apt_repository[ansible]', :immediately 
  end
end