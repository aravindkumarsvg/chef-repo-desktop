default["go"]["action"] = "install"
default["go"]["binary"] = {
    "uri" => "https://dl.google.com/go/go1.10.linux-amd64.tar.gz",
    "checksum" => "b5a64335f1490277b585832d1f6c7f8c6c11206cba5cd3f771dcb87b98ad1a33",
    "download_path" => "/tmp/go.tar.gz",
    "extraction_path" => "/opt/go/",
    "download_mode" => "0755",
    "action" => "create"
} 
default["go"]["profile"] = {
  "path" => ::File.join(ENV["HOME"], ".profile"),
  "content" => <<-EOH
  export GOROOT=#{node['go']['binary']['extraction_path']}
export GOPATH=$HOME/Workspace/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
EOH
}