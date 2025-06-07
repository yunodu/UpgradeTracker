CrestData = {}

-- Get localized strings
local L = CrestTracker_Locale.GetLocalizedStrings()

CrestData.crestTypes = {
    { name = L["WEATHERED_CREST"], icon = "", id = 3107, quantity = 0},
    { name = L["CARVED_CREST"], icon = "", id = 3108, quantity = 0},
    { name = L["RUNED_CREST"], icon = "", id = 3109 , quantity = 0},
    { name = L["GILDED_CREST"], icon = "", id = 3110  , quantity = 0}
}

CrestData.crestMax = {
    ["Weathered"] = 632,
    ["Carved"] = 645,
    ["Runed"] = 658,
    ["Gilded"] = 684,
}


CrestData.trackMax = {
    ["Veteran"] = 645,
    ["Champion"] = 658,
    ["Hero"] = 671,
    ["Myth"] = 684,
}

CrestData.ACTIVITY_REWARDS = {
    [L["WEATHERED_CREST"]] = {
        {
            source = L["DEVLE"], 
            tiers = {
                { range = "1-5", reward = 10 },
            },
            text = L["DELVES"]
        },
        { source = L["HEROIC_DUNGEON"], reward = 1, text = L["H_DUNGEON_KILLS"] },
        { source = "LFR", reward = 15, text = L["LFR_BOSSES"] }
    },
    [L["CARVED_CREST"]] = {
        {
            source = L["DEVLE"], 
            tiers = {
                { range = "6-7", reward = 10 },
            },
            text = L["DELVES"]
        },
        { source = "M 0", reward = 15, text = L["MYTHIC_0"] },
        { source = L["NORMAL_RAID_BOSS"], reward = 15, text = L["NORMAL_BOSSES"] }
    },
    [L["RUNED_CREST"]] = {
        {
            source = L["DEVLE"], 
            tiers = {
                { range = "8-11", reward = 10 },
            },
            text = L["DELVES"]
        },
        {
            source = L["MYTHIC"], 
            tiers = {
                { range = "2", reward = 10 },
                { range = "3", reward = 12 },
                { range = "4", reward = 14 },
                { range = "5", reward = 16 },
                { range = "6", reward = 18 }
            },
            text = L["MYTHIC_PLUS"]
        },
        { source = L["HEROIC_RAID_BOSS"], reward = 15, text = L["HEROIC_BOSSES"] },
    },
    [L["GILDED_CREST"]] = {
        {
            source = L["MYTHIC"], 
            tiers = {
                { range = "7", reward = 10 },
                { range = "8", reward = 12 },
                { range = "9", reward = 14 },
                { range = "10", reward = 16 },
                { range = "11", reward = 18 },
                { range = "12", reward = 20 },
            },
            text = L["MYTHIC_PLUS"]
        },
        { source = L["MYTHIC_RAID_BOSS"], reward = 15, text = L["MYTHIC_BOSSES"] },
    }
}

return CrestData