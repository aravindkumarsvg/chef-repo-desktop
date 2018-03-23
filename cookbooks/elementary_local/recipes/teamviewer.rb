#
# Cookbook:: elementary_local
# Recipe:: teamviewer
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

# Downloads the teamviewer package
remote_file node["teamviewer"]["download_path"] do
    source node["teamviewer"]["pkg_uri"]
    mode "0755"
    only_if { node["teamviewer"]["action"] == "install" }
end

# Updates the APT cache
apt_update "update" do
    action :update
    only_if { node["teamviewer"]["action"] == "install" }
end

# Installs the teamviewer package
dpkg_package "teamviewer" do
    source node["teamviewer"]["download_path"]
    action node["teamviewer"]["action"].to_sym
    ignore_failure true
end

# Installs Dependencies
execute "Installs teamviewer dependencies" do
    command "apt-get install -f"
    only_if { node["teamviewer"]["action"] == "install" }
end