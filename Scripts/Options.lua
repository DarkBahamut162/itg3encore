function ChoiceSingle()
	if IsGame("dance") or IsGame("groove") then
		if isEtterna() then
			return {"single","threepanel"}
		else
			return {"single","solo","threepanel"}
		end
	elseif IsGame("solo") then
		return {"single"}
	elseif IsGame("pump") then
		return {"single"}
	elseif IsGame("smx") then
		return {"single"}
	elseif IsGame("be-mu") then
		return {"single5","single6","single7"}
	elseif IsGame("beat") then
		return {"single5","single7"}
	elseif IsGame("po-mu") then
		return {"po-mu-three","po-mu-four","po-mu-five","po-mu-seven","po-mu-nine"}
	elseif IsGame("popn") then
		return {"popn-five","popn-nine"}
	elseif IsGame("techno") then
		if VersionDateCheck(20210300) then
			return {"single4","single5","single8","single9"}
		else
			return {"single4","single5","single8"}
		end
	end
end

function ChoiceVersus()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox() and VersionDateCheck(20220000) then
			return {"versus","solo-versus","threepanel-versus"}
		else
			return {"versus",nil,nil}
		end
	elseif IsGame("solo") then
		return {nil}
	elseif IsGame("pump") then
		return {"versus"}
	elseif IsGame("smx") then
		return {"versus"}
	elseif IsGame("be-mu") then
		return {"versus5","versus6","versus7"}
	elseif IsGame("beat") then
		return {"versus5","versus7"}
	elseif IsGame("po-mu") then
		if VersionDateCheck(20210815) then
			return {"po-mu-three-versus","po-mu-four-versus","po-mu-five-versus","po-mu-seven-versus","po-mu-nine-versus"}
		else
			return {nil,nil,nil,nil,nil}
		end
	elseif IsGame("techno") then
		if VersionDateCheck(20210300) then
			return {"versus4","versus5","versus8","versus9"}
		else
			return {"versus4","versus5","versus8"}
		end
	end
end

function ChoiceDouble()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox() and VersionDateCheck(20220000) then
			return {"double","solo-double","threepanel-double"}
		else
			return {"double",nil,nil}
		end
	elseif IsGame("solo") then
		return {nil}
	elseif IsGame("pump") then
		return {"double"}
	elseif IsGame("smx") then
		return {"double10"}
	elseif IsGame("be-mu") then
		return {"double5","double6","double7"}
	elseif IsGame("beat") then
		return {"double5","double7"}
	elseif IsGame("po-mu") then
		return {nil,nil,nil,nil,VersionDateCheck(20210815) and "po-mu-nine-double" or nil}
	elseif IsGame("popn") then
		return {nil,nil}
	elseif IsGame("techno") then
		if VersionDateCheck(20210300) then
			return {"double4","double5","double8","double9"}
		else
			return {"double4","double5","double8"}
		end
	end
end

function GameModeEnabled()
	if IsGame("dance") or IsGame("groove") or IsGame("solo") or IsGame("pump") or IsGame("smx") or IsGame("be-mu") or IsGame("beat") or IsGame("po-mu") or IsGame("popn") or IsGame("techno") then
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
				return isEtterna() and "1,3" or "1,2,3"
			else
				if isEtterna() then
					return "1"
				elseif ChoiceVersus()[GetUserPrefN("StylePosition")] then
					return "1,2"
				else
					return "1"
				end
			end
		end
	else
		return "0"
	end
end

function GetStylesWorkout()
	if GameModeEnabled() then
		if ChoiceDouble()[GetUserPrefN("StylePosition")] then
			return "1,2,3"
		else
			return "1,2"
		end
	else
		return "0"
	end
end

