function LoadKeymapFile()
	if not FILEMAN:DoesFileExist("Save/Keymaps.ini") then return {} end

	local configfile = RageFileUtil.CreateRageFile()
	configfile:Open("Save/Keymaps.ini", 1)

	local configcontent = configfile:Read()

	configfile:Close()
	configfile:destroy()

	return configcontent
end

function SetupKeymapArray()
	local keys = split("\n",LoadKeymapFile():gsub("%\r", ""))
	local KeyMaps = {}
	local group = ""

	for key in ivalues(keys) do
		if string.find(key,"%[") and string.find(key,"%]") then
			group = key:match("%[(.*)%]")
			KeyMaps[group] = {}
		elseif string.len(key) > 0 then
			local splitted = split("=",key)
			splitted[2] = split(":",splitted[2])
			KeyMaps[group][splitted[1]] = splitted[2]
		end
	end

	return KeyMaps
end

function keyMapped(key)
	for i = 1,#key do
		if key[i] and key[i] ~= "" then return true end
	end
	return false
end

function ChoiceSingle()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox() then
			return {"single","solo","threepanel"}
		else
			return {"single"}
		end
	elseif IsGame("pump") then
		return {"single"}
	elseif IsGame("smx") then
		return {"single"}
	elseif IsGame("be-mu") or IsGame("beat") then
		if isOutFox() then
			return {"single5","single6","single7"}
		else
			return {"single5","single7"}
		end
	elseif IsGame("po-mu") then
		return {"po-mu-three","po-mu-four","po-mu-five","po-mu-seven","po-mu-nine"}
	elseif IsGame("techno") then
		return {"single4","single5","single8","single9"}
	end
end

function ChoiceVersus()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox() then
			return {"versus","solo-versus","threepanel-versus"}
		else
			return {"versus"}
		end
	elseif IsGame("pump") then
		return {"versus"}
	elseif IsGame("smx") then
		return {"versus"}
	elseif IsGame("be-mu") or IsGame("beat") then
		if isOutFox() then
			return {"versus5","versus6","versus7"}
		else
			return {"versus5","versus7"}
		end
	elseif IsGame("po-mu") then
		return {"po-mu-three-versus","po-mu-four-versus","po-mu-five-versus","po-mu-seven-versus","po-mu-nine-versus"}
	elseif IsGame("techno") then
		return {"versus4","versus5","versus8","versus9"}
	end
end

function ChoiceDouble()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox() then
			return {"double","solo-double","threepanel-double"}
		else
			return {"double"}
		end
	elseif IsGame("pump") then
		return {"double"}
	elseif IsGame("smx") then
		return {"double10"}
	elseif IsGame("be-mu") or IsGame("beat") then
		if isOutFox() then
			return {"double5","double6","double7"}
		else
			return {"double5","double7"}
		end
	elseif IsGame("po-mu") then
		return {nil,nil,nil,nil,"po-mu-nine-double"}
	elseif IsGame("techno") then
		return {"double4","double5","double8","double9"}
	end
end

function GameModeEnabled()
	if IsGame("dance") or IsGame("groove") or IsGame("pump") or IsGame("smx") or IsGame("be-mu") or IsGame("beat") or IsGame("po-mu") or IsGame("techno") then
		return true
	else
		return false
	end
end

function GetStyles()
	if GameModeEnabled() then
		if IsNetSMOnline() then
			if ChoiceDouble()[GetUserPrefN("StylePosition")] then
				return "1,3"
			else
				return "1"
			end
		else
			if ChoiceDouble()[GetUserPrefN("StylePosition")] then
				return "1,2,3"
			else
				return "1,2"
			end
		end
	else
		return "0"
	end
end

function GetStylesWorkout()
	if GameModeEnabled() then
		if ChoiceDouble()[GetUserPrefN("StylePosition")] then
			return "1,2"
		else
			return "1"
		end
	else
		return "0"
	end
end

