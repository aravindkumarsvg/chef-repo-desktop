default["docker_machine"]["action"] = "install"
default["docker_machine"]["binary"]["action"] = "create"
default["docker_machine"]["binary"]["name"] = "docker-machine"
default["docker_machine"]["binary"]["uri"] = "https://github.com/docker/machine/releases/download/v0.12.0/docker-machine-" + node["kernel"]["name"] + "-" + node["kernel"]["machine"]
default["docker_machine"]["binary"]["path"] = "/usr/local/bin/docker-machine"
default["docker_machine"]["binary"]["mode"] = "0755"