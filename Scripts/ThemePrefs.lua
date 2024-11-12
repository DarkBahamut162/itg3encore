local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

local Prefs = {
	EncoreThemeMode = {
		Default = false,
		Choices = { OptionNameString('Normal'), OptionNameString('Final') },
		Values = { false, true }
	},
	ShowBPMDisplayType = {
		Default = 0,
		Choices = { "DisplayBPM", "ActualBPM", "CalculatedBPM" },
		Values = { 0, 1, 2 }
	},
	ShowCalcDiff = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	DanceDifficultyType = {
		Default = true,
		Choices = { "Old", "X-Scale" },
		Values = { false, true }
	},
	ShowClock = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowHasLua = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowOffset = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowRounds = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowStepCounter = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	SLFavorites = {
		Default = 0,
		Choices = isOutFoxV043() and { "Off", "SL", "OF" } or { "Off", "OF" },
		Values = isOutFoxV043() and { 0, 1, 2 } or { 0, 2 }
	}
}

ThemePrefs.InitAll(Prefs)