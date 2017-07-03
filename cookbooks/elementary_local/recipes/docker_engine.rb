#
# Cookbook:: elementary_local
# Recipe:: docker_engine
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

#Includes the Docker apt repository
apt_repository 'docker' do
  uri node["docker_engine"]["apt_repository"]["uri"]
  arch node["docker_engine"]["apt_repository"]["arch"]
  distribution node["docker_engine"]["apt_repository"]["distribution"]
  components node["docker_engine"]["apt_repository"]["components"]
  key node["docker_engine"]["apt_key"]["uri"]
  if node["docker_engine"]["action"] == "install"
    action node["docker_engine"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Updates APT cache
apt_update 'update' do
  action :update
  only_if { defined? node["docker_engine"]["action"] && node["docker_engine"]["action"] == "install" }
end

# Installs Docker
package "docker-" + node["docker_engine"]["track"] do
  action node["docker_engine"]["action"].to_sym
  if node["docker_engine"]["action"] == "remove"
    notifies node["docker_engine"]["apt_repository"]["action"].to_sym, 'apt_repository[docker]', :immediately
  end 
end

# Sets the Docker service
service node["docker_engine"]["service"]["name"] do
  action node["docker_engine"]["service"]["action"]
  only_if { defined? node["docker_engine"]["action"] && node["docker_engine"]["action"] == "install" }
end

# Removes Docker containers and its related files
directory node["docker_engine"]["directory"] do
  recursive true
  ignore_failure true
  action :delete
  only_if { node["docker_engine"]["action"] == "remove" }
end