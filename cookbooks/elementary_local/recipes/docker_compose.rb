#
# Cookbook:: elementary_local
# Recipe:: docker_compose
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

# Installs Docker Machine
remote_file node["docker_machine"]["binary"]["path"] do
  source node["docker_machine"]["binary"]["uri"]
  mode node["docker_machine"]["binary"]["mode"]
  action node["docker_machine"]["binary"]["action"].to_sym
  only_if { defined? node["docker_machine"]["action"] && node["docker_machine"]["action"] == "install" }
end

# Removes machines created by Docker Machine iff uninstalled
execute 'remove_machines' do
  command 'docker-machine rm -f $(docker-machine ls -q)'
  ignore_failure true
  only_if 'docker-machine --version'
  only_if do node["docker_machine"]["action"] == "remove" end
end

# Removes the Docker Machine binary
file node["docker_machine"]["binary"]["path"] do
  action :delete
  ignore_failure true
  only_if 'docker-machine --version'
  only_if do node["docker_machine"]["action"] == "remove" end
end