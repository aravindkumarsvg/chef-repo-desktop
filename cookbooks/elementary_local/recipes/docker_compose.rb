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

Chef::Log.warn(node["docker_compose"]["binary"]["uri"])

# Installs Docker Compose
remote_file node["docker_compose"]["binary"]["path"] do
  source node["docker_compose"]["binary"]["uri"]
  mode node["docker_compose"]["binary"]["mode"]
  action node["docker_compose"]["binary"]["action"].to_sym
  if node["docker_compose"]["action"] == "remove"
    only_if node["docker_compose"]["binary"]["name"] + ' --version'
  end
end