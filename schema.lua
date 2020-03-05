local typedefs = require "kong.db.schema.typedefs"



return {
  name = "batch-plugins",
  fields = {
    { consumer = typedefs.no_consumer },
    { service = typedefs.no_service },
    { route = typedefs.no_route },
    -- Describe your plugin's configuration's schema here.
    { config = {
      type = "record",
      fields = {
        { name = { type = "string", default = "batch-plugins" }, },
      }
    }
    }
  }
}