function StyleName()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox() then
			return {"4 Arrows","6 Arrows","3 Arrows"}
		else
			return {"4 Arrows"}
		end
	elseif IsGame("pump") then
		return {"5 Arrows"}
	elseif IsGame("smx") then
		return {"5 Arrows"}
	elseif IsGame("be-mu") or IsGame("beat") then
		if isOutFox() then
			return {"5 Buttons + Turntable","Foot Pedal + 5 Buttons + Turntable","7 Buttons + Turntable"}
		else
			return {"5 Buttons + Turntable","7 Buttons + Turntable"}
		end
	elseif IsGame("po-mu") then
		return {"3 Buttons","4 Buttons","5 Buttons","7 Buttons","9 Buttons"}
	elseif IsGame("techno") then
		return {"4 Arrows","5 Arrows","8 Arrows","9 Arrows"}
	end
	return false
end

function StepsTypeSingle()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox() then
			return {"StepsType_Dance_Single","StepsType_Dance_Solo","StepsType_Dance_Threepanel"}
		else
			return {"StepsType_Dance_Single"}
		end
	elseif IsGame("pump") then
		return {"StepsType_Pump_Single"}
	elseif IsGame("smx") then
		return {"StepsType_Smx_Single"}
	elseif IsGame("be-mu") or IsGame("beat") then
		if isOutFox() then
			return {"StepsType_Bm_Single5","StepsType_Bm_Single6","StepsType_Bm_Single7"}
		else
			return {"StepsType_Bm_Single5","StepsType_Bm_Single7"}
		end
	elseif IsGame("po-mu") then
		return {"StepsType_Pnm_Three","StepsType_Pnm_Four","StepsType_Pnm_Five","StepsType_Pnm_Seven","StepsType_Pnm_Nine"}
	elseif IsGame("techno") then
		return {"StepsType_Techno_Single4","StepsType_Techno_Single5","StepsType_Techno_Single8","StepsType_Techno_Single9"}
	end
	return false
end

function StepsTypeDouble()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox() then
			return {"StepsType_Dance_Double","StepsType_Dance_Solodouble","StepsType_Dance_Threedouble"}
		else
			return {"StepsType_Dance_Double"}
		end
	elseif IsGame("pump") then
		return {"StepsType_Pump_Double"}
	elseif IsGame("smx") then
		return {"StepsType_Smx_Double10"}
	elseif IsGame("be-mu") or IsGame("beat") then
		if isOutFox() then
			return {"StepsType_Bm_Double5","StepsType_Bm_Double6","StepsType_Bm_Double7"}
		else
			return {"StepsType_Bm_Double5","StepsType_Bm_Double7"}
		end
	elseif IsGame("po-mu") then
		return {nil,nil,nil,nil,"StepsType_Pnm_Nine_Double"}
	elseif IsGame("techno") then
		return {"StepsType_Techno_Double4","StepsType_Techno_Double5","StepsType_Techno_Double8","StepsType_Techno_Double9"}
	end
	return false
end

