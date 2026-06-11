Config = {}

Config.DevMode = false

Config.OpenKey = 0xC7B5340A -- Enter

-- This resource now uses native RedM prompts and native RedM ped spawning by default.
-- CodexCore is still used for framework data, callbacks, notifications, inventory and money.
Config.UseCodexPromptAPI = false
Config.UseCodexPedAPI = false
Config.UseCodexBlipAPI = false

-- Creates a map blip for every configured store on resource start.
-- Leave this true if you want every store location visible even before walking close.
Config.AlwaysShowStoreBlips = true

Config.RenderNPCDistance = 30
Config.PromptHoldTime = 500
Config.ActionCooldown = 1500
Config.LevelingResource = 'codex_leveling'

Config.Stores = {

  ['Fishing'] = {

    StoreName = 'FISHING SELLER',
    PromptName = 'SELL YOUR FISH',
    Coords = { x = 440.0, y = 401.23, z = 108.13, h = 342.04}, -- Blip / Prompt & NPC Positions.

    DistanceOpenStore = 2.0,

    BlipData = {
      Allowed = true,
      Name   = 'New Hanover Market',
      Sprite  = 819673798,
    },

    NPCData = {
      Allowed = true,
      Model = 'mp_dr_u_f_m_missingfisherman_01',
    },

    Hours = {
      Allowed = false,
      Opening = 7,
      Closing = 23,
    },

    JobsData = {
      Allowed = false,
      Jobs   = {},
    },
    
    Categories = { 
      { category = 'fishes', types = {'sell'} },
    }, 

    StoreProductsPackage = 'fishing_store', -- The store name that has been created on Config.StoreProductPackages.
  },

  ['Job Store'] = {

    StoreName = 'JOB STORE',
    PromptName = 'job store',
    Coords = {x = 418.07, y = 411.99, z = 108.62, h = 338.62}, -- Blip / Prompt & NPC Positions.

    DistanceOpenStore = 3.0,

    BlipData = {
      Allowed = true,
      Name   = 'Job Store',
      Sprite  = 669307703,
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
      Jobs   = {},
    },
    
    Categories = { 
      { category = 'goods', types = {'sell'} },
    }, 

    StoreProductsPackage = 'jobs_store', -- The store name that has been created on Config.StoreProductPackages.
  },

  ['Herbalist'] = {

    StoreName = 'HERBAL STORE',
    PromptName = 'herbal store',
    Coords = {x = 433.79, y = 414.2, z = 108.49, h = 156.42}, -- Blip / Prompt & NPC Positions.

    DistanceOpenStore = 3.0,

    BlipData = {
      Allowed = true,
      Name   = 'Herbal Store',
      Sprite  = 669307703,
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
      Jobs   = {},
    },
    
    Categories = { 
      { category = 'products', types = {'sell'} },
    }, 

    StoreProductsPackage = 'herb_store', -- The store name that has been created on Config.StoreProductPackages.
  },

  ['Robberies'] = {

    StoreName = 'ROBBERY SELLER',
    PromptName = 'ROBBERY SELLER',

    Coords = {x = 1998.97, y = -1608.35, z = 45.15, h = 295.16}, -- Blip / Prompt & NPC Positions.

    DistanceOpenStore = 2.0,

    BlipData = {
      Allowed = true,
      Name   = 'Robbery Seller',
      Sprite  = 669307703,
    },

    NPCData = {
      Allowed = true,
      Model = 'g_m_m_unibanditos_01',
    },

    Hours = {
      Allowed = false,
      Opening = 7,
      Closing = 23,
    },

    JobsData = {
      Allowed = false,
      Jobs   = {},
    },
    
    Categories = { 
      { category = 'Robbery Items', types = {'sell'} },
    }, 

    StoreProductsPackage = 'robberies', -- The store name that has been created on Config.StoreProductPackages.
  },

  ['Medical1'] = {

    StoreName = 'MEDICAL STORE',
    PromptName = 'MEDICAL STORE',

    Coords = {x = 2727.94, y = -1232.2, z = 50.43, h = 96.74},

    DistanceOpenStore = 2.0,

    BlipData = {
      Allowed = true,
      Name   = 'Medical Store',
      Sprite  = 669307703,
    },

    NPCData = {
      Allowed = false,
      Model = 'mp_u_m_m_buyer_regular_01',
    },

    Hours = {
      Allowed = false,
      Opening = 7,
      Closing = 23,
    },

    JobsData = {
      Allowed = true,
      Jobs   = {'doctor'},
    },
    
    Categories = { 
      { category = 'medical', types = {'buy'} },
    }, 

    StoreProductsPackage = 'medical_store', -- The store name that has been created on Config.StoreProductPackages.
  },

  ['Medical2'] = {

    StoreName = 'MEDICAL STORE',
    PromptName = 'MEDICAL STORE',

    Coords =  { x = -285.69, y = 810.4, z = 119.44, h = 326.36},

    DistanceOpenStore = 2.0,

    BlipData = {
      Allowed = true,
      Name   = 'Medical Store',
      Sprite  = 669307703,
    },

    NPCData = {
      Allowed = false,
      Model = 'mp_u_m_m_buyer_regular_01',
    },

    Hours = {
      Allowed = false,
      Opening = 7,
      Closing = 23,
    },

    JobsData = {
      Allowed = true,
      Jobs   = {'doctor'},
    },
    
    Categories = { 
      { category = 'medical', types = {'buy'} },
    }, 

    StoreProductsPackage = 'medical_store', -- The store name that has been created on Config.StoreProductPackages.
  },

  ['Medical3'] = {

    StoreName = 'MEDICAL STORE',
    PromptName = 'MEDICAL STORE',

    Coords =  { x = -1808.04, y = -431.14, z = 158.88, h = 243.62},

    DistanceOpenStore = 2.0,

    BlipData = {
      Allowed = true,
      Name   = 'Medical Store',
      Sprite  = 669307703,
    },

    NPCData = {
      Allowed = false,
      Model = 'mp_u_m_m_buyer_regular_01',
    },

    Hours = {
      Allowed = false,
      Opening = 7,
      Closing = 23,
    },

    JobsData = {
      Allowed = true,
      Jobs   = {'doctor'},
    },
    
    Categories = { 
      { category = 'medical', types = {'buy'} },
    }, 

    StoreProductsPackage = 'medical_store', -- The store name that has been created on Config.StoreProductPackages.
  },

  ['Medical4'] = {

    StoreName = 'MEDICAL STORE',
    PromptName = 'MEDICAL STORE',

    Coords =  { x = -788.3, y = -1307.21, z = 43.86, h = 0.4},

    DistanceOpenStore = 2.0,

    BlipData = {
      Allowed = true,
      Name   = 'Medical Store',
      Sprite  = 669307703,
    },

    NPCData = {
      Allowed = false,
      Model = 'mp_u_m_m_buyer_regular_01',
    },

    Hours = {
      Allowed = false,
      Opening = 7,
      Closing = 23,
    },

    JobsData = {
      Allowed = true,
      Jobs   = {'doctor'},
    },
    
    Categories = { 
      { category = 'medical', types = {'buy'} },
    }, 

    StoreProductsPackage = 'medical_store', -- The store name that has been created on Config.StoreProductPackages.
  },

  ['Collector'] = {

    StoreName = 'COLLECTOR STORE',
    PromptName = 'COLLECTOR STORE',

    Coords =  { x = -1545.35, y = 251.43, z = 114.75, h = 63.23},

    DistanceOpenStore = 2.0,

    BlipData = {
      Allowed = true,
      Name   = 'Collector Store',
      Sprite  = 669307703,
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
      Allowed = true,
      Jobs   = {'collector'},
    },
    
    Categories = { 
      { category = 'collector', types = {'buy'} },
    }, 

    StoreProductsPackage = 'collector_store', -- The store name that has been created on Config.StoreProductPackages.
  },
  ['Wapitistore'] = {

    StoreName = 'Wapiti Store',
    PromptName = 'Wapiti Store',

    Coords = {x = 434.3, y = 2193.3, z = 246.79, h = 52.68}, -- Blip / Prompt & NPC Positions.

    DistanceOpenStore = 2.0,

    BlipData = {
        Allowed = true,
        Name    = 'Wapiti Store',
        Sprite  = 819673798,
    },

    NPCData = {
        Allowed = true,
        Model = 'msp_native1_males_01',
    },

    Hours = {
        Allowed = false,
        Opening = 7,
        Closing = 23,
    },

    JobsData = {
        Allowed = false,
        Jobs    = {},
    },
    
    Categories = { 
        { category = 'store', types = {'buy'} },

    }, 

    StoreProductsPackage = 'wapitistore', -- The store name that has been created on Config.StoreProductPackages.
  },

  ['TrapperWapitiStore'] = {
    StoreName = 'Wapiti Trapper Store',
    PromptName = 'Wapiti Trapper Store',
    Coords = {x = 423.45, y = 2136.09, z = 252.06, h = 210.97}, -- Blip / Prompt & NPC Positions.
    DistanceOpenStore = 2.0,
    BlipData = {
        Allowed = true,
        Name    = 'Wapiti Trapper Store',
        Sprite  = 688589278,
    },
    NPCData = {
        Allowed = true,
        Model = 'msp_native1_males_01',
    },
    Hours = {
        Allowed = false,
        Opening = 7,
        Closing = 23,
    },
    JobsData = {
        Allowed = false,
        Jobs    = {},
    },
    
    Categories = { 
        { category = 'sell', types = {'sell'} },
    }, 
    StoreProductsPackage = 'trapper_wapiti', -- The store name that has been created on Config.StoreProductPackages.
  },
}

