#
# Cookbook:: elementary_local
# Recipe:: vs_code
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

# Adds the vs_code repository
apt_repository "vscode" do
  uri node["vs_code"]["apt_repository"]["uri"]
  arch node["vs_code"]["apt_repository"]["arch"]
  distribution ""
  components node["vs_code"]["apt_repository"]["components"]
  key node["vs_code"]["apt_key"]["uri"]
  cache_rebuild true
  if node["vs_code"]["action"] == "install"
    action node["vs_code"]["apt_repository"]["action"].to_sym
  else
    action :nothing
  end
end

# Installs VS code
package "code" do
	action node["vs_code"]["action"].to_sym
	if node["vs_code"]["action"] == "remove"
		action :nothing
    	notifies node["vs_code"]["apt_repository"]["action"].to_sym, 'apt_repository[vscode]', :immediately if `code --help >/dev/null 2>&1`
  	end
end

vscode_extensions_length = node["vs_code"]["extensions"].length

# Installs the VS code extensions
node["vs_code"]["extensions"].each_with_index do |extension, index|
	vscode_ext extension do
		action node["vs_code"]["action"].to_sym
		if node["vs_code"]["action"] == "remove" && index == vscode_extensions_length -1
			notifies node["vs_code"]["action"].to_sym, 'package[code]', :immediately if `code --help >/dev/null 2>&1`
		end
	end
end