function SongMods()
	local style = GAMESTATE:GetCurrentStyle()
	local styleType = style:GetStyleType()
	local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
	local add,add2 = "",isOutFoxV() and ",27" or ""

	if isOutFox() and not isOni() then
		add = (GAMESTATE:GetNumPlayersEnabled() == 1 and not doubles) and "20S,20G," or "20G,"
	else
		add = (GAMESTATE:GetNumPlayersEnabled() == 1 and not doubles) and "20S," or ""
	end

	local fail = isOutFoxV() and "FV" or "F"
	local options = "1,2,4,"..fail..",0,3,5,RE,RE2,AE,AE2,AE3"..(isOutFox() and ",AE4" or "")..",17,9,"

	if isRegular() then
		if doubles then
			options = addToOutput(options,"23,10,11",",")
		else
			options = addToOutput(options,"22,23,10,11",",")
		end
	elseif isNonstop() then
		options = addToOutput(options,"22,23",",")
	else
		options = addToOutput(options,"10,11",",")
	end

	options = addToOutput(options,"12,13,14,7,BGC,M,A,15,19,28,30,S,25",",")

	if isRegular() then
		if HasLuaCheck() then
			options = addToOutput(options,"20,"..add.."P,29,21"..add2..",24",",")
		else
			options = addToOutput(options,"20,"..add.."P,29"..add2..",24",",")
		end
	elseif isNonstop() then
		if IsCourseSecret() then
			options = addToOutput(options,"20,"..add.."P,29"..add2..",24",",")
		else
			options = addToOutput(options,"20,"..add.."P,29,21"..add2..",24",",")
		end
	end

	if GAMESTATE:IsCourseMode() then
		if (GAMESTATE:GetNumPlayersEnabled() == 1 and not doubles) then
			options = "1,3,22R"
		else
			options = "1,3"
		end
	end

	if isVS() then
		options = addToOutput(options,"28,21"..add2,",")
	elseif GAMESTATE:IsCourseMode() then
		options = addToOutput(options,"28,S,20,"..add.."P,29,21"..add2,",")
	end

	options = addToOutput(options,"16",",")
	return options
end

function ModeMenu()
	local style = GAMESTATE:GetCurrentStyle()
	local styleType = style:GetStyleType()
	local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')

	local options = "Group,Title,Artist,Genre,Bpm,Length,"

	if isITGmania() then
		options = addToOutput(options,"Meter",",")
	else
		if not doubles then
			options = addToOutput(options,"EasyMeter,MediumMeter,HardMeter,ChallengeMeter",",")
		else
			options = addToOutput(options,"DoubleEasyMeter,DoubleMediumMeter,DoubleHardMeter,DoubleChallengeMeter",",")
		end
	end

	options = addToOutput(options,"Popularity,Recent",",")

	if isITGmania() then
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			if PROFILEMAN:IsPersistentProfile(player) then
				options = addToOutput(options,"Top".. ToEnumShortString(player).."Grades",",")
			end
		end
	else
		options = addToOutput(options,"TopGrades",",")
	end

	options = addToOutput(options,"Preferred,Dance,Battle,Rave",",")

	return options
end

function getPercentValues()
	local temp = ""
	for i=0,10 do
		temp = temp .. (i*10) .. "%"
		if i < 10 then temp = temp .. "," end
	end

	return split(",",temp)
end

local function LoadUserPref(pn, option, default)
	if not PROFILEMAN:IsPersistentProfile(pn) then return default end
    local f = RageFileUtil.CreateRageFile()
    local output = default
	local file = PROFILEMAN:GetProfileDir('ProfileSlot_Player'..pn:sub(-1))..'UserPrefs/'..THEME:GetCurThemeName()..'/'..option
    if f:Open(file, 1) then
		output = f:GetLine()
        f:Close()
    end
    f:destroy()

    return output
end

function LoadUserPrefB(pn, option, default)
	if GAMESTATE:IsHumanPlayer(pn) then
		return tobool(LoadUserPref(pn, option, default))
	else
		return default
	end
end

function LoadUserPrefN(pn, option, default)
	if GAMESTATE:IsHumanPlayer(pn) then
		return tonumber(LoadUserPref(pn, option, default))
	else
		return default
	end
end

local function SaveUserPref(pn, option, value)
	if not PROFILEMAN:IsPersistentProfile(pn) then return value end
    local f = RageFileUtil.CreateRageFile()
	local file = PROFILEMAN:GetProfileDir('ProfileSlot_Player'..pn:sub(-1))..'UserPrefs/'..THEME:GetCurThemeName()..'/'..option
    if f:Open(file, 2) then
		f:Write(tostring(value))
        f:Close()
    end
    f:destroy()

	return value
end

function InitRotationOptions()
	if not getenv("RotationCheck") then
		if GAMESTATE:GetNumPlayersEnabled() == 1 and PREFSMAN:GetPreference("Center1Player") then
			setenv("RotationP1",LoadUserPrefN(PLAYER_1, "Effect", 5))
			setenv("RotationP2",LoadUserPrefN(PLAYER_2, "Effect", 5))
		else
			setenv("RotationP1",1)
			setenv("RotationP2",1)
		end
		setenv("RotationCheck",true)
	end
