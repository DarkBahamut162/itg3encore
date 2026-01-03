local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

function IsAutoPlayMode(check)
	local AutoMode = ""
	if ThemePrefs.Get("AutoPlayMode") then
		if check then return true end
		AutoMode = addToOutput(AutoMode,"Auto Play Mode: "..ThemePrefs.Get("AutoPlayMode"),"\n")
	end
	if check then return false else return AutoMode end
end

function IsAutoStyle()
	local AutoStyle = ""
	if IsGame("dance") and ThemePrefs.Get("AutoStyleDance") then
		return true
	elseif IsGame("groove") and ThemePrefs.Get("AutoStyleGroove") then
		return true
	elseif IsGame("solo") and ThemePrefs.Get("AutoStyleSolo") then
		return true
	elseif IsGame("pump") and ThemePrefs.Get("AutoStylePump") then
		return true
	elseif IsGame("smx") and ThemePrefs.Get("AutoStyleSmx") then
		return true
	elseif IsGame("be-mu") and ThemePrefs.Get("AutoStyleBeMu") then
		return true
	elseif IsGame("beat") and ThemePrefs.Get("AutoStyleBeat") then
		return true
	elseif IsGame("po-mu") and ThemePrefs.Get("AutoStylePoMu") then
		return true
	elseif IsGame("popn") and ThemePrefs.Get("AutoStylePopn") then
		return true
	elseif IsGame("rechno") and ThemePrefs.Get("AutoStyleTechno") then
		return true
	end
	return false
end

function GetAutoPlayMode()
	local AutoMode = ThemePrefs.Get("AutoPlayMode")
	if AutoMode and IsAutoStyle() then
		if AutoMode == "dance" then
			return "name,Dance;style,"..split(",",GetAutoStyle())[1]..";difficulty,medium;screen,ScreenProfileLoad"
		elseif AutoMode == "battle" then
			return "name,Battle;style,"..split(",",GetAutoStyle())[1]..";difficulty,medium;playmode,"..split(",",GetAutoStyle())[2]..";screen,ScreenProfileLoad"
		elseif AutoMode == "marathon" then
			return "name,Marathon;playmode,nonstop;style,"..split(",",GetAutoStyle())[1]..";difficulty,medium;screen,ScreenProfileLoad"
		elseif AutoMode == "survival" then
			return "name,Survival;playmode,oni;mod,lifetime;style,"..split(",",GetAutoStyle())[1]..";difficulty,medium;screen,ScreenProfileLoad"
		elseif AutoMode == "fitness" then
			return "name,Fitness;style,"..split(",",GetAutoStyle())[1]..";difficulty,medium;screen,ScreenProfileLoad;setenv,Workout,true"
		end
	else
		return "screen,"..Branch.StartGame()
	end
end

function GetAutoStyle()
	if IsGame("dance") then
		return ThemePrefs.Get('AutoStyleDance')..","..ThemePrefs.Get('AutoBattle')
	elseif IsGame("groove") then
		return ThemePrefs.Get('AutoStyleGroove')..","..ThemePrefs.Get('AutoBattle')
	elseif IsGame("solo") then
		return ThemePrefs.Get('AutoStyleSolo')..","..ThemePrefs.Get('AutoBattle')
	elseif IsGame("pump") then
		return ThemePrefs.Get('AutoStylePump')..","..ThemePrefs.Get('AutoBattle')
	elseif IsGame("smx") then
		return ThemePrefs.Get('AutoStyleSmx')..","..ThemePrefs.Get('AutoBattle')
	elseif IsGame("be-mu") then
		return ThemePrefs.Get('AutoStyleBeMu')..","..ThemePrefs.Get('AutoBattle')
	elseif IsGame("beat") then
		return ThemePrefs.Get('AutoStyleBeat')..","..ThemePrefs.Get('AutoBattle')
	elseif IsGame("po-mu") then
		return ThemePrefs.Get('AutoStylePoMu')..","..ThemePrefs.Get('AutoBattle')
	elseif IsGame("popn") then
		return ThemePrefs.Get('AutoStylePopn')..","..ThemePrefs.Get('AutoBattle')
	elseif IsGame("rechno") then
		return ThemePrefs.Get('AutoStyleTechno')..","..ThemePrefs.Get('AutoBattle')
	end
	return ""
end

