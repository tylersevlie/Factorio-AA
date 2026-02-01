-- Anti-Aircraft Worm prototype definition

-- AA Worm ammo category
local aa_ammo_category = {
  type = "ammo-category",
  name = "aa-rocket"
}

-- Small AA Worm projectile
local small_aa_projectile = {
  type = "projectile",
  name = "small-aa-worm-projectile",
  flags = {"not-on-map"},
  acceleration = 0.004,
  turn_speed = 0.002,
  turning_speed_increases_exponentially_with_projectile_speed = true,
  action = {
    type = "direct",
    action_delivery = {
      type = "instant",
      target_effects = {
        {
          type = "damage",
          damage = {amount = 75, type = "explosion"}
        },
        {
          type = "create-entity",
          entity_name = "explosion"
        }
      }
    }
  },
  light = {intensity = 0.5, size = 4},
  animation = {
    filename = "__base__/graphics/entity/rocket/rocket.png",
    frame_count = 8,
    line_length = 8,
    width = 9,
    height = 35,
    shift = {0, 0},
    priority = "high"
  },
  shadow = {
    filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
    frame_count = 1,
    width = 7,
    height = 24,
    priority = "high",
    shift = {0, 0}
  },
  smoke = {
    {
      name = "smoke-fast",
      deviation = {0.15, 0.15},
      frequency = 1,
      position = {0, 0},
      starting_frame = 3,
      starting_frame_deviation = 5,
      starting_frame_speed_deviation = 5
    }
  }
}

-- Medium AA Worm projectile
local medium_aa_projectile = {
  type = "projectile",
  name = "medium-aa-worm-projectile",
  flags = {"not-on-map"},
  acceleration = 0.005,
  turn_speed = 0.0025,
  turning_speed_increases_exponentially_with_projectile_speed = true,
  action = {
    type = "direct",
    action_delivery = {
      type = "instant",
      target_effects = {
        {
          type = "damage",
          damage = {amount = 125, type = "explosion"}
        },
        {
          type = "create-entity",
          entity_name = "big-explosion"
        }
      }
    }
  },
  light = {intensity = 0.6, size = 5},
  animation = {
    filename = "__base__/graphics/entity/rocket/rocket.png",
    frame_count = 8,
    line_length = 8,
    width = 9,
    height = 35,
    shift = {0, 0},
    priority = "high"
  },
  shadow = {
    filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
    frame_count = 1,
    width = 7,
    height = 24,
    priority = "high",
    shift = {0, 0}
  },
  smoke = {
    {
      name = "smoke-fast",
      deviation = {0.15, 0.15},
      frequency = 1,
      position = {0, 0},
      starting_frame = 3,
      starting_frame_deviation = 5,
      starting_frame_speed_deviation = 5
    }
  }
}

-- Big AA Worm projectile
local big_aa_projectile = {
  type = "projectile",
  name = "big-aa-worm-projectile",
  flags = {"not-on-map"},
  acceleration = 0.006,
  turn_speed = 0.003,
  turning_speed_increases_exponentially_with_projectile_speed = true,
  action = {
    type = "direct",
    action_delivery = {
      type = "instant",
      target_effects = {
        {
          type = "damage",
          damage = {amount = 175, type = "explosion"}
        },
        {
          type = "create-entity",
          entity_name = "big-explosion"
        }
      }
    }
  },
  light = {intensity = 0.5, size = 4},
  animation = {
    filename = "__base__/graphics/entity/rocket/rocket.png",
    frame_count = 8,
    line_length = 8,
    width = 9,
    height = 35,
    shift = {0, 0},
    priority = "high"
  },
  shadow = {
    filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
    frame_count = 1,
    width = 7,
    height = 24,
    priority = "high",
    shift = {0, 0}
  },
  smoke = {
    {
      name = "smoke-fast",
      deviation = {0.15, 0.15},
      frequency = 1,
      position = {0, 0},
      starting_frame = 3,
      starting_frame_deviation = 5,
      starting_frame_speed_deviation = 5
    }
  }
}

