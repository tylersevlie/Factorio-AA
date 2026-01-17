-- Final data fixes for AA worm spawning

-- Add AA worms to autoplace controls
data.raw["autoplace-control"]["enemy-base"].control_order = "e-a"

-- Add AA worms to map generation
local function add_aa_worm_autoplace(worm_name, distance_factor, max_probability)
  data.raw["turret"][worm_name].autoplace = {
    control = "enemy-base",
    force = "enemy",
    order = "b[enemy]-c[worm]",
    probability_expression = "min(1, enemy_base_probability * " .. distance_factor .. ")",
    richness_expression = "1"
  }
end

-- Small AA worms spawn relatively close to spawn
add_aa_worm_autoplace("small-aa-worm-turret", 0.5, 0.3)

-- Medium AA worms spawn at medium distance
add_aa_worm_autoplace("medium-aa-worm-turret", 0.8, 0.25)

-- Big AA worms spawn far from spawn
add_aa_worm_autoplace("big-aa-worm-turret", 1.2, 0.2)
