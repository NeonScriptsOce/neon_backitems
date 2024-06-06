
# Weapon Display Script

This script displays weapons on a person using QBCore functions to check when the player has spawned and checks ox_inventory for selected items.

## Features

- Attaches weapon models to the player based on their inventory.
- Configurable positions and models for each weapon.
- Automatically updates when the player's inventory changes.

## Requirements

- QBCore
- ox_inventory

## Installation

1. Download the script and place it in your `resources` folder.
2. Add the resource to your `server.cfg`:

   ```plaintext
   ensure your_resource_name
   ```

3. Configure the weapons in `config.lua` to specify the weapons you want to check and their positions on the player.

## Configuration

Edit the `config.lua` file to configure the weapons. The configuration should look like this:

```lua
Config = {}

Config.Weapons = {
    ["weapon_pistol"] = {
        bone = 24816, -- bone index
        x = 0.1,
        y = -0.15,
        z = 0.0,
        xRot = 0.0,
        yRot = 135.0,
        zRot = 0.0,
        model = "w_pi_pistol"
    },
    ["weapon_knife"] = {
        bone = 24816, -- bone index
        x = 0.1,
        y = -0.15,
        z = 0.0,
        xRot = 0.0,
        yRot = 135.0,
        zRot = 0.0,
        model = "w_me_knife_01"
    }
    -- Add more weapons as needed
}
```

## Usage

The script will automatically attach weapon models to the player based on their inventory. It checks the player's inventory when they spawn and periodically thereafter. It also listens for inventory updates to recheck the player's weapons.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
