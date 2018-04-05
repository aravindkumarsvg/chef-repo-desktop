#
# Cookbook:: elementary_local
# Recipe:: packer
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

# Downloads packer
remote_file node["packer"]["binary"]["download_path"] do
    source node["packer"]["binary"]["uri"]
    owner node["user"]
    group node["group"]
    mode node["packer"]["binary"]["download_mode"]
    action node["packer"]["binary"]["action"].to_sym
    checksum node["packer"]["binary"]["checksum"]
    only_if { node["packer"]["action"] == "install" }
end

# Extracts the packer
execute 'install packer' do
    command "unzip #{node['packer']['binary']['download_path']} -d #{node['packer']['binary']['extraction_path']} && chmod -R +x #{node['packer']['binary']['extraction_path']}"
    only_if { node["packer"]["action"] == "install" }
end

# Adds the packer to bashrc
ruby_block "insert_packer_bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node["packer"]["bashrc"]["path"])
    file.insert_line_if_no_match(/packer/i, node["packer"]["bashrc"]["content"])
    file.write_file
  end
  not_if "grep -qi packer " + node["packer"]["bashrc"]["path"]
  not_if { node["packer"]["action"] == "remove" }
end

# Removes the packer binary
directory node['packer']['binary']['extraction_path'] do
    action :delete
    recursive true
    only_if { node["packer"]["action"] == "remove" }
end

# Removes packer from bashrc
ruby_block "removes_packer_bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node["packer"]["bashrc"]["path"])
    file.search_file_delete_line(/packer/i)
    file.write_file
  end
  only_if "grep -qi packer " + node["packer"]["bashrc"]["path"]
  only_if { node["packer"]["action"] == "remove" }
end