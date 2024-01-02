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
		if key[1] ~= "" then return true end
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
	end
end

function GameModeEnabled()
	if IsGame("dance") or IsGame("groove") or IsGame("pump") or IsGame("smx") or IsGame("be-mu") or IsGame("beat") or IsGame("po-mu") then
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
	local options = "1,2,4,"..fail..",0,3,5,RE,RE2,AE,AE2,AE3,17,9,"

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

	if isRave() then
		options = addToOutput(options,"28,21"..add2,",")
	elseif GAMESTATE:IsCourseMode() then
		options = addToOutput(options,"28,S,20,"..add.."P,29,21"..add2,",")
	end

	options = addToOutput(options,"16",",")
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

function InitRotationOptions()
	if not getenv("RotationCheck") then
		if GAMESTATE:GetNumPlayersEnabled() == 1 and PREFSMAN:GetPreference("Center1Player") then
			setenv("RotationNormalP1",false)
			setenv("RotationNormalP2",false)
			setenv("RotationSoloP1",true)
			setenv("RotationSoloP2",true)
		else
			setenv("RotationNormalP1",true)
			setenv("RotationNormalP2",true)
			setenv("RotationSoloP1",false)
			setenv("RotationSoloP2",false)
		end
		setenv("RotationCheck",true)
	end
end