function StyleName()
	if IsGame("dance") or IsGame("groove") then
		if isEtterna() then
			return {"4 Arrows","3 Arrows"}
		else
			return {"4 Arrows","6 Arrows","3 Arrows"}
		end
	elseif IsGame("solo") then
		return {"6 Arrows"}
	elseif IsGame("pump") then
		return {"5 Arrows"}
	elseif IsGame("smx") then
		return {"5 Arrows"}
	elseif IsGame("be-mu") then
		return {"5 Buttons + Turntable","Foot Pedal + 5 Buttons + Turntable","7 Buttons + Turntable"}
	elseif IsGame("beat") then
		return {"5 Buttons + Turntable","7 Buttons + Turntable"}
	elseif IsGame("po-mu") then
		return {"3 Buttons","4 Buttons","5 Buttons","7 Buttons","9 Buttons"}
	elseif IsGame("popn") then
		return {"5 Buttons","9 Buttons"}
	elseif IsGame("techno") then
		return {"4 Arrows","5 Arrows","8 Arrows","9 Arrows"}
	end
	return false
end

function StepsTypeSingle()
	if IsGame("dance") or IsGame("groove") then
		if isEtterna() then
			return {"StepsType_Dance_Single","StepsType_Dance_Threepanel"}
		else
			return {"StepsType_Dance_Single","StepsType_Dance_Solo","StepsType_Dance_Threepanel"}
		end
	elseif IsGame("solo") then
		return {"StepsType_Dance_Solo"}
	elseif IsGame("pump") then
		return {"StepsType_Pump_Single"}
	elseif IsGame("smx") then
		return {"StepsType_Smx_Single"}
	elseif IsGame("be-mu") then
		return {"StepsType_Bm_Single5","StepsType_Bm_Single6","StepsType_Bm_Single7"}
	elseif IsGame("beat") then
		return {"StepsType_Bm_Single5","StepsType_Bm_Single7"}
	elseif IsGame("po-mu") then
		return {"StepsType_Pnm_Three","StepsType_Pnm_Four","StepsType_Pnm_Five","StepsType_Pnm_Seven","StepsType_Pnm_Nine"}
	elseif IsGame("popn") then
		return {"StepsType_Pnm_Five","StepsType_Pnm_Nine"}
	elseif IsGame("techno") then
		return {"StepsType_Techno_Single4","StepsType_Techno_Single5","StepsType_Techno_Single8","StepsType_Techno_Single9"}
	end
	return false
end

function StepsTypeDouble()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox() and VersionDateCheck(20220000) then
			return {"StepsType_Dance_Double","StepsType_Dance_Solodouble","StepsType_Dance_Threedouble"}
		else
			return {"StepsType_Dance_Double",nil,nil}
		end
	elseif IsGame("solo") then
		return {nil}
	elseif IsGame("pump") then
		return {"StepsType_Pump_Double"}
	elseif IsGame("smx") then
		return {"StepsType_Smx_Double10"}
	elseif IsGame("be-mu") then
		return {"StepsType_Bm_Double5","StepsType_Bm_Double6","StepsType_Bm_Double7"}
	elseif IsGame("beat") then
		return {"StepsType_Bm_Double5","StepsType_Bm_Double7"}
	elseif IsGame("po-mu") then
		return {nil,nil,nil,nil,VersionDateCheck(20210815) and "StepsType_Pnm_Nine_Double" or nil}
	elseif IsGame("popn") then
		return {nil,nil}
	elseif IsGame("techno") then
		return {"StepsType_Techno_Double4","StepsType_Techno_Double5","StepsType_Techno_Double8","StepsType_Techno_Double9"}
	end
	return false
end

function SongMods()
	local add,add2 = "",(isOutFoxV() and VersionDateCheck(20230624)) and ",27" or ""

	if not isOni() then add = "20G," end

	local fail = (isOutFoxV() and VersionDateCheck(20221111)) and "FV" or "F"
	local options = (isEtterna() and "Speed," or "1,") .."2,4,"..fail..","..((isRegular() and VersionDateCheck(20160000)) and (isOpenDDR() and "0DDR" or "0,Flare") or "0")..",3,5"..((isEtterna() or isOldStepMania()) and ",REE,AEE" or ",RE,RE2,AE,AE2,AE3")..(isOutFox() and ",AE4" or "")..",17,9,"

	if isRegular() then
		if isDouble() then
			options = addToOutput(options,"23,10,11",",")
		else
			options = addToOutput(options,"22,23,10,11",",")
		end
	elseif isNonstop() then
		options = addToOutput(options,"22,23",",")
	else
		options = addToOutput(options,"10,11",",")
	end

	options = addToOutput(options,"12,13,14,7,BGC,M,A,15,19,28,30,S,EB,25",",")

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
		if (GAMESTATE:GetNumPlayersEnabled() == 1 and not isDouble()) then
			options = "1,3,22R"
		else
			options = "1,3"
		end
	end

	if isVS() then
		options = addToOutput(options,"28,21"..add2,",")
	elseif GAMESTATE:IsCourseMode() then
		options = addToOutput(options,"28,S,EB,20,"..add.."P,29,21"..add2,",")
	end

	if not (IsGame("pump") or GAMESTATE:IsCourseMode()) then options = addToOutput(options,"31",",") end

	options = addToOutput(options,"16",",")
	return options
