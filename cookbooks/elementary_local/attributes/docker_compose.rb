Docker_Compose_Version = "1.14.0"

default["docker_compose"]["action"] = "install"
default["docker_compose"]["binary"] = {
                                        "uri" => "https://github.com/docker/compose/releases/download/" + Docker_Compose_Version + "/docker-compose-" + node["kernel"]["name"] + "-" + node["kernel"]["machine"],
                                        "path" => "/usr/local/bin/docker-compose",
                                        "name" => "docker-compose",
                                        "mode" => "0755",
                                        "action" => "create"
                                      }