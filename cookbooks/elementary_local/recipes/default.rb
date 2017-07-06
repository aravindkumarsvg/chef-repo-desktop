#
# Cookbook:: elementary_local
# Recipe:: default
#
# Copyright:: 2017, Aravind Kumar, All Rights Reserved.

#Inculdes Google Chrome recipe
include_recipe "elementary_local::google_chrome"
# Includes Neovim recipe
include_recipe "elementary_local::neovim"
# Includes Git recipe
include_recipe "elementary_local::git"
# Includes Sublime Text recipe
include_recipe "elementary_local::sublime_text"
# Includes Virtualbox recipe
include_recipe "elementary_local::virtualbox"
# Includes Vagrant recipe
include_recipe "elementary_local::vagrant"
# Includes Docker recipe
include_recipe "elementary_local::docker"
# Includes NVM recipe
include_recipe "elementary_local::nvm"
# Includes Terminator recipe
include_recipe "elementary_local::terminator"