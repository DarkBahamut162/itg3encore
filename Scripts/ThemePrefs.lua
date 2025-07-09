local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

local Prefs = {
	--[Global]
	EncoreThemeMode = {
		Default = false,
		Choices = { OptionNameString('Normal'), OptionNameString('Final') },
		Values = { false, true }
	},
	ShowClock = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	SLFavorites = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	UseStepCache = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	--[ScreenSelectMusic]
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
		Choices = { "Old", "New" },
		Values = { false, true }
	},
	ShowGraph = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowHasLua = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowMODDisplay = {
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
	--{ScreenGameplay}
	AnimatePlayerScore = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	AnimateSongTitle = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowGameplaySpeed = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	--[ScreenEvaluation]
	ShowOffset = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	--[ScreenSummary]
	ShowSummary = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowSummarySummary = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	}
}

ThemePrefs.InitAll(Prefs)