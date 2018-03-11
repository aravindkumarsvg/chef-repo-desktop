#
# Cookbook:: elementary_local
# Recipe:: terraform
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

# Downloads terraform
remote_file node["terraform"]["binary"]["download_path"] do
    source node["terraform"]["binary"]["uri"]
    owner node["user"]
    group node["group"]
    mode node["terraform"]["binary"]["download_mode"]
    action node["terraform"]["binary"]["action"].to_sym
    checksum node["terraform"]["binary"]["checksum"]
    only_if { node["terraform"]["action"] == "install" }
end

# Extracts the terraform
execute 'install terraform' do
    command "unzip #{node['terraform']['binary']['download_path']} -d #{node['terraform']['binary']['extraction_path']} && chmod -R +x #{node['terraform']['binary']['extraction_path']}"
    only_if { node["terraform"]["action"] == "install" }
end

# Adds the terraform to bashrc
ruby_block "insert_terraform_bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node["terraform"]["bashrc"]["path"])
    file.insert_line_if_no_match(/terraform/i, node["terraform"]["bashrc"]["content"])
    file.write_file
  end
  not_if "grep -qi terraform " + node["terraform"]["bashrc"]["path"]
  not_if { node["terraform"]["action"] == "remove" }
end

# Removes the terraform binary
directory node['terraform']['binary']['extraction_path'] do
    action :delete
    recursive true
    only_if { node["terraform"]["action"] == "remove" }
end

# Removes terraform from bashrc
ruby_block "removes_terraform_bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node["terraform"]["bashrc"]["path"])
    file.search_file_delete_line(/terraform/i)
    file.write_file
  end
  only_if "grep -qi terraform " + node["terraform"]["bashrc"]["path"]
  only_if { node["terraform"]["action"] == "remove" }
end