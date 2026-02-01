-- Technology definitions

local aircraft_tech = {
  type = "technology",
  name = "aircraft",
  icon = "__factorio-aircraft-antiaircraft__/graphics/aircraft/aircraft-icon.png",
  icon_size = 64,
  effects = {
    {
      type = "unlock-recipe",
      recipe = "aircraft"
    }
  },
  prerequisites = {"automobilism", "electronics"},
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1}
    },
    time = 30
  },
  order = "e-c-d"
}

data:extend({aircraft_tech})
