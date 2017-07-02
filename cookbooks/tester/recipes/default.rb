#
# Cookbook:: tester
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#Chef::Log.warn(File.join(ENV['HOME'], '.config/sublime-text-3/Installed Packages', 'Package Control.sublime-package.zip'))
#Chef::Log.warn(File.exists?(File.join(ENV['HOME'], '.config/sublime-text-3/Installed Packages', 'Package Control.sublime-package.zip')))
#
remote_file '/home/aravind/Documents/index.htm' do
  source 'https://www.tutorialspoint.com/ruby/ruby_environment.htm'
  only_if { 1 == 1 }
  only_if { 1 != 1 }
end
=begin
remote_file '/home/aravind/Documents/index.htm' do
  source 'https://www.tutorialspoint.com/ruby/ruby_environment.htm'
  verify { 1 == 1}
end
=end
