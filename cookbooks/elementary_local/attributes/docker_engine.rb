default["docker_engine"]["action"] = "install"
default["docker_engine"]["track"] = "ce"
default["docker_engine"]["service"] =   {
                                          "name" => "docker",
                                          "action" => [:stop, :disable]
                                        }
default["docker_engine"]["directory"] = "/var/lib/docker"
default["docker_engine"]["apt_key"] = 	{ 
                                          "uri" => "https://download.docker.com/linux/ubuntu/gpg"
                                        }
default["docker_engine"]["apt_repository"] = {
                                                "uri" => "https://download.docker.com/linux/ubuntu",
                                                "distribution" => "xenial",
                                                "components" => %w(stable),
                                                "arch" => "amd64",
                                                "action" => "add"
                                              }
