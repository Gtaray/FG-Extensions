-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

local TARGET_DEFAULT = 12
local TARGET_MINIMUM = 9
local TARGET_MAXIMUM = 35

local ROOM_KEYPATH = "room"
local TARGET_KEYPATH = ROOM_KEYPATH .. ".target"

function onInit()
	initializeBackingStore()
	changeRoomTargetPicture(DB.getValue(TARGET_KEYPATH))
end

function initializeBackingStore()
	local target = DB.getValue(TARGET_KEYPATH)
	if User.isHost() and target == nil then
		DB.setValue(TARGET_KEYPATH, "number", TARGET_DEFAULT)
		DB.setPublic(ROOM_KEYPATH, true)
	end

	DB.addHandler(TARGET_KEYPATH, "onUpdate", onTargetChanged)
end

function onWheel(notches)
	local target = DB.getValue(TARGET_KEYPATH)
	target = math.min(math.max(TARGET_MINIMUM, target + notches), TARGET_MAXIMUM)
	DB.setValue(TARGET_KEYPATH, "number", target)
end

function onTargetChanged(node)
	changeRoomTargetPicture(node.getValue())
end

function changeRoomTargetPicture(target)
	if target then
		local iconName = string.format("room_target_%d", target)
		window.room_target.setIcon(iconName)
	end
end
