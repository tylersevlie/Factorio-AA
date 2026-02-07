-- Control script for Aircraft & Anti-Aircraft mod

-- Initialize mod data
script.on_init(function()
  storage = storage or {}
  storage.aircraft_data = {}
  storage.aa_worms = {}
end)

script.on_configuration_changed(function()
  storage = storage or {}
  storage.aircraft_data = storage.aircraft_data or {}
  storage.aa_worms = storage.aa_worms or {}
end)

-- Handle aircraft creation
script.on_event(defines.events.on_built_entity, function(event)
  local entity = event.created_entity or event.entity
  if not entity or not entity.valid then return end

  if entity.name == "aircraft" then
    -- Initialize aircraft data
    storage.aircraft_data[entity.unit_number] = {
      entity = entity,
      altitude = 0,
      is_flying = false,
      takeoff_time = 0
    }
  end
end, {{filter = "name", name = "aircraft"}})

-- Handle aircraft placement by robots
script.on_event(defines.events.on_robot_built_entity, function(event)
  local entity = event.created_entity or event.entity
  if not entity or not entity.valid then return end

  if entity.name == "aircraft" then
    storage.aircraft_data[entity.unit_number] = {
      entity = entity,
      altitude = 0,
      is_flying = false,
      takeoff_time = 0
    }
  end
end, {{filter = "name", name = "aircraft"}})

-- Clean up aircraft data when removed
local function on_entity_removed(event)
  local entity = event.entity
  if not entity or not entity.valid then return end

  if entity.name == "aircraft" then
    storage.aircraft_data[entity.unit_number] = nil
  end
end

script.on_event(defines.events.on_player_mined_entity, on_entity_removed, {{filter = "name", name = "aircraft"}})
script.on_event(defines.events.on_robot_mined_entity, on_entity_removed, {{filter = "name", name = "aircraft"}})
script.on_event(defines.events.on_entity_died, on_entity_removed, {{filter = "name", name = "aircraft"}})

-- Combined tick handler for aircraft flight mechanics and AA worm targeting
script.on_event(defines.events.on_tick, function(event)
  -- Process aircraft every 10 ticks for performance
  if event.tick % 10 == 0 then
    for unit_number, data in pairs(storage.aircraft_data) do
      local aircraft = data.entity

      -- Validate aircraft still exists
      if not aircraft or not aircraft.valid then
        storage.aircraft_data[unit_number] = nil
        goto continue
      end

      -- Check if aircraft has a driver
      local driver = aircraft.get_driver()
      local player = driver and driver.player

      if driver then
        -- Aircraft is being driven - simulate flight
        local speed = aircraft.speed

        -- Take-off mechanics
        if speed > 0.1 and not data.is_flying then
          data.takeoff_time = data.takeoff_time + 1

          -- Check takeoff time from settings
          local takeoff_seconds = settings.global["aircraft-aa-takeoff-time"].value or 3.0
          local takeoff_ticks = (takeoff_seconds * 60) / 10 -- Convert to tick intervals (checked every 10 ticks)

          if data.takeoff_time > takeoff_ticks then
            data.is_flying = true
            data.altitude = 10

            -- Make aircraft immune to ground obstacles
            aircraft.destructible = false

            -- Notify player
            if player and player.valid and settings.get_player_settings(player)["aircraft-aa-enable-flight-messages"].value then
              player.print("[Aircraft] Airborne!")
            end
          end
        elseif speed < 0.05 and data.is_flying then
          -- Landing mechanics
          data.is_flying = false
          data.altitude = 0
          data.takeoff_time = 0
          aircraft.destructible = true

          -- Notify player
          if player and player.valid and settings.get_player_settings(player)["aircraft-aa-enable-flight-messages"].value then
            player.print("[Aircraft] Landed!")
          end
        end

        -- Maintain flying state
        if data.is_flying then
          -- Aircraft can move over water and obstacles
          aircraft.destructible = false
        end
      else
        -- No driver - aircraft should land if flying
        if data.is_flying then
          data.is_flying = false
          data.altitude = 0
          data.takeoff_time = 0
          aircraft.destructible = true
        end
      end

      ::continue::
    end
  end

  -- AA Worm targeting enhancement for aircraft (every 60 ticks)
  if event.tick % 60 == 0 then
    -- Find all AA worms
    for _, surface in pairs(game.surfaces) do
      local aa_worms = surface.find_entities_filtered{
        name = {"small-aa-worm-turret", "medium-aa-worm-turret", "big-aa-worm-turret"}
      }

      for _, worm in pairs(aa_worms) do
        if worm.valid then
          -- Find nearby aircraft
          local aircraft_nearby = surface.find_entities_filtered{
            name = "aircraft",
            position = worm.position,
            radius = 50
          }

          -- Prioritize aircraft targets
          for _, aircraft in pairs(aircraft_nearby) do
            if aircraft.valid and aircraft.get_driver() then
              -- Check if aircraft is flying
              local aircraft_info = storage.aircraft_data[aircraft.unit_number]
              if aircraft_info and aircraft_info.is_flying then
                -- Set aircraft as target if worm can attack
                if worm.shooting_target == nil or worm.shooting_target.name ~= "aircraft" then
                  worm.shooting_target = aircraft
                end
              end
            end
          end
        end
      end
    end
  end
end)

-- Handle aircraft damage from AA worms
script.on_event(defines.events.on_entity_damaged, function(event)
  local entity = event.entity
  if not entity or not entity.valid then return end

  if entity.name == "aircraft" then
    local cause = event.cause
    if cause and cause.valid then
      -- Check if damage is from AA worm
      if cause.name == "small-aa-worm-turret" or
         cause.name == "medium-aa-worm-turret" or
         cause.name == "big-aa-worm-turret" then

        local driver = entity.get_driver()
        if driver and driver.valid and settings.get_player_settings(driver)["aircraft-aa-enable-flight-messages"].value then
          driver.print("[Warning] Aircraft taking AA fire!")
        end

        -- Check if aircraft is destroyed
        if entity.health <= event.final_damage_amount then
          -- Create explosion effect
          entity.surface.create_entity{
            name = "big-explosion",
            position = entity.position
          }

          if driver and driver.valid then
            driver.print("[Aircraft] Aircraft destroyed!")
          end
        end
      end
    end
  end
end, {{filter = "name", name = "aircraft"}})

-- Remote interface for other mods to interact
remote.add_interface("aircraft_aa", {
  get_aircraft_altitude = function(unit_number)
    if storage.aircraft_data[unit_number] then
      return storage.aircraft_data[unit_number].altitude
    end
    return 0
  end,

  is_aircraft_flying = function(unit_number)
    if storage.aircraft_data[unit_number] then
      return storage.aircraft_data[unit_number].is_flying
    end
    return false
  end
})
