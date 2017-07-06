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
  user node["user"]
  group node["group"]
  action node["nvm"]["binary"]["git"]["action"].to_sym
  not_if { node["nvm"]["action"] == "remove" }
end

# Adds the nvm to bashrc
ruby_block "insert_nvm_bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node["nvm"]["binary"]["bashrc"]["path"])
    file.insert_line_if_no_match(/nvm/i, node["nvm"]["binary"]["bashrc"]["content"])
    file.write_file
  end
  not_if "grep -qi nvm " + node["nvm"]["binary"]["bashrc"]["path"]
  not_if { node["nvm"]["action"] == "remove" }
end

# Sources the bashrc file
bash "Soruces_Bashrc" do
  code <<-EOH
    source #{node["nvm"]["binary"]["bashrc"]["path"]}
  EOH
  user node["user"]
  group node["group"]
  action :run
  not_if { node["nvm"]["action"] == "remove" }
end

# Installs/Uninstalls the Node JS versions
node["nvm"]["node"]["versions"].each do |version, nvm_action|
  bash "Node JS - #{nvm_action} - #{version}" do
    code <<-EOH
      #{node['nvm']['binary']['bashrc']['content']}
      nvm ls #{version}
      case #{nvm_action} in
        install)
          if [ $? -ne 0 ]
          then
            nvm #{nvm_action} #{version}
          fi
        ;;
        uninstall)
          if [ $? -eq 0 ]
          then
            nvm #{nvm_action} #{version}
          fi
        ;;
      esac
    EOH
    user node["user"]
    group node["group"]
    ignore_failure true
    action :run
    only_if { node["nvm"]["action"] == "install" }
  end
end

# Sets the default Node JS version
bash "Node JS - Default - #{node['nvm']['node']['default']}" do
  code <<-EOH
    #{node['nvm']['binary']['bashrc']['content']}
    nvm ls #{node['nvm']['node']['default']}
    if [ $? -eq 0 ]
    then
      nvm alias default #{node['nvm']['node']['default']}
    fi
  EOH
  user node["user"]
  group node["group"]
  ignore_failure true
  action :run
  only_if { node["nvm"]["action"] == "install" }
end

# Removes the nvm directory in case of uninstallation
directory node["nvm"]["binary"]["git"]["path"] do
  recursive true
  action :delete
  only_if { node["nvm"]["action"] == "remove" }
end

# Removes nvm from bashrc
ruby_block "removes_nvm_bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node["nvm"]["binary"]["bashrc"]["path"])
    file.search_file_delete_line(/nvm/i)
    file.write_file
  end
  only_if "grep -qi nvm " + node["nvm"]["binary"]["bashrc"]["path"]
  only_if { node["nvm"]["action"] == "remove" }
end