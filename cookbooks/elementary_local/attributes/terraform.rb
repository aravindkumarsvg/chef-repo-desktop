default["terraform"]["action"] = "install"
default["terraform"]["binary"] = {
    "uri" => "https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip",
    "checksum" => "6b8a7b83954597d36bbed23913dd51bc253906c612a070a21db373eab71b277b",
    "download_path" => "/tmp/terraform.zip",
    "extraction_path" => "/opt/terraform/",
    "download_mode" => "0755",
    "action" => "create"
} 
default["terraform"]["bashrc"] = {
  "path" => ::File.join(ENV["HOME"], ".bashrc"),
  "content" => <<-EOH
  export PATH=$PATH:#{node['terraform']['binary']['extraction_path']}
EOH
}