-- Small AA Worm
local small_aa_worm = {
  type = "turret",
  name = "small-aa-worm-turret",
  icon = "__factorio-aircraft-antiaircraft__/graphics/aa-worm/aa-worm-icon.png",
  icon_size = 64,
  flags = {"placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
  order = "b-b-h",
  max_health = 200,
  subgroup = "enemies",
  resistances = {
    {
      type = "physical",
      decrease = 5
    },
    {
      type = "explosion",
      decrease = 5,
      percent = 10
    },
    {
      type = "fire",
      decrease = 3,
      percent = 20
    }
  },
  healing_per_tick = 0.01,
  collision_box = {{-1.4, -1.2}, {1.4, 1.2}},
  map_generator_bounding_box = {{-2.4, -2.2}, {2.4, 2.2}},
  selection_box = {{-1.4, -1.2}, {1.4, 1.2}},
  shooting_cursor_size = 4,
  rotation_speed = 0.008,
  corpse = "small-worm-corpse",
  dying_explosion = "blood-explosion-huge",
  dying_sound = {
    {
      filename = "__base__/sound/creatures/worm-dying-1.ogg",
      volume = 0.5
    },
    {
      filename = "__base__/sound/creatures/worm-dying-2.ogg",
      volume = 0.5
    }
  },
  graphics_set = {
    base_visualisation = {
      animation = {
        layers = {
          {
            filename = "__factorio-aircraft-antiaircraft__/graphics/aa-worm/aa-worm.png",
            line_length = 1,
            width = 128,
            height = 128,
            frame_count = 1,
            direction_count = 1,
            shift = {0, 0},
            scale = 0.8
          }
        }
      }
    }
  },
  prepare_range = 38,
  shoot_in_prepare_state = false,
  attack_parameters = {
    type = "projectile",
    ammo_category = "aa-rocket",
    cooldown = 120, -- 2 seconds between shots
    damage_modifier = 1,
    projectile_center = {0, 0},
    projectile_creation_distance = 1.5,
    range = 40,
    min_range = 0,
    sound = {
      {
        filename = "__base__/sound/fight/worm-roar-1.ogg",
        volume = 0.6
      },
      {
        filename = "__base__/sound/fight/worm-roar-2.ogg",
        volume = 0.6
      }
    },
    ammo_type = {
      category = "aa-rocket",
      target_type = "entity",
      action = {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "small-aa-worm-projectile",
          starting_speed = 0.1,
          max_range = 40
        }
      }
    }
  },
  call_for_help_radius = 40
}

-- Medium AA Worm (higher damage and range)
local medium_aa_worm = table.deepcopy(small_aa_worm)
medium_aa_worm.name = "medium-aa-worm-turret"
medium_aa_worm.max_health = 400
medium_aa_worm.attack_parameters.range = 50
medium_aa_worm.prepare_range = 48
medium_aa_worm.attack_parameters.cooldown = 100
medium_aa_worm.attack_parameters.ammo_type.action.action_delivery.projectile = "medium-aa-worm-projectile"
medium_aa_worm.attack_parameters.ammo_type.action.action_delivery.max_range = 50
medium_aa_worm.resistances = {
  {
    type = "physical",
    decrease = 8
  },
  {
    type = "explosion",
    decrease = 8,
    percent = 15
  },
  {
    type = "fire",
    decrease = 5,
    percent = 25
  }
}

-- Big AA Worm (highest damage and range)
local big_aa_worm = table.deepcopy(small_aa_worm)
big_aa_worm.name = "big-aa-worm-turret"
big_aa_worm.max_health = 750
big_aa_worm.attack_parameters.range = 60
big_aa_worm.prepare_range = 58
big_aa_worm.attack_parameters.cooldown = 80
big_aa_worm.attack_parameters.ammo_type.action.action_delivery.projectile = "big-aa-worm-projectile"
big_aa_worm.attack_parameters.ammo_type.action.action_delivery.max_range = 60
big_aa_worm.collision_box = {{-1.8, -1.6}, {1.8, 1.6}}
big_aa_worm.selection_box = {{-1.8, -1.6}, {1.8, 1.6}}
big_aa_worm.resistances = {
  {
    type = "physical",
    decrease = 10
  },
  {
    type = "explosion",
    decrease = 10,
    percent = 20
  },
  {
    type = "fire",
    decrease = 8,
    percent = 30
  }
}

data:extend({
  aa_ammo_category,
  small_aa_projectile,
  medium_aa_projectile,
  big_aa_projectile,
  small_aa_worm,
  medium_aa_worm,
  big_aa_worm
})
