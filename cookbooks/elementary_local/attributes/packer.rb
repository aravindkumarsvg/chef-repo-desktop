default["packer"]["action"] = "install"
default["packer"]["binary"] = {
    "uri" => "https://releases.hashicorp.com/packer/1.2.2/packer_1.2.2_linux_amd64.zip",
    "checksum" => "6575f8357a03ecad7997151234b1b9f09c7a5cf91c194b23a461ee279d68c6a8",
    "download_path" => "/tmp/packer.zip",
    "extraction_path" => "/opt/packer/",
    "download_mode" => "0755",
    "action" => "create"
} 
default["packer"]["bashrc"] = {
  "path" => ::File.join(ENV["HOME"], ".bashrc"),
  "content" => <<-EOH
  export PATH=$PATH:#{node['packer']['binary']['extraction_path']}
EOH
}