function GetAutoStyleMenu()
	if IsGame("dance") then
		return ",AutoStyleDance,AutoBattle"
	elseif IsGame("groove") then
		return ",AutoStyleGroove,AutoBattle"
	elseif IsGame("solo") then
		return ",AutoStyleSolo,AutoBattle"
	elseif IsGame("pump") then
		return ",AutoStylePump,AutoBattle"
	elseif IsGame("smx") then
		return ",AutoStyleSmx,AutoBattle"
	elseif IsGame("be-mu") then
		return ",AutoStyleBeMu,AutoBattle"
	elseif IsGame("beat") then
		return ",AutoStyleBeat,AutoBattle"
	elseif IsGame("po-mu") then
		return ",AutoStylePoMu,AutoBattle"
	elseif IsGame("popn") then
		return ",AutoStylePopn,AutoBattle"
	elseif IsGame("rechno") then
		return ",AutoStyleTechno,AutoBattle"
	end
	return ""
end

function AutoPlayMode(value)
	local Choices = {"None"}
	local Values = {nil}

	Values[#Choices+1]="dance"
	Choices[#Choices+1]="Dance"
	Values[#Choices+1]="battle"
	Choices[#Choices+1]="Battle"
	Values[#Choices+1]="marathon"
	Choices[#Choices+1]="Marathon"
	Values[#Choices+1]="survival"
	Choices[#Choices+1]="Survival"
	Values[#Choices+1]="fitness"
	Choices[#Choices+1]="Fitness"

	if value then return Values else return Choices end
end

function AutoStyle(value)
	local Choices = {"None"}
	local Values = {nil}

	for choice in ivalues(ChoiceSingle()) do
		if choice then
			local upper = ""
			for word in ivalues(split("-",choice)) do upper = upper .. string.gsub(" "..word, "%W%l", string.upper):sub(2) end
			Values[#Choices+1]=choice
			Choices[#Choices+1]=upper
		end
	end
	for choice in ivalues(ChoiceVersus()) do
		if choice then
			local upper = ""
			for word in ivalues(split("-",choice)) do upper = upper .. string.gsub(" "..word, "%W%l", string.upper):sub(2) end
			Values[#Choices+1]=choice
			Choices[#Choices+1]=upper
		end
	end
	for choice in ivalues(ChoiceDouble()) do
		if choice then
			local upper = ""
			for word in ivalues(split("-",choice)) do upper = upper .. string.gsub(" "..word, "%W%l", string.upper):sub(2) end
			Values[#Choices+1]=choice
			Choices[#Choices+1]=upper
		end
	end

	if value then return Values else return Choices end
end

local Prefs = {
	--[Global]
	EncoreThemeMode = {
		Default = false,
		Choices = { OptionNameString('Normal'), OptionNameString('Final') },
		Values = { false, true }
	},
	ExperimentalProfileLevel = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	KeyboardEnabled = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	MouseEnabled = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
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
	TrueRounds = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	UseStepCache = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	--[ScreenTitleMenu]
	AllowBattle = {
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	AllowMarathon = {
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	AllowSurvival = {
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	AllowFitness = {
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	AllowJukebox = {
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	AllowEdit = {
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	AllowRecords = {
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	--[ScreenTitleJoin]
	AutoPlayMode = {
		Default = false,
		Choices = AutoPlayMode(false),
		Values = AutoPlayMode(true)
	},
	--[ScreenSelectStyle]
	AutoStyleDance = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	AutoStyleGroove = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	AutoStyleSolo = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	AutoStylePump = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	AutoStyleSmx = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	AutoStyleBeMu = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	AutoStyleBeat = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	AutoStylePoMu = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	AutoStylePopn = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	AutoStyleTechno = {
		Default = false,
		Choices = AutoStyle(false),
		Values = AutoStyle(true)
	},
	--[ScreenSelectNumPlayers]
	AutoBattle = {
		Default = "rave",
		Choices = { "Rave", "Battle" },
		Values = { "rave", "battle" }
	},
	--[ScreenSelectMusic]
	MusicWheelStyle = {
		Default = "ITG",
		Choices = { "ITG", "IIDX" }
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
	ShowCalcDiffDecimals = {
		Default = 0,
		Choices = { "0", "1", "2" },
		Values = { 0, 1, 2 }
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
	ShowOrigin = {
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
	ShowTechCounter = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowTime = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	--[ScreenPlayerOptions]
	SplitOptions = {
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	--[ScreenGameplay]
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
	ShowGameplaySeconds = {
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
	ShowSurvivedTime = {
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