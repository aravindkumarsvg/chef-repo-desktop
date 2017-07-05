Docker_Machine_Version = "0.12.0"

default["docker_machine"]["action"] = "install"
default["docker_machine"]["binary"]["action"] = "create"
default["docker_machine"]["binary"]["name"] = "docker-machine"
default["docker_machine"]["binary"]["uri"] = "https://github.com/docker/machine/releases/download/v" + Docker_Machine_Version.to_s + "/docker-machine-" + node["kernel"]["name"] + "-" + node["kernel"]["machine"]
default["docker_machine"]["binary"]["path"] = "/usr/local/bin/docker-machine"
default["docker_machine"]["binary"]["mode"] = "0755"