local parser = clink.arg.new_parser

local gitflow_parser = parser({
    "init",
    "feature" .. parser({
        "list",
        "start",
        "finish",
        "publish",
        "track",
        "diff",
        "rebase",
        "checkout",
        "pull",
        "delete",
        "help"
    }),
    "bugfix",
    "release",
    "hotfix",
    "support",
    "version",
    "config",
    "log"
})

return gitflow_parser
