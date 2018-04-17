#
# Cookbook:: elementary_local
# Recipe:: default
#
# Copyright:: 2017, Aravind Kumar, All Rights Reserved.


# Includes Git recipe
include_recipe "elementary_local::git"
# Inculdes Ansible recipe
include_recipe "elementary_local::ansible"
# Inculdes CFEngine recipe
include_recipe "elementary_local::cfengine"
# Inculdes Google Chrome recipe
include_recipe "elementary_local::google_chrome"
# Includes Neovim recipe
include_recipe "elementary_local::neovim"
# Includes Sublime Text recipe
include_recipe "elementary_local::sublime_text"
# Includes VS Code recipe
include_recipe "elementary_local::vs_code"
# Includes Virtualbox recipe
include_recipe "elementary_local::virtualbox"
# Includes Vagrant recipe
include_recipe "elementary_local::vagrant"
# Includes Docker recipe
include_recipe "elementary_local::docker"
# Includes NVM recipe
include_recipe "elementary_local::nvm"
# Includes Go recipe
include_recipe "elementary_local::go"
# Includes Lua recipe
include_recipe "elementary_local::lua"
# Includes Terminator recipe
include_recipe "elementary_local::terminator"
# Includes VLC recipe
include_recipe "elementary_local::vlc"
# Includes Xclip recipe
include_recipe "elementary_local::xclip"
# Includes Deluge torrent recipe
include_recipe "elementary_local::deluge_torrent"
# Includes Terraform recipe
include_recipe "elementary_local::terraform"
# Includes Packer recipe
include_recipe "elementary_local::packer"
# Includes Utilities recipe
include_recipe "elementary_local::utilities"
# Includes Permission Setter recipe
include_recipe "elementary_local::permission_setter"