Config.StoreProductPackages = {
   
  ['fishing_store'] = {

      ['sell'] = {

          { label = 'Blue Gil (Medium)', item = 'a_c_fishbluegil_01_ms',  currency = 'dollars',  price = 0.30, category = 'fishes' },
          { label = 'Blue Gil (Small)',  item = 'a_c_fishbluegil_01_sm',  currency = 'dollars',  price = 0.20, category = 'fishes' },
          { label = 'Bullhead Cat (Medium)',       item = 'a_c_fishbullheadcat_01_ms',        currency = 'dollars',  price = 0.30, category = 'fishes' },
          { label = 'Bullhead Cat (Small)',        item = 'a_c_fishbullheadcat_01_sm',        currency = 'dollars',  price = 0.20, category = 'fishes' },
          { label = 'Chain Pickerel (Medium)',      item = 'a_c_fishchainpickerel_01_ms',      currency = 'dollars',  price = 0.30, category = 'fishes' },
          { label = 'Chain Pickerel (Small)',      item = 'a_c_fishchainpickerel_01_sm',      currency = 'dollars',  price = 0.20, category = 'fishes' },
          { label = 'Channel Catfish (Large)',      item = 'a_c_fishchannelcatfish_01_lg',      currency = 'dollars',  price = 0.35, category = 'fishes' },
          { label = 'Channel Catfish (E-Large)',    item = 'a_c_fishchannelcatfish_01_xl',      currency = 'dollars',  price = 0.45, category = 'fishes' },
          { label = 'Lake Sturgeon (Large)',       item = 'a_c_fishlakesturgeon_01_lg',       currency = 'dollars',  price = 0.35, category = 'fishes' },
          { label = 'Large Mouth Bass (Large)',     item = 'a_c_fishlargemouthbass_01_lg',      currency = 'dollars',  price = 0.35, category = 'fishes' },
          { label = 'Large Mouth Bass (Medium)',    item = 'a_c_fishlargemouthbass_01_ms',      currency = 'dollars',  price = 0.30, category = 'fishes' },
          { label = 'Long Nose Gar (Large)',       item = 'a_c_fishlongnosegar_01_lg',        currency = 'dollars',  price = 0.35, category = 'fishes' },
          { label = 'Muskie (Large)',   item = 'a_c_fishmuskie_01_lg',  currency = 'dollars',  price = 0.35, category = 'fishes' },
          { label = 'Northern Pike (Large)',       item = 'a_c_fishnorthernpike_01_lg',       currency = 'dollars',  price = 0.35, category = 'fishes' },
          { label = 'Perch (Medium)',   item = 'a_c_fishperch_01_ms',   currency = 'dollars',  price = 0.40, category = 'fishes' },
          { label = 'Perch (Small)',    item = 'a_c_fishperch_01_sm',   currency = 'dollars',  price = 0.20, category = 'fishes' },
          { label = 'Rainbow Trout (Large)',       item = 'a_c_fishrainbowtrout_01_lg',       currency = 'dollars',  price = 0.35, category = 'fishes' },
          { label = 'Rainbow Trout (Medium)',      item = 'a_c_fishrainbowtrout_01_ms',       currency = 'dollars',  price = 0.30, category = 'fishes' },
          { label = 'Red Fin Pickerel (Medium)',    item = 'a_c_fishredfinpickerel_01_ms',      currency = 'dollars',  price = 0.30, category = 'fishes' },
          { label = 'Red Fin Pickerel (Small)',     item = 'a_c_fishredfinpickerel_01_sm',      currency = 'dollars',  price = 0.20, category = 'fishes' },
          { label = 'Rock Bass (Medium)',         item = 'a_c_fishrockbass_01_ms', currency = 'dollars',  price = 0.30, category = 'fishes' },
          { label = 'Rock Bass (Small)', item = 'a_c_fishrockbass_01_sm', currency = 'dollars',  price = 0.20, category = 'fishes' },
          { label = 'Salmon Sockeye (Large)',      item = 'a_c_fishsalmonsockeye_01_lg',      currency = 'dollars',  price = 0.35, category = 'fishes' },
          { label = 'Salmon Sockeye (M-Large)',     item = 'a_c_fishsalmonsockeye_01_ml',      currency = 'dollars',  price = 0.40, category = 'fishes' },
          { label = 'Salmon Sockeye (Medium)',      item = 'a_c_fishsalmonsockeye_01_ms',      currency = 'dollars',  price = 0.30, category = 'fishes' },
          { label = 'Small Mouth Bass (Large)',     item = 'a_c_fishsmallmouthbass_01_lg',      currency = 'dollars',  price = 0.35, category = 'fishes' },
          { label = 'Small Mouth Bass (Medium)',    item = 'a_c_fishsmallmouthbass_01_ms',      currency = 'dollars',  price = 0.30, category = 'fishes' },
          { label = 'Crab',          item = 'a_c_crawfish_01',      currency = 'dollars',  price = 0.30, category = 'fishes' },
      },
      
  },

  ['jobs_store'] = {
      
    ['sell'] = {
      { label = 'Gold Nugget', item = 'gold_nugget', currency = 'dollars', price =  1, category = 'goods' },
      { label = 'Clay', item = 'clay', currency = 'dollars', price =  0.20, category = 'goods' },
      { label = 'Iron', item = 'iron', currency = 'dollars', price =  0.20, category = 'goods' },
      { label = 'Sulfur', item = 'sulfur', currency = 'dollars', price = 0.20, category = 'goods' },
      { label = 'Copper', item = 'copper', currency = 'dollars', price = 0.20, category = 'goods' },
      { label = 'Coal', item = 'coal', currency = 'dollars', price = 0.20, category = 'goods' },
      { label = 'Salt', item = 'salt', currency = 'dollars', price = 0.20, category = 'goods' },
      { label = 'Gold Fragments', item = 'goldfragment', currency = 'dollars', price = 0.25, category = 'goods' },
      { label = 'Platinum', item = 'platinum', currency = 'dollars', price = 3, category = 'goods' },
      { label = 'Rock', item = 'rock', currency = 'dollars', price = 0.15, category = 'goods' },
      { label = 'Diamond', item = 'diamond', currency = 'dollars', price = 6, category = 'goods' },
      { label = 'Silver', item = 'silver', currency = 'dollars', price = 0.20, category = 'goods' },
      { label = 'Wood', item = 'wood', currency = 'dollars', price = 0.20, category = 'goods' },
    }, 

  },

  ['herb_store'] = {
    
    ['sell'] = {

      { label = 'American Ginseng',     item = 'American_Ginseng',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Hop', item = 'hop',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Blackberry', item = 'craft_herb_black_berry',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Blood Flower', item = 'Blood_Flower',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Daisy', item = 'Choc_Daisy',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Coffee Beans', item = 'coffeebeans',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Creeking Thyme', item = 'Creeking_Thyme',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Crows Garlic',     item = 'Crows_Garlic',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Indian Tobacco', item = 'Indian_Tobbaco',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Parasol Mushroom', item = 'Parasol_Mushroom',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Red Raspberry', item = 'Red_Raspberry',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Red Sage', item = 'Red_Sage',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Tea Leaf', item = 'tealeaf',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Wild Carrots', item = 'Wild_Carrot',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Wild Mint', item = 'Wild_Mint',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Wintergreen', item = 'Wintergreen_Berry',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Yarrow', item = 'Yarrow',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Corn', item = 'corn',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Apple', item = 'apple',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Sugar', item = 'sugar',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Potato', item = 'potato',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Cacao', item = 'cocoa',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Peach', item = 'consumable_peach',  currency = 'dollars',  price = 0.20, category = 'products' },
      { label = 'Tomato', item = 'craft_tomato',  currency = 'dollars',  price = 0.20, category = 'products' },

    },

  },

  ['medical_store'] = {
    ['buy'] = {
      { label = 'Bandage', item = 'consumable_bandage', currency = 'dollars', price = 1, category = 'medical' },
      { label = 'Syringe', item = 'syringe', currency = 'dollars', price = 2.50, category = 'medical' },
    },
  },

  ['collector_store'] = {
    ['buy'] = {
      { label = 'Chest C', item = 'chestc', currency = 'dollars', price = 80, category = 'collector' },
      { label = 'Poker Table Set', item = 'pokerset', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Hitching Post', item = 'hitchingpost', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Large Butcher Table', item = 'butchertable3', currency = 'dollars', price = 200, category = 'collector' },
      { label = 'Medium Butcher Table', item = 'butchertable2', currency = 'dollars', price = 150, category = 'collector' },
      { label = 'Small Butcher Table', item = 'butchertable1', currency = 'dollars', price = 100, category = 'collector' },
      { label = 'Native Decor Set', item = 'nativedecor', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Gypsys Wagon Set', item = 'gypsywagon', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Beer Box', item = 'beerbox', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Water Barrel', item = 'waterbarrel', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Trader Tent', item = 'tent2', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Simple Tent', item = 'tent3', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Canvas Shade', item = 'tent4', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Dream Catcher', item = 'dreamcatcher', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Native Pot', item = 'nativepot', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Native Basket 1', item = 'nativebasket1', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Native Basket 2', item = 'nativebasket2', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Native Decor 1', item = 'nativeskull', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Native Tipi', item = 'tipi', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Skull Post', item = 'skullpost', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Lounge Chair', item = 'loungechair', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Lounge Chair 2', item = 'loungechair2', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Decor Tent 1 Set', item = 'decortent1', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Decor Tent 2 Set', item = 'decortent2', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Decor Tent 3 Set', item = 'decortent3', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Horse Hitches Set', item = 'horsehitches', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Robbery Planning Set', item = 'robberyplanning', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Naturalists Wagon Set', item = 'naturalwagon', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Lamp Post 1 Set', item = 'lamppost1', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Lamp Post 2 Set', item = 'lamppost2', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Mountain Camp Set', item = 'mountainmen', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Coffin', item = 'undertaker1', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Flower Coffin', item = 'undertaker2', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Kitchen Counter', item = 'kitchencounter', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Stading Torch', item = 'standingtorch', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Shooting Target', item = 'shootingtarget', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Serving Table', item = 'trayoffood', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Hemp Seed', item = 'hemp_seed', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Hemp', item = 'hemp', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Anti Snake Poison', item = 'antipoison2', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Bounty Hunter Tent', item = 'tent', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Wood Chair', item = 'wood_chair', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Leather Chair', item = 'leather_chair', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Round Table', item = 'round_table', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Table', item = 'standard_table', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Rectangle Table', item = 'rectangle_table', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Timber Table', item = 'timber_table', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Crafting Fire', item = 'crafting_fire', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'House Pot', item = 'pota', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Water Pump', item = 'water_pump', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Flower Boxes', item = 'flowerboxes', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Coffin Decor', item = 'coffindecor', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Deer Pelt', item = 'deer_pelt', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Coyote Pelt', item = 'coyote_pelt', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Blanket Box', item = 'blanket_box', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Gun Barrel', item = 'gun_barrel', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Apple Barrel', item = 'apple_barrel', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Apple Basket', item = 'apple_basket', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Food Barrel', item = 'food_barrel', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Wash Tub', item = 'washtub', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Clothes Line', item = 'clothes_line', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Tool Barrel', item = 'tool_barrel', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Coyote Taxidermy', item = 'coyote_taxidermy', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Pheasant Taxidermy', item = 'pheasant_taxidermy', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Deer Taxidermy', item = 'deer_taxidermy', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Cougar Taxidermy', item = 'cougar_taxidermy', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Vulture Taxidermy', item = 'vulture_taxidermy', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Bear Bench', item = 'bear_bench', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Log Bench 1', item = 'log_bencha', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Log Bench 2', item = 'log_benchb', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Cloth Bench', item = 'cloth_bench', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Wooden Bench', item = 'wooden_bench', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Wicker Bench', item = 'wicker_bench', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'brown wood dresser', item = 'bwdresser', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'brown mirror dresser', item = 'bmdresser', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'night stand', item = 'nightstand', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'side table 1', item = 'side_table', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'side table 2', item = 'side_tablea', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'side table 3', item = 'side_tableb', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'chest 1', item = 'chesta', currency = 'dollars', price = 80, category = 'collector' },
      { label = 'chest 2', item = 'chestb', currency = 'dollars', price = 80, category = 'collector' },
      { label = 'Lantern', item = 'lanterna', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Dbl Candle', item = 'dbcandle', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Candle', item = 'candlea', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Small Melted Candle', item = 'smallmcandle', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Bottle Candle', item = 'bcandle', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'Old bed', item = 'obed', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'bunk bed', item = 'bunkbed', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'single bed', item = 'singlebed', currency = 'dollars', price = 20, category = 'collector' },
      { label = 'fancy double', item = 'fancydouble', currency = 'dollars', price = 20, category = 'collector' },
    }
  },

  ['robberies'] = {
    
    ['sell'] = {
      { label = 'Platinum Ring', item = 'criminal_ring_platinum', currency = 'dollars', price = 1.00, category = 'Robbery Items' },
      { label = 'Beaulieux Diamond Ring', item = 'criminal_ring_beaulieux_diamond', currency = 'dollars', price = 0.30, category = 'Robbery Items' },
      { label = 'Criminal Gold Coin', item = 'criminal_gold_coin', currency = 'dollars', price = 0.30, category = 'Robbery Items' },
      { label = 'Banais Topaz Ring', item = 'criminal_ring_banais_topaz', currency = 'dollars', price = 0.30, category = 'Robbery Items' },
      { label = 'Agatized Coral Fossil', item = 'collector_fossil_agatized_coral', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Bivalve Fossil', item = 'collector_fossil_bivalve', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Brachiopod Fossil', item = 'collector_fossil_brachiopod', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Brow Horn Fossil', item = 'collector_fossil_brow_horn', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Cephalopod Fossil', item = 'collector_fossil_cephalopod', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Petrified Wood Fossil', item = 'collector_fossil_common_petrified_wood', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Cryptolithus Trilobite', item = 'collector_fossil_cryptolithus_trilobite', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Isotelus Trilobite', item = 'collector_fossil_isotelus_trilobite', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Petoskey Stone Fossil', item = 'collector_fossil_petoskey_stone', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Neospirifer Fossil', item = 'collector_fossil_neospirifer', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Sea Lily Fossil', item = 'collector_fossil_sea_lily', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Sea Scorpion Fossil', item = 'collector_fossil_sea_scorpion', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Upper Tooth Fossil', item = 'collector_fossil_tooth_upper', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Tully Monster Fossil', item = 'collector_fossil_tully_monster', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Yellowcat Petrified Wood', item = 'collector_fossil_yellowcat_petrified_wood', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Ammolite Gemstone', item = 'provision_gemstone_ammolite', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Ancient Eagle Statue', item = 'provision_statue_ancient_eagle', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Meteorite Fragment', item = 'provision_meteorite', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Animal Scent Gland', item = 'provision_scent_gland', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Fertility Statue', item = 'provision_statue_fertility3', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Tail Spike Fossil', item = 'collector_fossil_tail_spike', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Sickle Claw Toe Fossil', item = 'collector_fossil_toe_sickle_claw', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Front Tooth Fossil', item = 'collector_fossil_tooth_front', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Serrated Tooth Fossil', item = 'collector_fossil_tooth_serrated', currency = 'dollars', price = 0.15, category = 'Robbery Items' },
      { label = 'Gold Bracelet', item = 'goldbracelet', currency = 'dollars', price = 1.00, category = 'Robbery Items' },
      { label = 'Gold Necklace', item = 'goldnecklace', currency = 'dollars', price = 1.00, category = 'Robbery Items' },
      { label = 'Gold Ring', item = 'goldring', currency = 'dollars', price = 1.00, category = 'Robbery Items' },
      { label = 'Gold Tooth', item = 'goldtooth', currency = 'dollars', price = 1.00, category = 'Robbery Items' },
      { label = 'Gold Coin', item = 'goldcoin', currency = 'dollars', price = 1.00, category = 'Robbery Items' },
      { label = 'Pocket Watch', item = 'pocket_watch', currency = 'dollars', price = 1.00, category = 'Robbery Items' },

    }, 

  },
  ['trapper_wapiti'] = {

    ['sell'] = {
      { label = 'Grizzly Bear Pelt',    item = 'pelt_bear_grizzly',          currency = 'dollars',   price = 1, category = 'sell' },
      { label = 'Black Bear Pelt',    item = 'pelt_bear_black',          currency = 'dollars',   price = 1, category = 'sell' },
      { label = 'Feather',    item = 'feather',          currency = 'dollars',   price = 0.20, category = 'sell' },
      { label = 'Deer Pelt',    item = 'deerpelt',          currency = 'dollars',   price = 0.20, category = 'sell' },
      { label = 'Ram Pelt',    item = 'pelt_ram',          currency = 'dollars',   price = 0.20, category = 'sell' },
      { label = 'Animal Pelt',    item = 'pelt',          currency = 'dollars',   price = 0.20, category = 'sell' },
      { label = 'Snake Skin',    item = 'SnakeSkin',          currency = 'dollars',   price = 0.50, category = 'sell' },
      { label = 'Fiber',    item = 'fibers',          currency = 'dollars',   price = 0.20, category = 'sell' },
      { label = 'Leather',    item = 'leather',          currency = 'dollars',   price = 0.20, category = 'sell' },
      { label = 'Panther Pelt',    item = 'panthers',          currency = 'dollars',   price = 3, category = 'sell' },
      { label = 'Cougar Pelt',    item = 'cougars',          currency = 'dollars',   price = 3, category = 'sell' },
      { label = 'Coyote Pelt',    item = 'coyotes',          currency = 'dollars',   price = 0.20, category = 'sell'},
      { label = 'Moose Pelt',    item = 'mooses',          currency = 'dollars',   price = 0.20, category = 'sell'},
      { label = 'Aligator Pelt',    item = 'aligators',          currency = 'dollars',   price = 0.30, category = 'sell'},
      { label = 'Fox Pelt',    item = 'foxskin',          currency = 'dollars',   price = 0.20, category = 'sell'},
      { label = 'Wolf Pelt',    item = 'wolfpelt',          currency = 'dollars',   price = 1, category = 'sell'},
      { label = 'Buck Skin',    item = 'bucks',          currency = 'dollars',   price = 0.20, category = 'sell'},
      { label = 'Boar Pelt',    item = 'boars',          currency = 'dollars',   price = 0.20, category = 'sell'},
      { label = 'Bear Heart',    item = 'bearHeart',          currency = 'dollars',   price = 0.30, category = 'sell'},
        
    },
  },
   
  ['wapitistore'] = {
    ['buy'] = {
        -- tools
        { label = 'Crafting Book',          item = 'craftbook',           currency = 'dollars', price = 0.30,  category = 'store' },
        { label = 'Empty Can',              item = 'empty_can',           currency = 'dollars', price = 0.10,  category = 'store' },
        { label = 'Glass Bottle',           item = 'glassbottle',           currency = 'dollars', price = 0.10,  category = 'store' },
        --{ label = 'Poster',                 item = 'poster',                    currency = 'dollars', price = 1,  category = 'tools' },
        --{ label = 'Matches',                item = 'matches',                  currency = 'dollars', price = 0.10,  category = 'tools' },
        -- food
        { label = 'Water',                  item = 'consumable_water_bottle', currency = 'dollars',   price = 0.20, category = 'store' },
        { label = 'Bread',                  item = 'consumable_bread',        currency = 'dollars',   price = 0.20, category = 'store' },
        { label = 'Horse Meal',             item = 'horsemeal',               currency = 'dollars',   price = 1, category = 'store' },
        --{ label = 'Coffee',                 item = 'consumable_coffee',                  currency = 'dollars', price = 0.20,  category = 'food' },
    },
  },
}

local function AddImportedCodexStore(storeId, storeData)
  Config.Stores[storeId] = storeData
end

local function ImportedHours(alwaysOpened, openTime, closeTime)
  return {
    Allowed = not alwaysOpened,
    Opening = openTime or 8,
    Closing = closeTime or 21,
  }
end

local importedGeneralStoreCategories = {
  { category = 'tools', types = {'buy'} },
  { category = 'food',  types = {'buy'} },
}

local importedMerchantStoreCategories = {
  { category = 'tools', types = {'buy'} },
  { category = 'goods', types = {'buy'} },
}

local importedHerbalStoreCategories = {
  { category = 'herbal', types = {'buy'} },
}

local importedFishingStoreCategories = {
  { category = 'fishing', types = {'buy'} },
}

local importedBlackmarketCategories = {
  { category = 'tools', types = {'buy'} },
}

AddImportedCodexStore('ImportedRhodesGeneralStore', {
  StoreName = 'Rhodes General Store',
  PromptName = 'Open Rhodes General Store',
  Coords = { x = 1329.67, y = -1294.58, z = 77.02, h = 63.72 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Rhodes General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_special_05' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedColterGeneralStore', {
  StoreName = 'Colter General Store',
  PromptName = 'Open Colter General Store',
  Coords = { x = -1348.92, y = 2402.55, z = 307.07, h = 332.28 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Colter General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 're_coachrobbery_males_01' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedVanHornGeneralStore', {
  StoreName = 'Van Horn General Store',
  PromptName = 'Open Van Horn General Store',
  Coords = { x = 3025.56, y = 562.38, z = 44.77, h = 272.86 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Van Horn General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_special_05' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedSaintDenisGeneralStore', {
  StoreName = 'Saint Denis General Store',
  PromptName = 'Open Saint Denis General Store',
  Coords = { x = 2824.58, y = -1319.48, z = 46.81, h = 318.87 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Saint Denis General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_special_05' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedValentineGeneralStore', {
  StoreName = 'Valentine General Store',
  PromptName = 'Open Valentine General Store',
  Coords = { x = -324.628, y = 803.9818, z = 117.88, h = -81.17 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Valentine General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_special_05' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedStrawberryGeneralStore', {
  StoreName = 'Strawberry General Store',
  PromptName = 'Open Strawberry General Store',
  Coords = { x = -1789.66, y = -387.918, z = 160.32, h = 56.96 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Strawberry General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_special_05' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedBlackwaterGeneralStore', {
  StoreName = 'Blackwater General Store',
  PromptName = 'Open Blackwater General Store',
  Coords = { x = -784.738, y = -1321.73, z = 43.884, h = 179.63 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Blackwater General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_special_05' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedArmadilloGeneralStore', {
  StoreName = 'Armadillo General Store',
  PromptName = 'Open Armadillo General Store',
  Coords = { x = -3687.33, y = -2623.71, z = -13.48, h = 266.35 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Armadillo General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_special_05' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedAnnesburgGeneralStore', {
  StoreName = 'Annesburg General Store',
  PromptName = 'Open Annesburg General Store',
  Coords = { x = 2926.08, y = 1364.88, z = 45.19, h = 348.32 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Annesburg General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_special_05' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedLibanyGeneralStore', {
  StoreName = 'Libany General Store',
  PromptName = 'Open Libany General Store',
  Coords = { x = -384.96, y = -138.49, z = 48.47, h = 335.47 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Libany General Store', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_special_05' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedGeneralStoreCategories,
  StoreProductsPackage = 'imported_general_store',
})

AddImportedCodexStore('ImportedMerchantStoreOne', {
  StoreName = 'Merchant Store',
  PromptName = 'Open Merchant Store',
  Coords = { x = 423.56, y = 418.91, z = 108.65, h = 147.72 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = false, Name = 'Merchant Store', Sprite = 'blip_ambient_tithing', Modifier = 'BLIP_MODIFIER_MP_COLOR_23', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_improved_02' },
  Hours = ImportedHours(true, 8, 21),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedMerchantStoreCategories,
  StoreProductsPackage = 'imported_merchant_store',
})

AddImportedCodexStore('ImportedMerchantStoreTwo', {
  StoreName = 'Merchant Store',
  PromptName = 'Open Merchant Store',
  Coords = { x = -1777.29, y = -391.62, z = 157.13, h = 314.55 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = false, Name = 'Merchant Store', Sprite = 'blip_ambient_tithing', Modifier = 'BLIP_MODIFIER_MP_COLOR_23', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_improved_02' },
  Hours = ImportedHours(true, 8, 21),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedMerchantStoreCategories,
  StoreProductsPackage = 'imported_merchant_store',
})

AddImportedCodexStore('ImportedSaintDenisMerchantStore', {
  StoreName = 'Saint Denis Merchant Store',
  PromptName = 'Open Saint Denis Merchant Store',
  Coords = { x = 2670.9, y = -1552.23, z = 46.52, h = 3.95 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Saint Denis Merchant Store', Sprite = 'blip_ambient_tithing', Modifier = 'BLIP_MODIFIER_MP_COLOR_23', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_u_m_m_buyer_improved_02' },
  Hours = ImportedHours(true, 8, 21),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedMerchantStoreCategories,
  StoreProductsPackage = 'imported_merchant_store',
})

AddImportedCodexStore('ImportedSaintDenisHerbalStore', {
  StoreName = 'Saint Denis Herbal Store',
  PromptName = 'Open Saint Denis Herbal Store',
  Coords = { x = 2586.28, y = -1010.73, z = 44.24, h = 283.5 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Saint Denis Herbal Store', Sprite = 'blip_summer_feed', Modifier = 'BLIP_MODIFIER_MP_COLOR_20', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'a_m_m_valfarmer_01' },
  Hours = ImportedHours(true, 8, 21),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedHerbalStoreCategories,
  StoreProductsPackage = 'imported_herbal_seed_store',
})

AddImportedCodexStore('ImportedHerbalStore', {
  StoreName = 'Herbal Store',
  PromptName = 'Open Herbal Store',
  Coords = { x = 472.27, y = 391.53, z = 108.37, h = 148.47 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Herbal Store', Sprite = 'blip_summer_feed', Modifier = 'BLIP_MODIFIER_MP_COLOR_20', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'a_m_m_valfarmer_01' },
  Hours = ImportedHours(true, 8, 21),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedHerbalStoreCategories,
  StoreProductsPackage = 'imported_herbal_seed_store',
})

AddImportedCodexStore('ImportedFishingStoreOne', {
  StoreName = 'Fishing Store',
  PromptName = 'Open Fishing Store',
  Coords = { x = -1198.91, y = -1939.81, z = 43.61, h = 93.56 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Fishing Store', Sprite = 'blip_shop_tackle', Modifier = 'BLIP_MODIFIER_MP_COLOR_21', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_dr_u_f_m_missingfisherman_01' },
  Hours = ImportedHours(true, 8, 21),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedFishingStoreCategories,
  StoreProductsPackage = 'imported_fishing_bait_store',
})

AddImportedCodexStore('ImportedFishingStoreTwo', {
  StoreName = 'Fishing Store',
  PromptName = 'Open Fishing Store',
  Coords = { x = -1311.87, y = 2480.31, z = 310.27, h = 80.5 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = true, Name = 'Fishing Store', Sprite = 'blip_shop_tackle', Modifier = 'BLIP_MODIFIER_MP_COLOR_21', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'mp_dr_u_f_m_missingfisherman_01' },
  Hours = ImportedHours(true, 8, 21),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedFishingStoreCategories,
  StoreProductsPackage = 'imported_fishing_bait_store',
})

AddImportedCodexStore('ImportedBlackmarket', {
  StoreName = 'Blackmarket',
  PromptName = 'Open Blackmarket',
  Coords = { x = 2665.06, y = -1227.81, z = 53.32, h = 186.41 },
  DistanceOpenStore = 2.0,
  BlipData = { Allowed = false, Name = 'Blackmarket', Sprite = 'blip_shop_store', Modifier = 'BLIP_MODIFIER_MP_COLOR_12', Scale = 0.2 },
  NPCData = { Allowed = true, Model = 'g_m_m_unibanditos_01' },
  Hours = ImportedHours(true, 8, 9),
  JobsData = { Allowed = false, Jobs = {} },
  Categories = importedBlackmarketCategories,
  StoreProductsPackage = 'imported_blackmarket_store',
})

Config.StoreProductPackages['imported_general_store'] = {
  ['buy'] = {
    { label = 'Campfire', item = 'campfire', currency = 'dollars', price = 4, category = 'tools' },
    { label = 'Glass Bottle', item = 'glassbottle', currency = 'dollars', price = 0.10, category = 'tools' },
    { label = 'Poster', item = 'poster', currency = 'dollars', price = 1, category = 'tools' },
    { label = 'Matches', item = 'matches', currency = 'dollars', price = 0.10, category = 'tools' },
    { label = 'Pomade', item = 'pomade', currency = 'dollars', price = 0.50, category = 'tools' },
    { label = 'Umbrella', item = 'umbrella', currency = 'dollars', price = 10, category = 'tools' },
    { label = 'Pickaxe', item = 'pickaxe', currency = 'dollars', price = 2.5, category = 'tools' },
    { label = 'Gold pan', item = 'goldpan', currency = 'dollars', price = 2.5, category = 'tools' },
    { label = 'Axe', item = 'axe', currency = 'dollars', price = 2.5, category = 'tools' },
    { label = 'Farming Tool', item = 'shovelgarden', currency = 'dollars', price = 1, category = 'tools' },
    { label = 'Watering Bucket', item = 'wateringbucket', currency = 'dollars', price = 1, category = 'tools' },
    { label = 'Fertilizer', item = 'fertilizer', currency = 'dollars', price = 0.40, category = 'tools' },
    { label = 'NoteBook', item = 'notebook', currency = 'dollars', price = 5, category = 'tools' },
    { label = 'Pen', item = 'pen', currency = 'dollars', price = 5, category = 'tools' },
    { label = 'Water', item = 'consumable_water_bottle', currency = 'dollars', price = 0.20, category = 'food' },
    { label = 'Bread', item = 'consumable_bread', currency = 'dollars', price = 0.20, category = 'food' },
  },
}

Config.StoreProductPackages['imported_merchant_store'] = {
  ['buy'] = {
    { label = 'Shellcasing', item = 'shellcasing', currency = 'dollars', price = 5, category = 'tools' },
    { label = 'Ammo Tip', item = 'ammotip', currency = 'dollars', price = 1, category = 'tools' },
    { label = 'Wheat Flour', item = 'consumable_wheat_floursack', currency = 'dollars', price = 0.50, category = 'tools' },
    { label = 'Butter', item = 'craft_butter', currency = 'dollars', price = 2, category = 'tools' },
    { label = 'Alcohol', item = 'consumable_alcohol', currency = 'dollars', price = 10, category = 'tools' },
    { label = 'Rolling Papers', item = 'rollingpaper', currency = 'dollars', price = 0.20, category = 'tools' },
    { label = 'Wrapper', item = 'wrapper', currency = 'dollars', price = 0.50, category = 'tools' },
    { label = 'Hammer', item = 'ironhammer', currency = 'dollars', price = 5, category = 'tools' },
    { label = 'Silver Hammer', item = 'ironhammer_repeater', currency = 'dollars', price = 10, category = 'tools' },
    { label = 'Iron Hammer', item = 'ironhammer_rifle', currency = 'dollars', price = 25, category = 'tools' },
    { label = 'Steel Hammer', item = 'ironhammer_shotgun', currency = 'dollars', price = 35, category = 'tools' },
    { label = 'Egg', item = 'craft_egg', currency = 'dollars', price = 1, category = 'tools' },
    { label = 'Milk', item = 'consumable_milk_bottle', currency = 'dollars', price = 1, category = 'tools' },
    { label = 'Empty Jar', item = 'empty_jar', currency = 'dollars', price = 0.10, category = 'goods' },
    { label = 'Apiary House', item = 'apiary_bee_house_gk_1', currency = 'dollars', price = 2, category = 'goods' },
    { label = 'Sponge', item = 'sponge', currency = 'dollars', price = 1, category = 'goods' },
    { label = 'Insect Medicine', item = 'insect_medicine', currency = 'dollars', price = 1, category = 'goods' },
  },
}

Config.StoreProductPackages['imported_herbal_seed_store'] = {
  ['buy'] = {
    { label = 'American Ginseng Seed', item = 'American_Ginseng_Seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Hop Seed', item = 'hop_seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Black Berry Seed', item = 'Black_Berry_Seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Coffee Seed', item = 'coffeeseeds', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Crows Garlic Seed', item = 'Crows_Garlic_Seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Indian Tobbaco Seed', item = 'Indian_Tobbaco_Seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Wild Carrot Seed', item = 'Wild_Carrot_Seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Yarrow Seed', item = 'Yarrow_Seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Corn Seed', item = 'cornseed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Apple Seed', item = 'Apple_Seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Sugarcane Seed', item = 'sugarcaneseed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Potato Seed', item = 'potatoseed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Cocoa Seed', item = 'cocoaseeds', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Peach Seed', item = 'peachseeds', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Tomato Seed', item = 'tomato_seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Grape Seed', item = 'grape_seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Pumpkin Seed', item = 'pumpkin_seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Wheat Seed', item = 'wheat_seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Wild Mint Seed', item = 'Wild_Mint_Seed', currency = 'dollars', price = 0.20, category = 'herbal' },
    { label = 'Onion Seed', item = 'onion_seed', currency = 'dollars', price = 0.20, category = 'herbal' },
  },
}

Config.StoreProductPackages['imported_fishing_bait_store'] = {
  ['buy'] = {
    { label = 'Bread Bait', item = 'p_baitBread01x', currency = 'dollars', price = 0.10, category = 'fishing' },
    { label = 'Corn Bait', item = 'p_baitCorn01x', currency = 'dollars', price = 0.10, category = 'fishing' },
    { label = 'Cheese Bait', item = 'p_baitCheese01x', currency = 'dollars', price = 0.10, category = 'fishing' },
    { label = 'Cricket Bait', item = 'p_baitCricket01x', currency = 'dollars', price = 0.10, category = 'fishing' },
    { label = 'Worm Bait', item = 'p_baitWorm01x', currency = 'dollars', price = 0.10, category = 'fishing' },
  },
}

Config.StoreProductPackages['imported_blackmarket_store'] = {
  ['buy'] = {
    { label = 'Shovel', item = 'shovel', currency = 'dollars', price = 50, category = 'tools' },
    { label = 'Lockpick', item = 'lockpick', currency = 'dollars', price = 35, category = 'tools' },
    { label = 'Dynamite', item = 'dynamite', currency = 'dollars', price = 50, category = 'tools' },
    { label = 'Vault Key', item = 'vault_key', currency = 'dollars', price = 25, category = 'tools' },
  },
}

-----------------------------------------------------------
--[[ Notification Functions ]]--
-----------------------------------------------------------

function SendNotification(source, message, notificationType)
    if not message then return end

    local duration = 3000
    local notifyType = notificationType or 'inform'

    if source and tonumber(source) and tonumber(source) > 0 then
        TriggerClientEvent('codex-core:notification', source, message, duration, notifyType)
        return
    end

    TriggerEvent('codex-core:notification', message, duration, notifyType)
end
