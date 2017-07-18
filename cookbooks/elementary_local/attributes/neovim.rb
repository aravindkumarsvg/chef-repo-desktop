default["neovim"]["action"] = "install"
default["neovim"]["apt_repository"] = {
                                        "uri" => "ppa:neovim-ppa/stable",
                                        "arch" => "amd64",
                                        "distribution" => "xenial",
                                        "action" => "add"
                                      }
default["neovim"]["vim_plug"] = {
  "path" => ::File.join(ENV["HOME"], ".local/share/nvim/site/autoload"),
  "mode" => "0755",
  "action" => "create",
  "uri" => "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
  "file_path" => ::File.join(ENV["HOME"], ".local/share/nvim/site/autoload/plug.vim"),
  "plugin_path" => ::File.join(ENV["HOME"], ".config/nvim"),
  "plugin_file_path" => ::File.join(ENV["HOME"], ".config/nvim/init.vim"),
  "plugin_file" => "init.vim"
}