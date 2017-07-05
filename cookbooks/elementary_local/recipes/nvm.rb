#
# Cookbook:: elementary_local
# Recipe:: nvm
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

# Checkouts NVM repo
git node["nvm"]["binary"]["git"]["path"] do
  repository node["nvm"]["binary"]["git"]["repository"]
  checkout_branch node["nvm"]["binary"]["git"]["tag"]
  action node["nvm"]["binary"]["git"]["action"].to_sym
  not_if { node["nvm"]["action"] == "remove" }
end

# Adds the nvm to bashrc
ruby_block "insert_nvm_bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node["nvm"]["binary"]["bashrc"]["path"])
    file.insert_line_if_no_match("/nvm/ig", node["nvm"]["binary"]["bashrc"]["content"])
    file.write_file
  end
  not_if "grep -qi nvm " + node["nvm"]["binary"]["bashrc"]["path"]
  not_if { node["nvm"]["action"] == "remove" }
end

# Removes the nvm directory in case of uninstallation
directory node["nvm"]["binary"]["git"]["path"] do
  recursvie true
  action :delete
  only_if { node["nvm"]["action"] == "remove" }
end

