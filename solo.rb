Chef_Repo_Path = "/home/aravind/workspace/chef/chef-repo-elementary-local"

file_cache_path ::File.join(Chef_Repo_Path, ".chef")
cookbook_path ::File.join(Chef_Repo_Path, "cookbooks")
