CrestLogic = CrestLogic or {}

-- Get localized strings
local L = CrestTracker_Locale.GetLocalizedStrings()


function CrestLogic.UpdateCrestCounts(crestTypes, crestMax, trackMax, itemNeeds, crestFrames, Panel)
    for key in pairs(itemNeeds) do
        itemNeeds[key] = 0
    end
    
    if not Panel then return end
    
    for slot = 1, 17 do
        local itemLink = GetInventoryItemLink("player", slot)
        if itemLink then
            GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
            GameTooltip:SetHyperlink(itemLink)
    
            local seasonTextFound = false
            for i = 1, GameTooltip:NumLines() do
                local line = _G["GameTooltipTextLeft" .. i]:GetText()
                if line and string.find(line, L["SEASON_ONE"]) then
                    seasonTextFound = true
                    break
                end
            end
    
            if not seasonTextFound then
                local upgradeInfo = C_Item.GetItemUpgradeInfo(itemLink)
                if upgradeInfo then
                    local _, _, _, itemLevel = C_Item.GetItemInfo(itemLink)
                    if not itemLevel then
                        itemLevel = select(4, C_Item.GetItemInfo(itemLink)) or 0
                    end
                    local itemTrack = upgradeInfo.trackString

                    if itemTrack == L["VETERAN"] then
                        if itemLevel < crestMax["Weathered"] then
                            local upgradesNeeded = math.ceil((crestMax["Weathered"] - itemLevel) / 3)
                            local deficit = 15 * upgradesNeeded
                            if deficit > 0 then
                                itemNeeds[L["WEATHERED_CREST"]] = itemNeeds[L["WEATHERED_CREST"]] + deficit
                            end
                            itemNeeds[L["CARVED_CREST"]] = itemNeeds[L["CARVED_CREST"]] + 60
                        else
                            if itemLevel < trackMax["Veteran"] then
                                if itemLevel == crestMax["Weathered"] then
                                    itemNeeds[L["CARVED_CREST"]] = itemNeeds[L["CARVED_CREST"]] + 60
                                else
                                    local upgradesNeeded = math.ceil((trackMax["Veteran"] - itemLevel) / 3)
                                    local deficit = 15 * upgradesNeeded
                                    if deficit > 0 then
                                        itemNeeds[L["CARVED_CREST"]] = itemNeeds[L["CARVED_CREST"]] + deficit
                                    end
                                end
                            end
                        end
                    elseif itemTrack == L["CHAMPION"] then
                        if itemLevel < crestMax["Carved"] then
                            local upgradesNeeded = math.ceil((crestMax["Carved"] - itemLevel) / 3)
                            local deficit = 15 * upgradesNeeded
                            if deficit > 0 then
                                itemNeeds[L["CARVED_CREST"]] = itemNeeds[L["CARVED_CREST"]] + deficit
                            end
                            itemNeeds[L["RUNED_CREST"]] = itemNeeds[L["RUNED_CREST"]] + 60
                        else
                            if itemLevel < trackMax["Champion"] then
                                if itemLevel == crestMax["Carved"] then
                                    itemNeeds[L["RUNED_CREST"]] = itemNeeds[L["RUNED_CREST"]] + 60
                                else
                                    local upgradesNeeded = math.ceil((trackMax["Champion"] - itemLevel) / 3)
                                    local deficit = 15 * upgradesNeeded
                                    if deficit > 0 then
                                        itemNeeds[L["RUNED_CREST"]] = itemNeeds[L["RUNED_CREST"]] + deficit
                                    end
                                end
                            end
                        end
                    elseif itemTrack == L["HERO"] then
                        if itemLevel < crestMax["Runed"] then
                            local upgradesNeeded = math.ceil((crestMax["Runed"] - itemLevel) / 3)
                            local deficit = 15 * upgradesNeeded
                            if deficit > 0 then
                                itemNeeds[L["RUNED_CREST"]] = itemNeeds[L["RUNED_CREST"]] + deficit
                            end
                            itemNeeds[L["GILDED_CREST"]] = itemNeeds[L["GILDED_CREST"]] + 30
                        else
                            if itemLevel < trackMax["Hero"] then
                                if itemLevel == crestMax["Runed"] then
                                    itemNeeds[L["GILDED_CREST"]] = itemNeeds[L["GILDED_CREST"]] + 30
                                else
                                    local upgradesNeeded = math.ceil((trackMax["Hero"] - itemLevel) / 3)
                                    local deficit = 15 * upgradesNeeded
                                    if deficit > 0 then
                                        itemNeeds[L["GILDED_CREST"]] = itemNeeds[L["GILDED_CREST"]] + deficit
                                    end
                                end
                            end
                        end
                    elseif itemTrack == L["MYTH"] then
                        if itemLevel < 678 then
                            local upgradesNeeded = math.ceil((678 - itemLevel) / 3)
                            local deficit = 15 * upgradesNeeded
                            if deficit > 0 then
                                itemNeeds[L["GILDED_CREST"]] = itemNeeds[L["GILDED_CREST"]] + deficit
                            end
                        end
                    end
                end
            end
        end
    end

    for i, crestType in ipairs(crestTypes) do
        local info = C_CurrencyInfo.GetCurrencyInfo(crestType.id)
        if info then
            crestType.quantity = info.quantity
            crestType.icon = info.iconFileID
    
            local frame = crestFrames[i]
            if frame then
                if frame.currentLabel and frame.neededLabel then
                    local needed = itemNeeds[crestType.name] or 0
                    local current = crestType.quantity or 0
                    local deficit = needed - current
                    
                    -- Set current amount text
                    frame.currentLabel:SetText(L["CURRENT"] .. " " .. tostring(current))
                    
                    -- Set needed amount text
                    if deficit <= 0 then
                        frame.neededLabel:SetText(L["DONE"])
                    else
                        frame.neededLabel:SetText(L["STILL_NEEDED"] .. " " .. tostring(deficit))
                    end
                end
                if frame.iconTexture then
                    frame.iconTexture:SetTexture(crestType.icon)
                end
            end
        end
    end
end