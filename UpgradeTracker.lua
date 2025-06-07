-- Get localized strings
local L = CrestTracker_Locale.GetLocalizedStrings()

local crestTypes = CrestData.crestTypes
local crestMax = CrestData.crestMax
local trackMax = CrestData.trackMax
local ACTIVITY_REWARDS = CrestData.ACTIVITY_REWARDS

-- Initialize itemNeeds based on crestTypes to ensure keys match exactly
local itemNeeds = {}
for _, crestType in ipairs(crestTypes) do
    itemNeeds[crestType.name] = 0
end

local crestFrames, Tab, Panel, TabName, TabID = UISetup.InitializeUI(crestTypes, itemNeeds, function(crestName, deficit)
    TooltipUtils.GenerateTooltip(crestName, deficit, ACTIVITY_REWARDS)
end)

TabHandler.AddTabTooltip(Tab, L["CRESTS"])

local function UpdateCrestCounts()
    CrestLogic.UpdateCrestCounts(crestTypes, crestMax, trackMax, itemNeeds, crestFrames, Panel)
end

local f = CreateFrame("Frame")
EventHandler.RegisterEvents(f, UpdateCrestCounts)

Tab:SetScript("OnClick", function()
    TabHandler.HandleTabClick(TabName, TabID, Panel, UpdateCrestCounts)
end)