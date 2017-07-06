#
# Cookbook:: elementary_local
# Recipe:: xclip
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

# Updates the APT cache
apt_update "update" do
  action "update"
  only_if { node["xclip"]["action"] == "install" }
end

# Installs the xclip cache
package "xclip" do
  action node["xclip"]["action"].to_sym
end

# Adds the xclip to bashrc
ruby_block "insert_xclip_bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node["xclip"]["bashrc"]["path"])
    file.insert_line_if_no_match(/xclip/i, node["xclip"]["bashrc"]["content"])
    file.write_file
  end
  not_if "grep -qi xclip " + node["xclip"]["bashrc"]["path"]
  not_if { node["xclip"]["action"] == "remove" }
end

# Removes xclip from bashrc
ruby_block "removes_xclip_bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node["xclip"]["bashrc"]["path"])
    file.search_file_delete_line(/xclip/i)
    file.write_file
  end
  only_if "grep -qi xclip " + node["xclip"]["bashrc"]["path"]
  only_if { node["xclip"]["action"] == "remove" }
end