end

function ModeMenu()
	if isEtterna() then return "Group,Title,Bpm,TopGrades,Artist,Genre,Favorites,Overall,Stream,Jumpstream,Handstream,Stamina,JackSpeed,Chordjack,Technical,Length,DateAdded,Author,Ungrouped" end
	local options = "Group,Title,Artist,Genre,Bpm,Length,"

	if isITGmania() and VersionDateCheck(20240225) then
		options = addToOutput(options,"Meter",",")
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			if PROFILEMAN:IsPersistentProfile(player) then
				options = addToOutput(options,"Top".. ToEnumShortString(player).."Grades",",")
			end
		end
	else
		if not isDouble() then
			options = addToOutput(options,"BeginnerMeter,EasyMeter,MediumMeter,HardMeter,ChallengeMeter",",")
		else
			options = addToOutput(options,"DoubleEasyMeter,DoubleMediumMeter,DoubleHardMeter,DoubleChallengeMeter",",")
		end
		options = addToOutput(options,"TopGrades",",")
	end

	if isITGmania() and VersionDateCheck(20250304) then
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			if PROFILEMAN:IsPersistentProfile(player) then
				options = addToOutput(options,"Popularity".. ToEnumShortString(player),",")
				options = addToOutput(options,"Recent".. ToEnumShortString(player),",")
			end
		end
	else
		options = addToOutput(options,"Popularity,Recent",",")
	end

	options = addToOutput(options,"Preferred,Dance,Battle,Rave",",")

	return options
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
			if isDouble() then
				setenv("RotationP1",5)
				setenv("RotationP2",5)
			else
				setenv("RotationP1",LoadUserPrefN(PLAYER_1, "Effect", 5))
				setenv("RotationP2",LoadUserPrefN(PLAYER_2, "Effect", 5))
			end
		else
			setenv("RotationP1",1)
			setenv("RotationP2",1)
		end
		setenv("RotationCheck",true)
	end
end

function InitOptions()
	Master,P1,P2={},{},{}
	GAMESTATE:SetFailTypeExplicitlySet(true)
	setenv("HighScoreableP1",false)
	setenv("HighScoreableP2",false)

	if GetUserPrefN("StylePosition") == nil then
		SetUserPref("StylePosition",1)
	elseif ChoiceSingle() and GetUserPrefN("StylePosition") > #ChoiceSingle() then
		SetUserPref("StylePosition",1)
	end

	setenv("BattleMode","rave")
end

