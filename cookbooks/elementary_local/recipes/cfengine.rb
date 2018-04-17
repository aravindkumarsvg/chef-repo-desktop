#
# Cookbook:: elementary_local
# Recipe:: cfengine
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

#Includes the CFEngine apt repository
apt_repository 'cfengine' do
  uri node["cfengine"]["apt_repository"]["uri"]
  distribution node["cfengine"]["apt_repository"]["distribution"]
  components node["cfengine"]["apt_repository"]["components"]
  key node["cfengine"]["apt_key"]["uri"]
  cache_rebuild true
  if node["cfengine"]["action"] == "install"
    action node["cfengine"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Installs the CFEngine community package
package node["cfengine"]["package"]["name"] do
    action node["cfengine"]["action"].to_sym
    if node["cfengine"]["action"] == "remove"
        notifies node["cfengine"]["apt_repository"]["action"].to_sym, 'apt_repository[cfengine]', :immediately
    end
end