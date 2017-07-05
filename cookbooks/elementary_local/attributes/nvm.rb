default["nvm"]["action"] = "install"
default["nvm"]["name"] = "nvm"
default["nvm"]["binary"]["git"] =   {
                                      "repository" => "https://github.com/creationix/nvm.git",
                                      "tag" => "v0.33.2",
                                      "path" => ::File.join(ENV["HOME"], ".nvm"),
                                      "action" => "checkout"
                                    }