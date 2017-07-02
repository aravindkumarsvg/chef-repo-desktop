default["vim"]["action"] = "install"
default["vim"]["apt_repository"] = {
					"uri" => "ppa:jonathonf/vim",
					"distribution" => "xenial",
					"components" => %w(main),
					"arch" => "amd64",
					"action" => "add"
				   }
