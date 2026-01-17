# Aircraft & Anti-Aircraft

A Factorio 2.0 mod that adds flyable aircraft and anti-aircraft defense systems.

## Features

### Aircraft
- Flyable aircraft that can take off, fly, and land
- Flies over water and obstacles when airborne
- Built-in weapon system for defense
- Configurable inventory space (60 slots default)
- Requires fuel to operate (uses chemical fuel)
- Smooth flight mechanics with realistic take-off and landing

### Anti-Aircraft Worms
- Three tiers of AA worms: Small, Medium, and Big
- Launch homing rockets at aircraft
- Spawn naturally in enemy territory
- Increasing damage and range with each tier
- Distinct visual and audio feedback

## How to Use

### Flying the Aircraft
1. Research the "Aircraft" technology (requires Automobilism and Advanced Electronics)
2. Craft the aircraft using the recipe (requires engines, steel plates, circuits, and gears)
3. Place the aircraft and enter it
4. Add fuel to the aircraft
5. Accelerate forward for 3 seconds (configurable) to take off
6. Once airborne, you can fly over water and obstacles
7. Slow down below threshold speed to land

### Combat
- Aircraft has built-in weapons that use regular ammo
- AA Worms will target and fire at flying aircraft
- Aircraft has resistance to explosion damage but can be destroyed
- Stay mobile to avoid AA fire

## Balance

### Aircraft Stats
- Health: 800 HP
- Weight: 700
- Inventory: 60 slots
- Fuel efficiency: 0.8
- Explosion resistance: 40% reduction + 20 decrease

### AA Worm Damage (after resistances)
- Small AA Worm: ~45 damage per hit, 40 tile range
- Medium AA Worm: ~75 damage per hit, 50 tile range
- Big AA Worm: ~105 damage per hit, 60 tile range

Aircraft can survive approximately:
- 17+ hits from small AA worms
- 10+ hits from medium AA worms
- 7+ hits from big AA worms

## Settings

### Runtime Global
- **Aircraft takeoff time**: Adjust how long you need to accelerate before taking off (1-10 seconds, default 3)

### Startup
- **AA Worm spawn multiplier**: Control how many AA worms spawn (0-5x, default 1x)

### Per-User
- **Enable flight messages**: Toggle takeoff/landing/damage notification messages

## Compatibility

- Factorio version: 2.0+
- Should be compatible with most other mods
- May conflict with mods that heavily modify vehicle behavior

## Known Limitations

- Graphics are placeholder colors (blue for aircraft, red for AA worms)
- Aircraft uses car entity as base, so some car-like behaviors may appear
- AA worms target aircraft but may also attack other entities

## Credits

Created for Factorio 2.0

## License

See LICENSE file for details.
