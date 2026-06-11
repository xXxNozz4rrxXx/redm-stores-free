[README.md](https://github.com/user-attachments/files/28836301/README.md)
# Codex Stores

Codex Stores is a configurable RedM store system built for `codex_core`. It provides interactive NPC/location-based shops with buy and sell support, job restrictions, opening hours, blips, native RedM prompts, a custom NUI shop interface, and server-side transaction validation.

> Developed by **Codex Studios** & Titans Productions .

## Features

- Native RedM prompt support for opening stores.
- Optional CodexCore API usage for prompts, peds, and blips.
- Configurable store locations, NPCs, blips, hours, categories, and product packages.
- Buy and sell transaction support.
- Server-side validation for quantity, product, store access, job access, opening hours, inventory capacity, and player funds.
- Anti-spam action cooldown protection.
- Support for multiple currency/account types:
  - dollars
  - cents
  - gold
- Optional job-locked stores and job-locked products.
- Optional integration with `codex_leveling` for level-gated products.
- Custom NUI interface with category navigation, item search, item quantity selection, and live account display.
- Restart-safe cleanup for spawned NPCs, blips, prompts, and NUI focus.

## Requirements

- RedM server artifact with Lua 5.4 support.
- `codex_core` installed and started before this resource.
- Inventory, money, gold, notification, and callback functions available through `codex_core`.
- Optional: `codex_leveling` if you enable product level requirements.

## Installation

1. Download or clone this repository.
2. Place the folder inside your server resources directory:

   ```text
   resources/[codex]/codex_stores
   ```

3. Make sure `codex_core` is installed and started before `codex_stores`.
4. Add the resource to your `server.cfg`:

   ```cfg
   ensure codex_core
   ensure codex_stores
   ```

5. Restart your server or run:

   ```console
   refresh
   ensure codex_stores
   ```

## Resource Structure

```text
codex_stores/
├── client/
│   ├── client.lua       # Main client loop for store proximity, prompts, NPCs, and blips
│   ├── functions.lua    # CodexCore setup, native prompts, blips, NPC helpers, cleanup
│   └── nui.lua          # NUI callbacks and client-side shop UI logic
├── html/
│   ├── index.html       # NUI layout
│   ├── css/             # NUI styles
│   ├── js/              # NUI scripts and browser-side config
│   ├── img/             # UI images
│   └── audio/           # UI sounds
├── server/
│   └── server.lua       # Server-side callbacks, buy/sell validation, inventory/money handling
├── config.lua           # Store locations, products, categories, prices, jobs, hours, NPCs, blips
├── locales.lua          # Lua locale strings
├── fxmanifest.lua       # RedM resource manifest
├── LICENSE              # Project license
└── README.md            # Documentation
```

## Configuration

Most setup is done in `config.lua`.

### Main Settings

```lua
Config.DevMode = false
Config.OpenKey = 0xC7B5340A -- Enter

Config.UseCodexPromptAPI = false
Config.UseCodexPedAPI = false
Config.UseCodexBlipAPI = false

Config.AlwaysShowStoreBlips = true
Config.RenderNPCDistance = 30
Config.PromptHoldTime = 500
Config.ActionCooldown = 1500
Config.LevelingResource = 'codex_leveling'
```

| Option | Description |
| --- | --- |
| `Config.DevMode` | Enables debug prints when set to `true`. |
| `Config.OpenKey` | RedM control hash used to open a nearby store. Default is Enter. |
| `Config.UseCodexPromptAPI` | Enables CodexCore prompt API usage if available. Native RedM prompts are used by default. |
| `Config.UseCodexPedAPI` | Enables CodexCore ped API usage if available. Native RedM ped spawning is used by default. |
| `Config.UseCodexBlipAPI` | Enables CodexCore blip API usage if available. Native RedM blips are used by default. |
| `Config.AlwaysShowStoreBlips` | Shows store blips even when stores are closed. |
| `Config.RenderNPCDistance` | Distance at which store NPCs spawn/despawn. |
| `Config.PromptHoldTime` | Hold duration for the store prompt. |
| `Config.ActionCooldown` | Cooldown between buy/sell actions. Protects against spam. |
| `Config.LevelingResource` | Resource name used for optional level checks. |

## Adding a Store

Stores are defined inside `Config.Stores`.

Example:

```lua
['ExampleStore'] = {
    StoreName = 'GENERAL STORE',
    PromptName = 'Open General Store',

    Coords = { x = 123.45, y = 678.90, z = 100.00, h = 180.0 },
    DistanceOpenStore = 2.0,

    BlipData = {
        Allowed = true,
        Name = 'General Store',
        Sprite = 669307703,
        Scale = 0.2,
    },

    NPCData = {
        Allowed = true,
        Model = 'mp_u_m_m_buyer_regular_01',
    },

    Hours = {
        Allowed = false,
        Opening = 7,
        Closing = 23,
    },

    JobsData = {
        Allowed = false,
        Jobs = {},
    },

    Categories = {
        { category = 'goods', types = { 'buy', 'sell' } },
    },

    StoreProductsPackage = 'example_store',
}
```

### Store Fields

| Field | Description |
| --- | --- |
| `StoreName` | Header title shown in the NUI. |
| `PromptName` | Text shown in the RedM prompt group. |
| `Coords` | Store interaction, NPC, and blip position. `h` is heading. |
| `DistanceOpenStore` | Distance required to interact with the store. |
| `BlipData.Allowed` | Enables/disables the map blip. |
| `BlipData.Name` | Blip display name. |
| `BlipData.Sprite` | RedM blip sprite hash. |
| `NPCData.Allowed` | Enables/disables NPC spawning. |
| `NPCData.Model` | Ped model used for the store NPC. |
| `Hours.Allowed` | Enables/disables opening-hour checks. |
| `Hours.Opening` | Opening hour using the in-game clock. |
| `Hours.Closing` | Closing hour using the in-game clock. |
| `JobsData.Allowed` | Enables/disables store-level job restriction. |
| `JobsData.Jobs` | Jobs allowed to use the store. |
| `Categories` | Visible store categories and allowed transaction types. |
| `StoreProductsPackage` | Product package name from `Config.StoreProductPackages`. |

## Adding Products

Products are defined inside `Config.StoreProductPackages`.

Example:

```lua
Config.StoreProductPackages['example_store'] = {
    ['buy'] = {
        {
            label = 'Bread',
            item = 'bread',
            currency = 'dollars',
            price = 0.25,
            category = 'goods',
        },
    },

    ['sell'] = {
        {
            label = 'Gold Nugget',
            item = 'gold_nugget',
            currency = 'dollars',
            price = 1.00,
            category = 'goods',
        },
    },
}
```

### Product Fields

| Field | Description |
| --- | --- |
| `label` | Product name shown in the UI. |
| `item` | Inventory item name used by `codex_core`. |
| `currency` | Currency type. Supported values: `dollars`, `cents`, `gold`. |
| `price` | Unit price for buy/sell transactions. |
| `category` | Must match one of the store categories. |
| `jobs` | Optional product-level job restriction. |
| `requiredLevel` | Optional level requirement when store leveling is enabled. |

## Categories and Transaction Types

Each store category controls what products appear and which action type is available.

```lua
Categories = {
    { category = 'goods', types = { 'buy' } },
    { category = 'fishes', types = { 'sell' } },
}
```

Valid transaction types:

- `buy`
- `sell`

The product package must contain the same transaction key:

```lua
Config.StoreProductPackages['my_store'] = {
    ['buy'] = {},
    ['sell'] = {},
}
```

## Job Restrictions

### Store-Level Job Restriction

```lua
JobsData = {
    Allowed = true,
    Jobs = { 'doctor' },
}
```

Only players with one of the listed jobs can open and use the store.

### Product-Level Job Restriction

```lua
{
    label = 'Medical Supply',
    item = 'medical_supply',
    currency = 'dollars',
    price = 1.00,
    category = 'medical',
    jobs = { 'doctor' },
}
```

Only players with one of the listed jobs can see and use that product.

## Opening Hours

Opening hours use the in-game clock.

```lua
Hours = {
    Allowed = true,
    Opening = 7,
    Closing = 23,
}
```

If `Opening` is lower than `Closing`, the store is open during that same-day range. If `Opening` is higher than `Closing`, the store is treated as an overnight store.

Examples:

```lua
Opening = 7,
Closing = 23,
```

Open from 07:00 until 23:00.

```lua
Opening = 20,
Closing = 5,
```

Open from 20:00 until 05:00.

## Optional Level Requirements

The NUI logic supports optional product level checks through `Config.LevelingResource`, defaulting to `codex_leveling`.

Example product:

```lua
{
    label = 'Advanced Item',
    item = 'advanced_item',
    currency = 'dollars',
    price = 5.00,
    category = 'goods',
    requiredLevel = 10,
}
```

If level gating is enabled in your store configuration and the leveling resource is running, the player must meet the required level before using the product.

## Security Notes

This resource does not trust NUI/client-side data for final transactions. The server validates:

- selected store ID
- selected product item name
- transaction type
- quantity
- product category access
- store opening hours
- store job access
- product job access
- player inventory capacity when buying
- player item quantity when selling
- player account balance when buying
- action cooldowns

This is important because NUI callbacks and client events can be triggered manually by malicious clients.

## Common Issues

### Store does not open

Check:

- `codex_core` is started before `codex_stores`.
- The player is close enough to `Coords`.
- `DistanceOpenStore` is not too low.
- The store is open if `Hours.Allowed = true`.
- The player's job is allowed if `JobsData.Allowed = true`.

### NPC does not spawn

Check:

- `NPCData.Allowed = true`.
- `NPCData.Model` is a valid RedM ped model.
- The player is within `Config.RenderNPCDistance`.
- The store is open if opening hours are enabled.

### Products do not show

Check:

- `StoreProductsPackage` matches a key inside `Config.StoreProductPackages`.
- Product transaction type exists: `buy` or `sell`.
- Product `category` matches the selected store category.
- Product job restriction is not blocking the player.
- Optional level requirement is not blocking the player.

### Player cannot buy item

Check:

- The item exists in your inventory system.
- The player has enough money/gold/cents.
- `CodexCore.CanCarryItem` returns true.
- Product `currency` is correctly set.

### Player cannot sell item

Check:

- The player has enough of the selected item.
- The product exists inside the `sell` package.
- The category is configured for `sell`.

## Updating

When updating from an older version:

1. Back up your current `config.lua`.
2. Replace the resource files.
3. Re-apply your custom stores and products carefully.
4. Restart the resource.
5. Test buy and sell flows with a normal player account and a restricted job account.

## GitHub Upload

From inside the `codex_stores` folder:

```bash
git init
git add .
git commit -m "Initial release"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/codex_stores.git
git push -u origin main
```

Replace `YOUR_USERNAME` with your GitHub username or organization.

## License

This project is licensed under the **PolyForm Noncommercial License 1.0.0**.

This is a real published software license for non-commercial use. It is **not GPL** and it is **not OSI open source**, because it restricts commercial use. That restriction is intentional for this resource.

Allowed:

- Use the resource on non-commercial RedM servers.
- Modify the resource for your own non-commercial server.
- Share copies only under the same license terms and with the license notice included.

Not allowed:

- Selling the resource.
- Reselling modified or unmodified versions.
- Including it in paid script packs, paid bundles, subscriptions, or escrow-style paid releases.
- Claiming ownership of Codex Studios work.

Violations may terminate the license and may be handled through copyright enforcement or platform takedown processes where applicable.

See [`LICENSE`](LICENSE) for the full license text.

## Credits

- Author: **Codex Studios**
- Resource: **codex_stores**
- Platform: **RedM**
- Core dependency: **codex_core**
