local map = {
	["Middle Mouse"] = "M3",
	["Mouse Wheel Down"] = "DWN",
	["Mouse Wheel Up"] = "UP",
	["Home"] = "Hm",
	["Insert"] = "Ins",
	["Page Down"] = "PD",
	["Page Up"] = "PU",
	["Spacebar"] = "SpB",
	["Num Pad 0"] = "N0",
	["Num Pad 1"] = "N1",
	["Num Pad 2"] = "N2",
	["Num Pad 3"] = "N3",
	["Num Pad 4"] = "N4",
	["Num Pad 5"] = "N5",
	["Num Pad 6"] = "N6",
	["Num Pad 7"] = "N7",
	["Num Pad 8"] = "N8",
	["Num Pad 9"] = "N9",
	["Num Pad ."] = "N.",
	["Num Pad /"] = "N/",
	["Num Pad *"] = "N*",
	["Num Pad -"] = "N-",
	["Num Pad +"] = "N+",
	["Left Button"] = "M1",
	["Right Button"] = "M2",
}

local patterns = {
	["Mouse Wheel Down"] = "MwD",
	["Mouse Wheel Up"] = "MwU",
	["Mouse Button "] = "M", -- M4, M5
	["Num Pad "] = "N",
	["a%-"] = "A", -- alt
	["c%-"] = "C", -- ctrl
	["s%-"] = "S", -- shift
	["Middle Mouse"] = "M3",
	["Left Button"] = "M1",
	["Right Button"] = "M2",
}

local bars = {
	"ActionButton",
	"MultiBarBottomLeftButton",
	"MultiBarBottomRightButton",
	"MultiBarLeftButton",
	"MultiBarRightButton",
	"MultiBar5Button",
	"MultiBar6Button",
	"MultiBar7Button",
}

local function ShortenModifiers(text)
	return text:gsub("ALT%-", "A-"):gsub("CTRL%-", "C-"):gsub("SHIFT%-", "S-")
end

local function UpdateHotkey(self, actionButtonType)
	local hotkey = self.HotKey
	local text = hotkey:GetText()

	if text then
		-- First, shorten modifiers
		text = ShortenModifiers(text)

		-- Then apply patterns
		for k, v in pairs(patterns) do
			text = text:gsub(k, v)
		end

		-- Finally, apply specific mappings
		text = map[text] or text

		hotkey:SetText(text)
	end
end

for _, bar in pairs(bars) do
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		hooksecurefunc(_G[bar .. i], "UpdateHotkeys", UpdateHotkey)
	end
end
