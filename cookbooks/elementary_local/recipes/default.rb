#
# Cookbook:: elementary_local
# Recipe:: default
#
# Copyright:: 2017, Aravind Kumar, All Rights Reserved.

# Inculdes Google Chrome recipe
include_recipe "elementary_local::google_chrome"
# Includes Vim recipe
include_recipe "elementary_local::vim"
# Includes Git recipe
include_recipe "elementary_local::git"
# Includes Sublime Text recipe
include_recipe "elementary_local::sublime_text"
# Includes Virtualbox recipe
include_recipe "elementary_local::virtualbox"