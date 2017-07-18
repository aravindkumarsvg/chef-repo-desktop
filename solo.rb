Chef_Repo_Path  = ::File.dirname(__FILE__)

file_cache_path ::File.join(Chef_Repo_Path, ".chef")
cookbook_path ::File.join(Chef_Repo_Path, "cookbooks")
