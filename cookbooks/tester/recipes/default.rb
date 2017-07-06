#
# Cookbook:: tester
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


bash "Sources bashrc" do
  environment ({ "USER" => "aravind", "HOME" => "/home/aravind" })
  code <<-EOH
    echo 
    source /home/aravind/workspace/shell_script/tests/test1.sh
  EOH
  action :run
end