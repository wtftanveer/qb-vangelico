Config = Config or {}

------ / These are the only working Dispatch Systems that are in place for the alert, however more can be added!
------ / "Core" / "Linden" / "DP"
--Config.Dispatch = "Linden" ------ / THIS IS COMING SOON! NEED TO ADD THE OTHER EXPORTS

------ / Police Required To Start Heist
Config.RequiredCops = 0

------ / Set CoolDown Between Each Of Heist JewelLocation
Config.Cooldown = 360

------ / Set CoolDown For VitrineCases (Prevents Spam Looting) | This Prevents people from "scuffing" inside and taking loot
Config.Timeout = 90 * (60 * 1000)

------ / Set Door ID For NUI Door Lock | Currently Setup For Linden (More Coming Soon)
Config.DispatchSystem = "LINDEN"

------ / Hack The Security System / Laptop Minigame
Config.VangelicoTime = 15
Config.VangelicoBlocks = 4
Config.VangelicoRepeat = 2

------ / Destroy The Security System / Thermite Minigame
Config.CorrectBlocks = 16 
Config.IncorrectBlocks = 3 
Config.TimeToShow = 4 
Config.TimeToLose = 30

------ / Heist Locations (HackSecurity = Roof Of Vangelico | DisableCameras = Inside Vangelico)
Config.JewelLocation = {
    ["HackSecurity"] = {
        x = -595.8919,
        y = -283.6023,
        z = 50.3237,
        isDone = false,
        isBusy = false,
    },
    ["DisableCameras"] = {
        x = -632.05,
        y = -235.00,
        z = 38.05,
        isDone = false,
        isBusy = false,
    },
}

------ / Set Location Of Each Vitrine Case
Config.Locations = {
    [1] = {
        ["coords"] = {
            ["x"] = -626.83, 
            ["y"] = -235.35, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [2] = {
        ["coords"] = {
            ["x"] = -625.81, 
            ["y"] = -234.7, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [3] = {
        ["coords"] = {
            ["x"] = -626.95, 
            ["y"] = -233.14, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [4] = {
        ["coords"] = {
            ["x"] = -628.0, 
            ["y"] = -233.86, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [5] = {
        ["coords"] = {
            ["x"] = -625.7, 
            ["y"] = -237.8, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [6] = {
        ["coords"] = {
            ["x"] = -626.7, 
            ["y"] = -238.58, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [7] = {
        ["coords"] = {
            ["x"] = -624.55, 
            ["y"] = -231.06, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [8] = {
        ["coords"] = {
            ["x"] = -623.13, 
            ["y"] = -232.94, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [9] = {
        ["coords"] = {
            ["x"] = -620.29, 
            ["y"] = -234.44, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [10] = {
        ["coords"] = {
            ["x"] = -619.15, 
            ["y"] = -233.66, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [11] = {
        ["coords"] = {
            ["x"] = -620.19, 
            ["y"] = -233.44, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [12] = {
        ["coords"] = {
            ["x"] = -617.63, 
            ["y"] = -230.58, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [13] = {
        ["coords"] = {
            ["x"] = -618.33, 
            ["y"] = -229.55, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [14] = {
        ["coords"] = {
            ["x"] = -619.7, 
            ["y"] = -230.33, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [15] = {
        ["coords"] = {
            ["x"] = -620.95, 
            ["y"] = -228.6, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [16] = {
        ["coords"] = {
            ["x"] = -619.79, 
            ["y"] = -227.6, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [17] = {
        ["coords"] = {
            ["x"] = -620.42, 
            ["y"] = -226.6, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [18] = {
        ["coords"] = {
            ["x"] = -623.94, 
            ["y"] = -227.18, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [19] = {
        ["coords"] = {
            ["x"] = -624.91, 
            ["y"] = -227.87, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [20] = {
        ["coords"] = {
            ["x"] = -623.94, 
            ["y"] = -228.05, 
            ["z"] = 38.05,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }
}

------- / Add Weapons Here That You Want To Be Able To Smash The Vitrine Cases
Config.WhitelistedWeapons = {

    -- Melee

    [GetHashKey("weapon_hammer")] = {
        ["timeOut"] = 12000
    },

    -- Pistols

    [GetHashKey("weapon_pistol")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_snspistol")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_heavypistol")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_pistol50")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_machinepistol")] = {
        ["timeOut"] = 12000
    },

    -- Small Machine Guns

    [GetHashKey("weapon_assaultsmg")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_microsmg")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_minismg")] = {
        ["timeOut"] = 12000
    },

    -- Light Machine Guns

    -- Assault Rifles
    [GetHashKey("weapon_assaultrifle")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_specialcarbine")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_gusenberg")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_advancedrifle")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_bullpuprifle")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_carbinerifle")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_compactrifle")] = {
        ["timeOut"] = 12000
    },
}

------ / Items Inside Vitrine Cases
Config.VitrineRewards = {
    [1] = {
        ["item"] = "rolex",
        ["amount"] = {
            ["min"] = 10,
            ["max"] = 15
        },
    },
    [2] = {
        ["item"] = "diamond_ring",
        ["amount"] = {
            ["min"] = 10,
            ["max"] = 25
        },
    },
    [3] = {
        ["item"] = "goldchain",
        ["amount"] = {
            ["min"] = 10,
            ["max"] = 15
        },
    },
}

------ / Blip Location On The Map | Minimap
Config.JewelleryLocation = {
    ["coords"] = {
        ["x"] = -630.5,
        ["y"] = -237.13,
        ["z"] = 38.08,
    }
}

------ / Set Gloves For Male and Female For Chance Of Fingerprints
Config.MaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true
}

Config.FemaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true
}