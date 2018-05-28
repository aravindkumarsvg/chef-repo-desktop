resource_name :vscode_ext
default_action :install

action :install do
	extId = @new_resource.name
	execute extId do
		command "code --user-data-dir=/home/#{node['user']}/.config/Code/ --install-extension #{extId}"
		ignore_failure true
	end
end

action :remove do
	extId = @new_resource.name
	execute extId do
		command "code --user-data-dir=/home/#{node['user']}/.config/Code/ --uninstall-extension #{extId}"
		ignore_failure true
	end
end