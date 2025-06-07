TooltipUtils = {}

-- Get localized strings
local L = CrestTracker_Locale.GetLocalizedStrings()

-- Get player's class color
local _, className = UnitClass("player")
local classColor = RAID_CLASS_COLORS[className]
local classR, classG, classB = classColor.r, classColor.g, classColor.b

function TooltipUtils.GenerateTooltip(crestName, deficit, ACTIVITY_REWARDS)
    GameTooltip:AddLine(L["EARN_FROM"], 1, 1, 1)

    local lastSource = nil
    for _, sourceInfo in ipairs(ACTIVITY_REWARDS[crestName]) do
        if sourceInfo.source ~= lastSource then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(sourceInfo.source, 1, 0.82, 0)
            lastSource = sourceInfo.source
        end

        if sourceInfo.tiers then
            for _, tier in ipairs(sourceInfo.tiers) do
                local activitiesNeeded = math.ceil(deficit / tier.reward)
                local displayText = string.format(sourceInfo.text, activitiesNeeded, tier.range)
                GameTooltip:AddLine("• " .. displayText, classR, classG, classB)
                GameTooltip:AddLine(string.format(L["EACH"], tier.reward), 0.7, 0.7, 0.7)
            end
        else
            local activitiesNeeded = math.ceil(deficit / sourceInfo.reward)
            GameTooltip:AddLine("• " .. string.format(sourceInfo.text, activitiesNeeded), classR, classG, classB)
            GameTooltip:AddLine(string.format(L["EACH"], sourceInfo.reward), 0.7, 0.7, 0.7)
        end
    end
end

return TooltipUtils