end

function InitOptions()
	local KeyMaps = SetupKeymapArray() or {}

	if KeyMaps and KeyMaps[GAMESTATE:GetCurrentGame():GetName()] then
		setenv("EffectControlP1",keyMapped(KeyMaps[GAMESTATE:GetCurrentGame():GetName()]["1_EffectDown"]) and keyMapped(KeyMaps[GAMESTATE:GetCurrentGame():GetName()]["1_EffectUp"]))
		setenv("EffectControlP2",keyMapped(KeyMaps[GAMESTATE:GetCurrentGame():GetName()]["2_EffectDown"]) and keyMapped(KeyMaps[GAMESTATE:GetCurrentGame():GetName()]["2_EffectUp"]))
	end

	GAMESTATE:SetFailTypeExplicitlySet(true)
	setenv("HighScoreableP1",false)
	setenv("HighScoreableP2",false)

	if GetUserPrefN("StylePosition") == nil then
		SetUserPref("StylePosition",1)
	elseif GetUserPrefN("StylePosition") > #ChoiceSingle() then
		SetUserPref("StylePosition",1)
	end

	setenv("BattleMode","rave")
end

function InitPlayerOptions()
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if not isVS() then
			setenv("Effect"..pname(pn),LoadUserPrefN(pn, "Effect", 0))
		else
			setenv("Effect"..pname(pn),0)
		end

		setenv("HideScore"..pname(pn),LoadUserPrefB(pn, "HideScore", false))
		setenv("HideCombo"..pname(pn),LoadUserPrefB(pn, "HideCombo", false))
		setenv("HideLife"..pname(pn),LoadUserPrefB(pn, "HideLife", false))

		setenv("UnderCombo"..pname(pn),LoadUserPrefB(pn, "UnderCombo", false))
		setenv("UnderTapJudgments"..pname(pn),LoadUserPrefB(pn, "UnderTapJudgments", false))
		setenv("UnderHoldJudgments"..pname(pn),LoadUserPrefB(pn, "UnderHoldJudgments", false))

		setenv("ShowMovePlayerStats"..pname(pn),LoadUserPrefN(pn, "ShowMovePlayerStats", 3))
		setenv("SetScoreType"..pname(pn),LoadUserPrefN(pn, "SetScoreType", 2))
		setenv("SetScoreDirection"..pname(pn),LoadUserPrefN(pn, "SetScoreDirection", 1))
		setenv("ScreenFilter"..pname(pn),LoadUserPrefN(pn, "ScreenFilter", 0))

		if not isVS() then
			setenv("ShowStats"..pname(pn),LoadUserPrefN(pn, "ShowStats", 0))
			setenv("ShowStatsSize"..pname(pn),LoadUserPrefN(pn, "ShowStatsSize", 1))
			setenv("ShowNoteGraph"..pname(pn),LoadUserPrefN(pn, "ShowNoteGraph", 1))
			setenv("SetPacemaker"..pname(pn),LoadUserPrefN(pn, "SetPacemaker", 0))
		else
			setenv("ShowStats"..pname(pn),0)
			setenv("ShowStatsSize"..pname(pn),1)
			setenv("ShowNoteGraph"..pname(pn),1)
			setenv("SetPacemaker"..pname(pn),0)
		end

		setenv("ShowMods"..pname(pn),LoadUserPrefB(pn, "ShowMods", false))
		setenv("ShowSpeedAssist"..pname(pn),LoadUserPrefB(pn, "ShowSpeedAssist", false))
		setenv("ShowStopAssist"..pname(pn),LoadUserPrefB(pn, "ShowStopAssist", false))
	end

end

