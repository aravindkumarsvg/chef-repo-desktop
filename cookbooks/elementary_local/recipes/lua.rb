#
# Cookbook:: elementary_local
# Recipe:: lua
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

# Updates the apt cache
apt_update 'update' do
    if node["lua"]["action"] == "install"
        action :update
    else
        action :nothing
    end
end

# Installs the lua package
package node["lua"]["package"] do
    action node["lua"]["action"].to_sym
end

# Installs the lua package manager
package node["lua"]["package_manager"]["name"] do
    action node["lua"]["package_manager"]["action"].to_sym
end