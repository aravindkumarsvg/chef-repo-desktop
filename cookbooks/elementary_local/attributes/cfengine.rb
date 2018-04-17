default["cfengine"] = {
    "action" => "install",
    "package" => {
        "name" => "cfengine-community"
    },
    "apt_key" => {
        "uri" => "https://cfengine-package-repos.s3.amazonaws.com/pub/gpg.key"
    },
    "apt_repository" => {
        "uri" => "https://cfengine-package-repos.s3.amazonaws.com/pub/apt/packages",
        "distribution" => "stable",
        "components" => %w(main),
        "action" => "add"
    }
}