--
-- © Copyright George Taray 2018+ except where explicitly stated otherwise.
-- Fantasy Grounds is Copyright © 2004-2014 SmiteWorks USA LLC.
-- Copyright to other material within this file may be held by other Individuals and/or Entities.
-- Nothing in or from this LUA file in printed, electronic and/or any other form may be used, copied,
--	transmitted or otherwise manipulated in ANY way without the explicit written consent of
--	George Taray or, where applicable, any and all other Copyright holders.
--

aListViews = {
    ["item"] = {
		["armor"] = {
			sTitleRes = "item_grouped_title_armor",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "item_grouped_label_name", nWidth=150 },
				{ sName = "cost", sType = "string", sHeadingRes = "item_grouped_label_cost", bCentered=true },
				{ sName = "ac", sType = "number", sHeadingRes = "item_grouped_label_ac", sTooltipRes = "item_grouped_tooltip_ac", nWidth=40, bCentered=true, nSortOrder=1 },
                -- { sName = "dexbonus", sType = "string", sHeadingRes = "item_grouped_label_dexbonus", sTooltipRes = "item_grouped_tooltip_dexbonus", nWidth=70, bCentered=true },
				{ sName = "frame", sType = "string", sHeadingRes = "item_grouped_label_frame", bCentered=true },
				{ sName = "maxdurability", sType = "string", sHeadingRes = "item_grouped_label_durability", nWidth=60, bCentered=true },
				{ sName = "strength", sType = "string", sHeadingRes = "item_grouped_label_strength", bCentered=true },
				{ sName = "properties", sType = "string", sHeadingRes = "item_grouped_label_properties", nWidth=100, bCentered=true },
				{ sName = "weight", sType = "number", sHeadingRes = "item_grouped_label_weight", sTooltipRes = "item_grouped_tooltip_weight", nWidth=30, bCentered=true }
			},
			aFilters = { 
				{ sDBField = "type", vFilterValue = "Armor" }, 
				{ sCustom = "item_isidentified" } 
			},
			aGroups = { { sDBField = "subtype" } },
			aGroupValueOrder = { "Light Armor", "Medium Armor", "Heavy Armor", "Shield" },
		},
		["weapon"] = {
			sTitleRes = "item_grouped_title_weapons",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "item_grouped_label_name", nWidth=150 },
				{ sName = "cost", sType = "string", sHeadingRes = "item_grouped_label_cost", bCentered=true },
				{ sName = "damage", sType = "string", sHeadingRes = "item_grouped_label_damage", nWidth=150, bCentered=true },
				{ sName = "maxdurability", sType = "string", sHeadingRes = "item_grouped_label_durability", nWidth=60, bCentered=true },
				{ sName = "weight", sType = "number", sHeadingRes = "item_grouped_label_weight", sTooltipRes = "item_grouped_tooltip_weight", nWidth=30, bCentered=true },
				{ sName = "properties", sType = "string", sHeadingRes = "item_grouped_label_properties", nWidth=300, bWrapped=true },
			},
			aFilters = { 
				{ sDBField = "type", vFilterValue = "Weapon" }, 
				{ sCustom = "item_isidentified" } 
			},
			aGroups = { { sDBField = "subtype" } },
			aGroupValueOrder = { "Simple Melee Weapons", "Simple Ranged Weapons", "Martial Weapons", "Martial Melee Weapons", "Martial Ranged Weapons" },
		},
    }
}

function onInit()
    for kRecordType,vRecordListViews in pairs(aListViews) do
        for kListView, vListView in pairs(vRecordListViews) do
			LibraryData.setListView(kRecordType, kListView, vListView);
		end
	end
	LibraryData.setRecordTypeInfo("vehicle", nil);

	GameSystem.actions["durability"] = { bUseModStack = true };
end