function InitPlayerOptions()
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		setenv("Flare"..pname(pn),(not isVS() and VersionDateCheck(20160000)) and LoadUserPrefN(pn, "Flare", 0) or 0)
		setenv("FlareType"..pname(pn),(not isVS() and VersionDateCheck(20160000)) and LoadUserPrefN(pn, "FlareType", 1) or 1)

		setenv("Effect"..pname(pn),not isVS() and LoadUserPrefN(pn, "Effect", 0) or 0)

		setenv("HideScore"..pname(pn),LoadUserPrefB(pn, "HideScore", false))
		setenv("HideCombo"..pname(pn),LoadUserPrefB(pn, "HideCombo", false))
		setenv("HideLife"..pname(pn),LoadUserPrefB(pn, "HideLife", false))

		setenv("UnderCombo"..pname(pn),LoadUserPrefB(pn, "UnderCombo", false))
		setenv("UnderTapJudgments"..pname(pn),LoadUserPrefB(pn, "UnderTapJudgments", false))
		setenv("UnderHoldJudgments"..pname(pn),LoadUserPrefB(pn, "UnderHoldJudgments", false))

		setenv("ShowMovePlayerStats"..pname(pn),LoadUserPrefN(pn, "ShowMovePlayerStats", 3))
		setenv("SetScoreType"..pname(pn),LoadUserPrefN(pn, "SetScoreType", 2))
		setenv("ShowErrorBar"..pname(pn),LoadUserPrefN(pn, "ShowErrorBar", 0))
		if (isOutFox() and GAMESTATE:GetCurrentGame():CountNotesSeparately() and VersionDateCheck(20210300)) then
			if getenv("SetScoreType"..pname(pn)) == 4 then
				SCREENMAN:SystemMessage("WIFE3 is bugged if notes are counted separately! "..pname(pn).."'s ScoreType has been reset to Percent!")
				setenv("SetScoreType"..pname(pn),SaveUserPref(pn, "SetScoreType", 2))
			end
		end
		setenv("SetScoreDirection"..pname(pn),LoadUserPrefN(pn, "SetScoreDirection", 1))
		setenv("SetScoreFA"..pname(pn),LoadUserPrefB(pn, "SetScoreFA", false))
		setenv("ScreenFilter"..pname(pn),LoadUserPrefN(pn, "ScreenFilter", 0))

		setenv("ShowStats"..pname(pn),not isVS() and LoadUserPrefN(pn, "ShowStats", 0) or 0)
		setenv("ShowStatsSize"..pname(pn),not isVS() and LoadUserPrefN(pn, "ShowStatsSize", 1) or 1)
		setenv("ShowStatsPos"..pname(pn),not isVS() and LoadUserPrefN(pn, "ShowStatsPos", 0) or 0)
		setenv("ShowNoteGraph"..pname(pn),not isVS() and LoadUserPrefN(pn, "ShowNoteGraph", 1) or 1)
		setenv("ShowNoteGraphType"..pname(pn),not isVS() and LoadUserPrefN(pn, "ShowNoteGraphType", 2) or 2)
		setenv("ShowNoteGraphRange"..pname(pn),not isVS() and LoadUserPrefN(pn, "ShowNoteGraphRange", 1) or 1)
		setenv("ShowNoteGraphData"..pname(pn),not isVS() and LoadUserPrefB(pn, "ShowNoteGraphData", false) or false)
		setenv("SetPacemaker"..pname(pn),not isVS() and LoadUserPrefN(pn, "SetPacemaker", 0) or 0)

		setenv("ShowMods"..pname(pn),LoadUserPrefB(pn, "ShowMods", false))
		setenv("ShowSpeedAssist"..pname(pn),LoadUserPrefB(pn, "ShowSpeedAssist", false))
		setenv("ShowStopAssist"..pname(pn),LoadUserPrefB(pn, "ShowStopAssist", false))
		setenv("SongFrame"..pname(pn),LoadUserPref(pn, "SongFrame", "_normal"))
	end

end

function OptionFlare()
	local t = {
		Name="Flare",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Off","F1","F2","F3","F4","F5","F6","F7","F8","F9","FX","FF","Old","New" },
		LoadSelections = function(self, list, pn)
			local flare = getenv("Flare"..pname(pn))
			local flareType = getenv("FlareType"..pname(pn))
			list[flare+1] = true
			list[flareType+12] = true
		end,
		SaveSelections = function() end,
		NotifyOfSelection= function(self, pn, choice)
			if choice <= 12 then
				setenv("Flare"..pname(pn),SaveUserPref(pn, "Flare", choice-1))
			else
				setenv("FlareType"..pname(pn),SaveUserPref(pn, "FlareType", choice-12))
			end
			return true
		end
	}
	setmetatable(t, t)
	return t
end