function InitOptions()
	local KeyMaps = SetupKeymapArray() or {}

	if #KeyMaps > 0 then
		setenv("EffectControlP1",keyMapped(KeyMaps[GAMESTATE:GetCurrentGame():GetName()]["1_EffectDown"]) and keyMapped(KeyMaps[GAMESTATE:GetCurrentGame():GetName()]["1_EffectUp"]))
		setenv("EffectControlP2",keyMapped(KeyMaps[GAMESTATE:GetCurrentGame():GetName()]["2_EffectDown"]) and keyMapped(KeyMaps[GAMESTATE:GetCurrentGame():GetName()]["2_EffectUp"]))
	end

	if GetUserPrefN("StylePosition") == nil then
		SetUserPref("StylePosition",1)
	elseif GetUserPrefN("StylePosition") > #ChoiceSingle() then
		SetUserPref("StylePosition",1)
	end

	GAMESTATE:SetFailTypeExplicitlySet(true)
	setenv("HighScoreableP1",false)
	setenv("HighScoreableP2",false)

	setenv("RotationLeftP1",false)
	setenv("RotationLeftP2",false)
	setenv("RotationRightP1",false)
	setenv("RotationRightP2",false)
	setenv("RotationUpsideDownP1",false)
	setenv("RotationUpsideDownP2",false)

	setenv("EffectWagP1",false)
	setenv("EffectWagP2",false)
	setenv("EffectPulseP1",false)
	setenv("EffectPulseP2",false)
	setenv("EffectBounceP1",false)
	setenv("EffectBounceP2",false)
	setenv("EffectSpinReverseP1",false)
	setenv("EffectSpinReverseP2",false)
	setenv("EffectSpinP1",false)
	setenv("EffectSpinP2",false)
	setenv("EffectVibrateP1",false)
	setenv("EffectVibrateP2",false)

	setenv("HideScoreP1",false)
	setenv("HideScoreP2",false)
	setenv("HideComboP1",false)
	setenv("HideComboP2",false)
	setenv("HideLifeP1",false)
	setenv("HideLifeP2",false)

	setenv("UnderComboP1",false)
	setenv("UnderComboP2",false)
	setenv("UnderTapJudgmentsP1",false)
	setenv("UnderTapJudgmentsP2",false)
	setenv("UnderHoldJudgmentsP1",false)
	setenv("UnderHoldJudgmentsP2",false)

	setenv("ShowMovePlayerStatsP1",3)
	setenv("ShowMovePlayerStatsP2",3)
	setenv("SetScoreTypeP1",2)
	setenv("SetScoreTypeP2",2)
	setenv("ScreenFilterP1",0)
	setenv("ScreenFilterP2",0)

	setenv("ShowStatsP1",0)
	setenv("ShowStatsP2",0)
	setenv("ShowStatsSizeP1",1)
	setenv("ShowStatsSizeP2",1)
	setenv("ShowNoteGraphP1",1)
	setenv("ShowNoteGraphP2",1)
	setenv("SetPacemakerP1",0)
	setenv("SetPacemakerP2",0)
	
	setenv("ShowModsP1",false)
	setenv("ShowModsP2",false)
	setenv("ShowSpeedAssistP1",false)
	setenv("ShowSpeedAssistP2",false)
	setenv("ShowStopAssistP1",false)
	setenv("ShowStopAssistP2",false)

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
			list[1] = getenv("RotationNormal"..pname(pn))
			list[2] = getenv("RotationLeft"..pname(pn))
			list[3] = getenv("RotationRight"..pname(pn))
			list[4] = getenv("RotationUpsideDown"..pname(pn))
			if GAMESTATE:GetNumPlayersEnabled() == 1 then list[5] = getenv("RotationSolo"..pname(pn)) end
		end,
		SaveSelections = function(self, list, pn)
			setenv("RotationNormal"..pname(pn),list[1])
			setenv("RotationLeft"..pname(pn),list[2])
			setenv("RotationRight"..pname(pn),list[3])
			setenv("RotationUpsideDown"..pname(pn),list[4])
			if GAMESTATE:GetNumPlayersEnabled() == 1 then setenv("RotationSolo"..pname(pn),list[5]) end
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
			list[1] = getenv("EffectVibrate"..pname(pn))
			list[2] = getenv("EffectSpin"..pname(pn))
			list[3] = getenv("EffectSpinReverse"..pname(pn))
			list[4] = getenv("EffectBounce"..pname(pn))
			list[5] = getenv("EffectPulse"..pname(pn))
			list[6] = getenv("EffectWag"..pname(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("EffectVibrate"..pname(pn),list[1])
			setenv("EffectSpin"..pname(pn),list[2])
			setenv("EffectSpinReverse"..pname(pn),list[3])
			setenv("EffectBounce"..pname(pn),list[4])
			setenv("EffectPulse"..pname(pn),list[5])
			setenv("EffectWag"..pname(pn),list[6])
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
			setenv("HideScore"..pname(pn),list[1])
			setenv("HideCombo"..pname(pn),list[2])
			setenv("HideLife"..pname(pn),list[3])
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
			setenv("UnderCombo"..pname(pn),list[1])
			setenv("UnderTapJudgments"..pname(pn),list[2])
			setenv("UnderHoldJudgments"..pname(pn),list[3])
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
					setenv("ShowMovePlayerStats"..pname(pn),i)
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
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Score","Percent","EX" },
		LoadSelections = function(self, list, pn)
			local selected = getenv("SetScoreType"..pname(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("SetScoreType"..pname(pn),i)
					break
				end
			end
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
			local filterValue = getenv("ScreenFilter"..pname(pn))
			if filterValue ~= nil then
				local val = filterValue*10+1
				list[val] = true
			else
				setenv("ScreenFilter"..pname(pn),0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = 0
			for i=1,#list do
				if list[i] then val = (i-1)/10 end
			end
			setenv("ScreenFilter"..pname(pn),val)
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
			local selected = getenv("ShowStats"..pname(pn))+1
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("ShowStats"..pname(pn),i-1)
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
					setenv("ShowStatsSize"..pname(pn),i)
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
		Choices = { "Off","On" },
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
					setenv("ShowNoteGraph"..pname(pn),i)
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
					setenv("SetPacemaker"..pname(pn),i)
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
			setenv("ShowSpeedAssist"..pname(pn),list[1])
			setenv("ShowStopAssist"..pname(pn),list[2])
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
			setenv("ShowMods"..pname(pn),list[1])
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
			list[1] = getenv("RotationNormal"..pname(pn))
			list[2] = getenv("RotationSolo"..pname(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("RotationNormal"..pname(pn),list[1])
			setenv("RotationSolo"..pname(pn),list[2])
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

	if getenv("RotationLeft"..pname(pn)) then output = addToOutput(output,"Rotated Left",", ") end
	if getenv("RotationRight"..pname(pn)) then output = addToOutput(output,"Rotated Right",", ") end
	if getenv("RotationUpsideDown"..pname(pn)) then output = addToOutput(output,"Rotated Downward",", ") end
	if getenv("RotationSolo"..pname(pn)) then output = addToOutput(output,"Centered",", ") end

	if getenv("EffectWag"..pname(pn)) then output = addToOutput(output,"Wag",", ")
	elseif getenv("EffectPulse"..pname(pn)) then output = addToOutput(output,"Pulse",", ")
	elseif getenv("EffectBounce"..pname(pn)) then output = addToOutput(output,"Bounce",", ")
	elseif getenv("EffectSpinReverse"..pname(pn)) then output = addToOutput(output,"Spin Left",", ")
	elseif getenv("EffectSpin"..pname(pn)) then output = addToOutput(output,"Spin Right",", ")
	elseif getenv("EffectVibrate"..pname(pn)) then output = addToOutput(output,"Vibrate",", ") end

	if getenv("ShowMods"..pname(pn)) then output = addToOutput(output,"Show Mods",", ") end
	if getenv("ShowStats"..pname(pn)) > 0 then
		if GAMESTATE:GetNumPlayersEnabled() == 2 and not doubles then
			if getenv("ShowNoteGraph"..pname(pn)) == 1 then
				output = addToOutput(output,"Show Stats",", ")
			else
				output = addToOutput(output,"Show Stats with Note Graph",", ")
			end
		elseif getenv("ShowStatsSize"..pname(pn)) == 1 then
			if getenv("ShowNoteGraph"..pname(pn)) == 1 then
				output = addToOutput(output,"Show FullStats",", ")
			else
				output = addToOutput(output,"Show FullStats with Note Graph",", ")
			end
		elseif getenv("ShowStatsSize"..pname(pn)) == 2 then
			if getenv("ShowNoteGraph"..pname(pn)) == 1 then
				output = addToOutput(output,"Show MiniStats",", ")
			else
				output = addToOutput(output,"Show MiniStats with Note Graph",", ")
			end
		end
	end

	if getenv("ScreenFilter"..pname(pn)) > 0 then output = addToOutput(output,"Screen Filter ("..(getenv("ScreenFilter"..pname(pn))*100).."%)",", ") end

	if GetRateMod() ~= '' then output = addToOutput(output,GetRateMod(),", ") end

	return output
end