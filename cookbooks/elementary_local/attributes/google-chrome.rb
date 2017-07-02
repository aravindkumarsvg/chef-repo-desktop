default["chrome"]["action"] = "install"
default["chrome"]["release"] = "stable"
default["chrome"]["apt_key"] = 	{ 
				  "uri" => "https://dl-ssl.google.com/linux/linux_signing_key.pub"
				}
default["chrome"]["apt_repository"] = {
					"uri" => "http://dl.google.com/linux/chrome/deb/",
					"distribution" => "stable",
					"components" => %w(main),
					"arch" => "amd64",
					"action" => "add"
				      }