function OptionOrientation()
	function AvailableArrowDirections()
		local dirs = { "Normal", "Left", "Right", "Upside-Down" }
		if GAMESTATE:GetNumPlayersEnabled() == 1 then dirs[#dirs+1] = "Solo-Centered" end
		return dirs
	end

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
	function GetScoreTypes(etterna)
		if etterna or (not etterna and (isOutFox() and GAMESTATE:GetCurrentGame():CountNotesSeparately() and VersionDateCheck(20210300))) then
			return { "Score","Percent","EX","Additive","Subtractive" }
		else
			return { "Score","Percent","EX","WIFE3","Additive","Subtractive" }
		end
	end

	local options = GetScoreTypes(isEtterna())
	options[#options+1] = "FA+"

	local t = {
		Name="SetScoreType",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = options,
		LoadSelections = function(self, list, pn)
			local scoreType = getenv("SetScoreType"..pname(pn))
			local scoreDirection = getenv("SetScoreDirection"..pname(pn))
			local scoreFA = getenv("SetScoreFA"..pname(pn))
			if scoreType and scoreType ~= 0 then
				list[scoreType] = true
			else
				list[2] = true
			end
			if scoreDirection and scoreDirection ~= 0 then
				list[scoreDirection+#self.Choices-3] = true
			else
				list[#self.Choices-2] = true
			end
			if scoreFA then list[#self.Choices] = true end
		end,
		SaveSelections = function() end,
		NotifyOfSelection= function(self, pn, choice)
			if choice <= #self.Choices-3 then
				setenv("SetScoreType"..pname(pn),SaveUserPref(pn, "SetScoreType", choice))
			elseif choice <= #self.Choices-1 then
				setenv("SetScoreDirection"..pname(pn),SaveUserPref(pn, "SetScoreDirection", choice-#self.Choices+3))
			else
				local scoreFA = getenv("SetScoreFA"..pname(pn))
				setenv("SetScoreFA"..pname(pn),SaveUserPref(pn, "SetScoreFA", not scoreFA))
			end
			return true
		end
	}
	setmetatable(t, t)
	return t
end

function OptionShowErrorBar()
	function Range()
		if isOpenDDR() then
			return { "Off","Fantastic","Excellent","Great","Decent","Miss" }
		else
			return { "Off","Fantastic","Excellent","Great","Decent","Way Off","Miss" }
		end
	end
	local t = {
		Name="ShowErrorBar",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = Range(),
		LoadSelections = function(self, list, pn)
			local selected = (getenv("ShowErrorBar"..pname(pn)) or 0) + 1
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("ShowErrorBar"..pname(pn),SaveUserPref(pn, "ShowErrorBar", i-1))
					break
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionRowScreenFilter()
	function getPercentValues()
		local temp = ""
		for i=0,10 do
			temp = temp .. (i*10) .. "%"
			if i < 10 then temp = temp .. "," end
		end

		return split(",",temp)
	end

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
	local options = isOpenDDR() and { "Off","W1","W2","W3","W4","Miss","IIDX" } or { "Off","W1","W2","W3","W4","W5","Miss","IIDX" }
	options[#options+1] = "Full"
	options[#options+1] = "Mini (Bottom)"
	options[#options+1] = "Mini (Top)"

	local t = {
		Name="ShowStats",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = options,
		LoadSelections = function(self, list, pn)
			local showStats = (getenv("ShowStats"..pname(pn)) or 0) + 1
			local showStatsSize = (getenv("ShowStatsSize"..pname(pn)) or 0) + (getenv("ShowStatsPos"..pname(pn)) or 0)
			list[showStats] = true
			if showStatsSize and showStatsSize ~= 0 then
				list[showStatsSize+#self.Choices-3] = true
			else
				list[#self.Choices-2] = true
			end
		end,
		SaveSelections = function() end,
		NotifyOfSelection= function(self, pn, choice)
			if choice <= #self.Choices-3 then
				setenv("ShowStats"..pname(pn),SaveUserPref(pn, "ShowStats", choice-1))
			else
				setenv("ShowStatsSize"..pname(pn),SaveUserPref(pn, "ShowStatsSize", math.min(2,choice-#self.Choices+3)))
				setenv("ShowStatsPos"..pname(pn),SaveUserPref(pn, "ShowStatsPos", math.max(0,choice-#self.Choices+1)))
			end
			return true
		end
	}
	setmetatable(t, t)
	return t
end

function OptionShowNoteGraph()
	local t = {
		Name="ShowNoteGraph",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Off","Normal","SPS","One","All","Fixed","Adjusted","Show Data" },
		LoadSelections = function(self, list, pn)
			local ShowNoteGraph = (getenv("ShowNoteGraph"..pname(pn)) or 1)
			local ShowNoteGraphType = (getenv("ShowNoteGraphType"..pname(pn)) or 1) + 3
			local ShowNoteGraphRange = (getenv("ShowNoteGraphRange"..pname(pn)) or 1) + 5
			local ShowNoteGraphData = (getenv("ShowNoteGraphData"..pname(pn)) or false)
			if ShowNoteGraph and ShowNoteGraph ~= 0 then
				list[ShowNoteGraph] = true
			else
				list[1] = true
			end
			if ShowNoteGraphType and ShowNoteGraphType ~= 0 then
				list[ShowNoteGraphType] = true
			else
				list[4] = true
			end
			if ShowNoteGraphRange and ShowNoteGraphRange ~= 0 then
				list[ShowNoteGraphRange] = true
			else
				list[6] = true
			end
			list[8] = ShowNoteGraphData
		end,
		SaveSelections = function() end,
		NotifyOfSelection= function(self, pn, choice)
			if choice <= 3 then
				setenv("ShowNoteGraph"..pname(pn),SaveUserPref(pn, "ShowNoteGraph", choice))
			elseif choice <= 5 then
				setenv("ShowNoteGraphType"..pname(pn),SaveUserPref(pn, "ShowNoteGraphType", choice-3))
			elseif choice <= 7 then
				setenv("ShowNoteGraphRange"..pname(pn),SaveUserPref(pn, "ShowNoteGraphRange", choice-5))
			else
				local ShowNoteGraphData = (getenv("ShowNoteGraphData"..pname(pn)) or false)
				setenv("ShowNoteGraphData"..pname(pn),SaveUserPref(pn, "ShowNoteGraphData", not ShowNoteGraphData))
			end
			return true
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

function OptionSongFrame()
	local t = {
		Name = "SongFrame",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "_bunnies", "_disconnect", "_energy", "_hasse", "_love", "_nightmare", "_normal", "_pandy", "_smiley", "_vertex", "_virtual" },
		Choices = { "Bunnies", "Disconnect", "Energy", "Hasse", "Love", "Nightmare", "Normal", "Pandy", "Smiley", "Vertex", "Virtual" },
		LoadSelections = function(self, list, pn)
			list[1] = getenv("SongFrame"..pname(pn)) == "_bunnies"
			list[2] = getenv("SongFrame"..pname(pn)) == "_disconnect"
			list[3] = getenv("SongFrame"..pname(pn)) == "_energy"
			list[4] = getenv("SongFrame"..pname(pn)) == "_hasse"
			list[5] = getenv("SongFrame"..pname(pn)) == "_love"
			list[6] = getenv("SongFrame"..pname(pn)) == "_nightmare"
			list[7] = getenv("SongFrame"..pname(pn)) == "_normal"
			list[8] = getenv("SongFrame"..pname(pn)) == "_pandy"
			list[9] = getenv("SongFrame"..pname(pn)) == "_smiley"
			list[10] = getenv("SongFrame"..pname(pn)) == "_vertex"
			list[11] = getenv("SongFrame"..pname(pn)) == "_virtual"
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("SongFrame"..pname(pn),SaveUserPref(pn, "SongFrame", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function DisplayCustomModifiersText(pn)
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
	if getenv("ShowStats"..pname(pn)) and getenv("ShowStats"..pname(pn)) > 0 then
		if GAMESTATE:GetNumPlayersEnabled() == 2 and not isDouble() then
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
	elseif getenv("ShowNoteGraph"..pname(pn)) and getenv("ShowNoteGraph"..pname(pn)) > 1 then
		output = addToOutput(output,"Show NoteGraph",", ")
	end

	if getenv("ScreenFilter"..pname(pn)) and getenv("ScreenFilter"..pname(pn)) > 0 then output = addToOutput(output,"Screen Filter ("..(getenv("ScreenFilter"..pname(pn))*100).."%)",", ") end

	function GetRateMod()
		local msrate = math.round(GAMESTATE:GetSongOptionsObject("ModsLevel_Song"):MusicRate(),1)
		if msrate == 1 then return '' else return msrate..'x Rate' end
	end

	if GetRateMod() ~= '' then output = addToOutput(output,GetRateMod(),", ") end

	return output
end