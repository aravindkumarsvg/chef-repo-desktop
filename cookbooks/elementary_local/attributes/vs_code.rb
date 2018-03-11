default["vs_code"]["action"] = "install"
default["vs_code"]["apt_key"] =  {
                                        "uri" => "https://packages.microsoft.com/keys/microsoft.asc"
                                      }
default["vs_code"]["apt_repository"] = {
                                                "uri" => "https://packages.microsoft.com/repos/vscode",
                                                "distribution" => "xenial",
                                                "components" => %w(stable main),
                                                "arch" => "amd64",
                                                "action" => "add"
                                              }
default["vs_code"]["extensions"] = [
	"vscodevim.vim",
	"HookyQR.beautify",
	"ms-vscode.cpptools",
	"lukehoban.Go",
	"PeterJausovec.vscode-docker",
	"ms-vscode.PowerShell",
	"PKief.material-icon-theme",
	"humao.rest-client",
	"marcostazi.VS-code-vagrantfile"
]