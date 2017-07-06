default["xclip"]["action"] = "install"
default["xclip"]["bashrc"] = {
  "path" => ::File.join(ENV["HOME"], ".bashrc"),
  "content" => <<-EOH
    alias setclip="xclip -selection c"
  EOH
}