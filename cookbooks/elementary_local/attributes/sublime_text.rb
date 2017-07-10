default["sublime_text"]["action"] = "install"
default["sublime_text"]["apt_key"] =  {
                                        "uri" => "https://download.sublimetext.com/sublimehq-pub.gpg"
                                      }
default["sublime_text"]["apt_repository"] = {
                                              "uri" => "https://download.sublimetext.com/",
                                              "distribution" => "apt/stable/",
                                              "action" => "add"
                                            }
default["sublime_text"]["package_control"] = {
                                                "uri" => "http://sublime.wbond.net/Package%20Control.sublime-package",
                                                "directory" => ::File.join(ENV['HOME'], '.config/sublime-text-3/Installed Packages'),
                                                "path" => ::File.join(ENV['HOME'], '.config/sublime-text-3/Installed Packages', 'Package Control.sublime-package'),
                                                "mode" => "0755",
                                                "action" => "create"
                                              }
default["sublime_text"]["package"]["path"] = ::File.join(ENV['HOME'], '.config/sublime-text-3/Packages/')
default["sublime_text"]["package"]["mode"] = "0755"
default["sublime_text"]["package"]["list"] = {
                                              "DocBlockr" => "https://github.com/spadgos/sublime-jsdocs.git",
                                              "Typescript" => "https://github.com/Microsoft/TypeScript-Sublime-Plugin.git",
                                              "JsFormat" => "https://github.com/jdc0589/JsFormat.git"
                                            }
