package = "kong-plugin-batch-plugins"  -- TODO: rename, must match the info in the filename of this rockspec!
                                  -- as a convention; stick to the prefix: `kong-plugin-`
version = "0.1-0"               -- TODO: renumber, must match the info in the filename of this rockspec!
-- The version '0.1.0' is the source code version, the trailing '1' is the version of this rockspec.
-- whenever the source version changes, the rockspec should be reset to 1. The rockspec version is only
-- updated (incremented) when this file changes, but the source remains the same.

-- TODO: This is the name to set in the Kong configuration `plugins` setting.
-- Here we extract it from the package name.

supported_platforms = {"linux", "macosx"}

source = {
	url = "https://github.com/wjykl22/kong-plugins.git",
	tag = "0.1.0"
}

description = {
  summary = "支持批量插入插件",
}

dependencies = {
}

build = {
  type = "builtin",
  modules = {
    -- TODO: add any additional files that the plugin consists of
    ["kong.plugins.batch-plugins.handler"] = "handler.lua",
    ["kong.plugins.batch-plugins.schema"] = "schema.lua",
    ["kong.plugins.batch-plugins.api"] = "api.lua",
  }
}
