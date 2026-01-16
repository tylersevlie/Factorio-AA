-- Settings for Aircraft & Anti-Aircraft mod

data:extend({
  {
    type = "double-setting",
    name = "aircraft-aa-takeoff-time",
    setting_type = "runtime-global",
    default_value = 3.0,
    minimum_value = 1.0,
    maximum_value = 10.0,
    order = "a"
  },
  {
    type = "double-setting",
    name = "aircraft-aa-worm-spawn-multiplier",
    setting_type = "startup",
    default_value = 1.0,
    minimum_value = 0.0,
    maximum_value = 5.0,
    order = "b"
  },
  {
    type = "bool-setting",
    name = "aircraft-aa-enable-flight-messages",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "c"
  }
})