local function AvailableArrowDirections()
	local dirs = { "Normal", "Left", "Right", "Upside-Down" }
	if GAMESTATE:GetNumPlayersEnabled() == 1 then dirs[#dirs+1] = "Solo-Centered" end
	return dirs
end

function OptionOrientation()
	local t = {
		Name = "Orientation",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = AvailableArrowDirections(),
		LoadSelections = function(self, list, pn)
			local selected = getenv("Rotation"..pname(pn))
			if selected and selected ~= 0 and #self.Choices <= selected then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then setenv("Rotation"..pname(pn),SaveUserPref(pn, "Rotation", i)) end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionPlayfield()
	local t = {
		Name = "PlayfieldMods",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Vibrate", "Spin Right", "Spin Left", "Bob", "Pulse", "Wag" },
		LoadSelections = function(self, list, pn)
			local selected = getenv("Effect"..pname(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			end
		end,
		SaveSelections = function() end,
		NotifyOfSelection= function(self, pn, choice)
			local selected = getenv("Effect"..pname(pn))
			setenv("Effect"..pname(pn),SaveUserPref(pn, "Effect", selected == choice and 0 or choice))
			return true
		end
	}
	setmetatable(t, t)
	return t
end

function OptionTournamentOptions()
	local t = {
		Name="TournamentOptions",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Hide Score", "Hide Combo", "Hide Lifebar" },
		LoadSelections = function(self, list, pn)
			list[1] = getenv("HideScore"..pname(pn))
			list[2] = getenv("HideCombo"..pname(pn))
			list[3] = getenv("HideLife"..pname(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("HideScore"..pname(pn),SaveUserPref(pn, "HideScore", list[1]))
			setenv("HideCombo"..pname(pn),SaveUserPref(pn, "HideCombo", list[2]))
			setenv("HideLife"..pname(pn),SaveUserPref(pn, "HideLife", list[3]))
		end
	}
	setmetatable(t, t)
	return t
end

function OptionUnderFieldOptions()
	local t = {
		Name="UnderFieldOptions",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { "Combo", "Tap Judgments", "Hold Judgments" },
		LoadSelections = function(self, list, pn)
			list[1] = getenv("UnderCombo"..pname(pn))
			list[2] = getenv("UnderTapJudgments"..pname(pn))
			list[3] = getenv("UnderHoldJudgments"..pname(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("UnderCombo"..pname(pn),SaveUserPref(pn, "UnderCombo", list[1]))
			setenv("UnderTapJudgments"..pname(pn),SaveUserPref(pn, "UnderTapJudgments", list[2]))
			setenv("UnderHoldJudgments"..pname(pn),SaveUserPref(pn, "UnderHoldJudgments", list[3]))
		end
	}
	setmetatable(t, t)
	return t
end

function OptionMovePlayerStats()
	local t = {
		Name="MovePlayerStats",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Top","Top|Center","Center","Center|Bottom","Bottom" },
		LoadSelections = function(self, list, pn)
			local selected = getenv("ShowMovePlayerStats"..pname(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("ShowMovePlayerStats"..pname(pn),SaveUserPref(pn, "ShowMovePlayerStats", i))
					break
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionSetScoreType()
	local t = {
		Name="SetScoreType",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Score","Percent","EX","Additive","Subtractive" },
		LoadSelections = function(self, list, pn)
			local scoreType = getenv("SetScoreType"..pname(pn))
			local scoreDirection = getenv("SetScoreDirection"..pname(pn))
			if scoreType and scoreType ~= 0 then
				list[scoreType] = true
			else
				list[2] = true
			end
			if scoreDirection and scoreDirection ~= 0 then
				list[scoreDirection+3] = true
			else
				list[4] = true
			end
		end,
		SaveSelections = function() end,
		NotifyOfSelection= function(self, pn, choice)
			if choice <= 3 then
				setenv("SetScoreType"..pname(pn),SaveUserPref(pn, "SetScoreType", choice))
			else
				setenv("SetScoreDirection"..pname(pn),SaveUserPref(pn, "SetScoreDirection", choice-3))
			end
			return true
		end
	}
	setmetatable(t, t)
	return t
end

function OptionRowScreenFilter()
	local t = {
		Name="ScreenFilter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = getPercentValues(),
		LoadSelections = function(self, list, pn)
			local filterValue = getenv("ScreenFilter"..pname(pn)) or 0
			local val = filterValue*10+1
			list[val] = true
		end,
		SaveSelections = function(self, list, pn)
			local val = 0
			for i=1,#list do
				if list[i] then val = (i-1)/10 end
			end
			setenv("ScreenFilter"..pname(pn),SaveUserPref(pn, "ScreenFilter", val))
		end
	}
	setmetatable(t, t)
	return t
end

function OptionShowStats()
	local t = {
		Name="ShowStats",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Off","W1","W2","W3","W4","W5","Miss","IIDX" },
		LoadSelections = function(self, list, pn)
			local selected = (getenv("ShowStats"..pname(pn)) or 0) + 1
			list[selected] = true
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("ShowStats"..pname(pn),SaveUserPref(pn, "ShowStats", i-1))
					break
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionShowStatsSize()
	local t = {
		Name="ShowStatsSize",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Full","Mini" },
		LoadSelections = function(self, list, pn)
			local selected = getenv("ShowStatsSize"..pname(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("ShowStatsSize"..pname(pn),SaveUserPref(pn, "ShowStatsSize", i))
					break
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionShowNoteGraph()
	local t = {
		Name="ShowNoteGraph",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Off","Row","All","SPS" },
		LoadSelections = function(self, list, pn)
			local selected = getenv("ShowNoteGraph"..pname(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("ShowNoteGraph"..pname(pn),SaveUserPref(pn, "ShowNoteGraph", i))
					break
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionSetPacemaker()
	local t = {
		Name="SetPacemaker",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = {'D+','C-','C','C+','B-','B','B+','A-','A','A+','S-','S','S+','★','★★','★★★','★★★★'},
		LoadSelections = function(self, list, pn)
			local selected = getenv("SetPacemaker"..pname(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("SetPacemaker"..pname(pn),SaveUserPref(pn, "SetPacemaker", i))
					break
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionShowAssists()
	local t = {
		Name="ShowAssists",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Speed Assist","Stop Assist" },
		LoadSelections = function(self, list, pn)
			list[1] = getenv("ShowSpeedAssist"..pname(pn))
			list[2] = getenv("ShowStopAssist"..pname(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("ShowSpeedAssist"..pname(pn),SaveUserPref(pn, "ShowSpeedAssist", list[1]))
			setenv("ShowStopAssist"..pname(pn),SaveUserPref(pn, "ShowStopAssist", list[2]))
		end
	}
	setmetatable(t, t)
	return t
end

function OptionShowModifiers()
	local t = {
		Name="ShowModifiers",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Show Active Modifiers" },
		LoadSelections = function(self, list, pn)
			list[1] = getenv("ShowMods"..pname(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("ShowMods"..pname(pn),SaveUserPref(pn, "ShowMods", list[1]))
		end
	}
	setmetatable(t, t)
	return t
end

function OptionOrientationRestricted()
	local t = {
		Name = "Orientation",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Normal", "Solo-Centered" },
		LoadSelections = function(self, list, pn)
			list[1] = getenv("Rotation"..pname(pn)) == 1
			list[2] = getenv("Rotation"..pname(pn)) == 5
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("Rotation"..pname(pn),SaveUserPref(pn, "Rotation", (i-1)*4+1))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function GetRateMod()
	local msrate = string.format( "%.1f", GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate() )
	if msrate == "1.0" then return '' else return msrate..'x Rate' end
end

function DisplayCustomModifiersText(pn)
	local style = GAMESTATE:GetCurrentStyle()
	local styleType = style:GetStyleType()
	local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
	local output = ""

	if getenv("UnderCombo"..pname(pn)) and getenv("UnderTapJudgments"..pname(pn)) and getenv("UnderHoldJudgments"..pname(pn)) then
		output = addToOutput(output,"Under All",", ")
	else
		if getenv("UnderTapJudgments"..pname(pn)) and getenv("UnderHoldJudgments"..pname(pn)) then
			output = addToOutput(output,"Under Judgments",", ")
		else
			if getenv("UnderCombo"..pname(pn)) then output = addToOutput(output,"Under Combo",", ") end
			if getenv("UnderTapJudgments"..pname(pn)) then output = addToOutput(output,"Under Tap Judgments",", ") end
			if getenv("UnderHoldJudgments"..pname(pn)) then output = addToOutput(output,"Under Hold Judgments",", ") end
		end
	end

	if getenv("HideScore"..pname(pn)) and getenv("HideLife"..pname(pn)) and getenv("HideCombo"..pname(pn)) then
		output = addToOutput(output,"Hide All",", ")
	else
		if getenv("HideScore"..pname(pn)) then output = addToOutput(output,"Hide Score",", ") end
		if getenv("HideLife"..pname(pn)) then output = addToOutput(output,"Hide Life",", ") end
		if getenv("HideCombo"..pname(pn)) then output = addToOutput(output,"Hide Combo",", ") end
	end

	if getenv("Rotation"..pname(pn)) == 2 then output = addToOutput(output,"Rotated Left",", ")
	elseif getenv("Rotation"..pname(pn)) == 3 then output = addToOutput(output,"Rotated Right",", ")
	elseif getenv("Rotation"..pname(pn)) == 4 then output = addToOutput(output,"Rotated Downward",", ")
	elseif getenv("Rotation"..pname(pn)) == 5 then output = addToOutput(output,"Centered",", ") end

	if getenv("Effect"..pname(pn)) == 6 then output = addToOutput(output,"Wag",", ")
	elseif getenv("Effect"..pname(pn)) == 5 then output = addToOutput(output,"Pulse",", ")
	elseif getenv("Effect"..pname(pn)) == 4 then output = addToOutput(output,"Bounce",", ")
	elseif getenv("Effect"..pname(pn)) == 3 then output = addToOutput(output,"Spin Left",", ")
	elseif getenv("Effect"..pname(pn)) == 2 then output = addToOutput(output,"Spin Right",", ")
	elseif getenv("Effect"..pname(pn)) == 1 then output = addToOutput(output,"Vibrate",", ") end

	if getenv("ShowMods"..pname(pn)) then output = addToOutput(output,"Show Mods",", ") end
	if getenv("ShowStats"..pname(pn)) > 0 then
		if GAMESTATE:GetNumPlayersEnabled() == 2 and not doubles then
			if getenv("ShowNoteGraph"..pname(pn)) > 1 then
				output = addToOutput(output,"Show Stats",", ")
			else
				output = addToOutput(output,"Show Stats & NoteGraph",", ")
			end
		elseif getenv("ShowStatsSize"..pname(pn)) == 1 then
			if getenv("ShowNoteGraph"..pname(pn)) > 1 then
				output = addToOutput(output,"Show FullStats",", ")
			else
				output = addToOutput(output,"Show FullStats & NoteGraph",", ")
			end
		elseif getenv("ShowStatsSize"..pname(pn)) == 2 then
			if getenv("ShowNoteGraph"..pname(pn)) > 1 then
				output = addToOutput(output,"Show MiniStats",", ")
			else
				output = addToOutput(output,"Show MiniStats & NoteGraph",", ")
			end
		end
	elseif getenv("ShowNoteGraph"..pname(pn)) > 1 then
		output = addToOutput(output,"Show NoteGraph",", ")
	end

	if getenv("ScreenFilter"..pname(pn)) > 0 then output = addToOutput(output,"Screen Filter ("..(getenv("ScreenFilter"..pname(pn))*100).."%)",", ") end

	if GetRateMod() ~= '' then output = addToOutput(output,GetRateMod(),", ") end

	return output
end