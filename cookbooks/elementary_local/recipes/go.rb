#
# Cookbook:: elementary_local
# Recipe:: go
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

# Downloads go
remote_file node["go"]["binary"]["download_path"] do
    source node["go"]["binary"]["uri"]
    owner node["user"]
    group node["group"]
    mode node["go"]["binary"]["download_mode"]
    action node["go"]["binary"]["action"].to_sym
    checksum node["go"]["binary"]["checksum"]
    only_if { node["go"]["action"] == "install" }
end

# Creates the go installation directory
directory 'go_installation_directory' do
    path node['go']['binary']['extraction_path']
    action :create
    recursive true
    only_if { node["go"]["action"] == "install" }
end

# Extracts the go
execute 'install go' do
    command "tar --strip-components 1 -xzf #{node['go']['binary']['download_path']} -C #{node['go']['binary']['extraction_path']} && chmod -R +x #{node['go']['binary']['extraction_path']}"
    only_if { node["go"]["action"] == "install" }
end

# Adds the go to profile
ruby_block "insert_go_profile" do
  block do
    file = Chef::Util::FileEdit.new(node["go"]["profile"]["path"])
    file.insert_line_if_no_match(/go/i, node["go"]["profile"]["content"])
    file.write_file
  end
  not_if "grep -qi go " + node["go"]["profile"]["path"]
  not_if { node["go"]["action"] == "remove" }
end

# Removes the go binary
directory node['go']['binary']['extraction_path'] do
    action :delete
    recursive true
    only_if { node["go"]["action"] == "remove" }
end

# Removes go from profile
ruby_block "removes_go_profile" do
  block do
    file = Chef::Util::FileEdit.new(node["go"]["profile"]["path"])
    file.search_file_delete_line(/go/i)
    file.write_file
  end
  only_if "grep -qi go " + node["go"]["profile"]["path"]
  only_if { node["go"]["action"] == "remove" }
end