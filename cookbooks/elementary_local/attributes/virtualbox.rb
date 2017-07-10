default["virtualbox"]["action"] = "install"
default["virtualbox"]["version"] = "5.1"
default["virtualbox"]["apt_key"] =  {
                                        "uri" => "https://www.virtualbox.org/download/oracle_vbox_2016.asc"
                                      }
default["virtualbox"]["apt_repository"] = {
                                              "uri" => "http://download.virtualbox.org/virtualbox/debian",
                                              "distribution" => "xenial",
                                              "components" => %w(contrib),
                                              "distro" => "amd64",
                                              "action" => "add"
                                            }

default["virtualbox"]["dependencies"] = [ "dkms", "build-essential", "linux-headers-" + node["kernel"]["release"] ]