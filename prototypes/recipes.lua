-- Recipe definitions for aircraft

local aircraft_recipe = {
  type = "recipe",
  name = "aircraft",
  enabled = false,
  energy_required = 8,
  ingredients = {
    {type = "item", name = "engine-unit", amount = 12},
    {type = "item", name = "steel-plate", amount = 40},
    {type = "item", name = "electronic-circuit", amount = 20},
    {type = "item", name = "iron-gear-wheel", amount = 15}
  },
  results = {{type = "item", name = "aircraft", amount = 1}}
}

data:extend({aircraft_recipe})
