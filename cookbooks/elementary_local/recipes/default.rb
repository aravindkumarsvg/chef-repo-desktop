#
# Cookbook:: elementary_local
# Recipe:: default
#
# Copyright:: 2017, Aravind Kumar, All Rights Reserved.


# Includes Git recipe
include_recipe "elementary_local::git"
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
# Includes Terminator recipe
include_recipe "elementary_local::terminator"
# Includes VLC recipe
include_recipe "elementary_local::vlc"
# Includes Xclip recipe
include_recipe "elementary_local::xclip"
# Includes Deluge torrent recipe
include_recipe "elementary_local::deluge_torrent"
# Inlcudes Permission Setter recipe
include_recipe "elementary_local::permission_setter"
# Inlcudes Utilities recipe
include_recipe "elementary_local::utilities"