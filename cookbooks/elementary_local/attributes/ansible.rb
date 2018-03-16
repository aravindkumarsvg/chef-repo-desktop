default["ansible"]["action"] = "install"
default["ansible"]["apt_repository"] = {
                                        "uri" => "ppa:ansible/ansible",
                                        "arch" => "amd64",
                                        "distribution" => "xenial",
                                        "action" => "add"
                                      }