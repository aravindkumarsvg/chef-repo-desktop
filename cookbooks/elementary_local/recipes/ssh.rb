#
# Cookbook:: elementary_local
# Recipe:: ssh
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
    ssh_action = node["ssh"]["action"] 
    if ssh_action  == "install"
        action :update
    else
        action :nothing
    end
end

# Installs openssh server
package "openssh-server" do
    ssh_action = node["ssh"]["action"] 
    if ssh_action  == "install"
        action ssh_action.to_sym
    else
        action :nothing
    end
end

service "ssh" do
    action node["ssh"]["service"]["action"]
    if node["ssh"]["action"] == "remove"
        notifies node["ssh"]["action"].to_sym, 'package[openssh-server]', :immediately 
    end
end