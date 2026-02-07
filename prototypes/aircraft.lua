-- Aircraft prototype definition

local aircraft_item = {
  type = "item-with-entity-data",
  name = "aircraft",
  icon = "__factorio-aircraft-antiaircraft__/graphics/aircraft/aircraft-icon.png",
  icon_size = 64,
  subgroup = "transport",
  order = "b[personal-transport]-c[aircraft]",
  place_result = "aircraft",
  stack_size = 1
}

local aircraft_entity = {
  type = "car",
  name = "aircraft",
  icon = "__factorio-aircraft-antiaircraft__/graphics/aircraft/aircraft-icon.png",
  icon_size = 64,
  flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
  minable = {mining_time = 1, result = "aircraft"},
  max_health = 800,
  corpse = "medium-remnants",
  dying_explosion = "medium-explosion",
  energy_per_hit_point = 0.8,
  resistances = {
    {
      type = "fire",
      decrease = 15,
      percent = 50
    },
    {
      type = "physical",
      decrease = 15,
      percent = 30
    },
    {
      type = "impact",
      decrease = 50,
      percent = 60
    },
    {
      type = "explosion",
      decrease = 20,
      percent = 40
    }
  },
  collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
  selection_box = {{-0.9, -0.9}, {0.9, 0.9}},
  drawing_box = {{-1.5, -2}, {1.5, 1.5}},
  effectivity = 0.6,
  braking_power = "400kW",
  energy_source = {
    type = "burner",
    fuel_categories = {"chemical"},
    effectivity = 0.8,
    fuel_inventory_size = 2,
    burnt_inventory_size = 1
  },
  consumption = "300kW",
  terrain_friction_modifier = 0.01, -- Very low friction for smooth flying
  friction = 0.001, -- Low friction for gliding effect
  light = {
    {
      type = "oriented",
      minimum_darkness = 0.3,
      picture = {
        filename = "__core__/graphics/light-cone.png",
        priority = "extra-high",
        flags = {"light"},
        scale = 2,
        width = 200,
        height = 200
      },
      shift = {-0.6, -14},
      size = 2,
      intensity = 0.6,
      color = {r = 0.92, g = 0.77, b = 0.3}
    },
    {
      type = "oriented",
      minimum_darkness = 0.3,
      picture = {
        filename = "__core__/graphics/light-cone.png",
        priority = "extra-high",
        flags = {"light"},
        scale = 2,
        width = 200,
        height = 200
      },
      shift = {0.6, -14},
      size = 2,
      intensity = 0.6,
      color = {r = 0.92, g = 0.77, b = 0.3}
    }
  },
  animation = {
    layers = {
      {
        width = 128,
        height = 128,
        frame_count = 1,
        direction_count = 64,
        shift = {0, 0},
        animation_speed = 8,
        max_advance = 0.2,
        stripes = {
          {
            filename = "__factorio-aircraft-antiaircraft__/graphics/aircraft/aircraft.png",
            width_in_frames = 8,
            height_in_frames = 8
          }
        }
      }
    }
  },
  rotation_speed = 0.015,
  weight = 700,
  inventory_size = 60,
  guns = {"aircraft-gun"},
  turret_rotation_speed = 0.35 / 60,
  turret_return_timeout = 60,
  has_belt_immunity = true,
  allow_passengers = true
}

local aircraft_gun = {
  type = "gun",
  name = "aircraft-gun",
  icon = "__base__/graphics/icons/submachine-gun.png",
  icon_size = 64,
  subgroup = "gun",
  order = "a[basic-clips]-b[aircraft-gun]",
  attack_parameters = {
    type = "projectile",
    ammo_category = "bullet",
    cooldown = 6,
    movement_slow_down_factor = 0.5,
    projectile_creation_distance = 0.6,
    range = 25
  },
  stack_size = 1
}

data:extend({aircraft_item, aircraft_entity, aircraft_gun})
