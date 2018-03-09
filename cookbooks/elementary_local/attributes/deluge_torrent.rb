default["deluge"]["action"] = "install"
default["deluge"]["apt_repository"] = {
                                        "uri" => "ppa:deluge-team/ppa",
                                        "arch" => "amd64",
                                        "distribution" => "xenial",
                                        "action" => "add"
                                      }
default["deluge"]["packages"] = ["deluge", "deluged", "deluge-web", "deluge-console"]