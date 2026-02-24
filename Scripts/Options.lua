function ChoiceSingle()
	if IsGame("dance") or IsGame("groove") then
		if isEtterna("0.70.1") then
			return {"single","threepanel"}
		else
			return {"single","solo","threepanel"}
		end
	elseif IsGame("solo") then
		return {"single"}
	elseif IsGame("pump") then
		return {"single",nil}
	elseif IsGame("smx") then
		return {"single",nil}
	elseif IsGame("be-mu") then
		return {"single5","single6","single7"}
	elseif IsGame("beat") then
		return {"single5","single7"}
	elseif IsGame("po-mu") then
		return {"po-mu-three","po-mu-four","po-mu-five","po-mu-seven","po-mu-nine"}
	elseif IsGame("popn") then
		return {"popn-five","popn-nine"}
	elseif IsGame("techno") then
		if isOutFox(20210300) then
			return {"single4","single5","single8","single9"}
		else
			return {"single4","single5","single8"}
		end
	end
end

function ChoiceVersus()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox(20220000) then
			return {"versus","solo-versus","threepanel-versus"}
		else
			return {"versus",nil,nil}
		end
	elseif IsGame("solo") then
		return {nil}
	elseif IsGame("pump") then
		return {"versus",nil}
	elseif IsGame("smx") then
		return {"versus",nil}
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
	elseif IsGame("popn") then
		return {nil,nil}
	elseif IsGame("techno") then
		if isOutFox(20210300) then
			return {"versus4","versus5","versus8","versus9"}
		else
			return {"versus4","versus5","versus8"}
		end
	end
end

function ChoiceDouble()
	if IsGame("dance") or IsGame("groove") then
		if isOutFox(20220000) then
			return {"double","solo-double","threepanel-double"}
		else
			return {"double",nil,nil}
		end
	elseif IsGame("solo") then
		return {nil}
	elseif IsGame("pump") then
		return {"double","halfdouble"}
	elseif IsGame("smx") then
		return {"double10","double6"}
	elseif IsGame("be-mu") then
		return {"double5","double6","double7"}
	elseif IsGame("beat") then
		return {"double5","double7"}
	elseif IsGame("po-mu") then
		return {nil,nil,nil,nil,VersionDateCheck(20210815) and "po-mu-nine-double" or nil}
	elseif IsGame("popn") then
		return {nil,nil}
	elseif IsGame("techno") then
		if isOutFox(20210300) then
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
	local output = ""
	if GameModeEnabled() then
		if ChoiceSingle()[GetUserPrefN("StylePosition")] then output = addToOutput(output,"1",",") end
		if not IsNetSMOnline() and ChoiceVersus()[GetUserPrefN("StylePosition")] then output = addToOutput(output,"2",",") end
		if ChoiceDouble()[GetUserPrefN("StylePosition")] then output = addToOutput(output,"3",",") end
	else
		return "0"
	end
	return output
end

function GetStylesWorkout()
	local output = ""
	if GameModeEnabled() then
		if ChoiceSingle()[GetUserPrefN("StylePosition")] then output = addToOutput(output,"1",",") end
		if ChoiceVersus()[GetUserPrefN("StylePosition")] then output = addToOutput(output,"2",",") end
		if ChoiceDouble()[GetUserPrefN("StylePosition")] then output = addToOutput(output,"3",",") end
	else
		return "0"
	end
	return output
end

function StyleName()
	if IsGame("dance") or IsGame("groove") then
		if isEtterna("0.70.1") then
			return {"4 Arrows","3 Arrows"}
		else
			return {"4 Arrows","6 Arrows","3 Arrows"}
		end
	elseif IsGame("solo") then
		return {"6 Arrows"}
	elseif IsGame("pump") then
		return {"5 Arrows","3 Arrows"}
	elseif IsGame("smx") then
		return {"5 Arrows","3 Arrows"}
	elseif IsGame("be-mu") then
		return {"5 Buttons + Turntable","Foot Pedal + 5 Buttons + Turntable","7 Buttons + Turntable"}
	elseif IsGame("beat") then
		return {"5 Buttons + Turntable","7 Buttons + Turntable"}
	elseif IsGame("po-mu") then
		return {"3 Buttons","4 Buttons","5 Buttons","7 Buttons","9 Buttons"}
	elseif IsGame("popn") then
		return {"5 Buttons","9 Buttons"}
	elseif IsGame("techno") then
		if isOutFox(20210300) then
			return {"4 Arrows","5 Arrows","8 Arrows","9 Arrows"}
		else
			return {"4 Arrows","5 Arrows","8 Arrows"}
		end
	end
	return false
end

function StepsTypeSingle()
	if IsGame("dance") or IsGame("groove") then
		if isEtterna("0.70.1") then
			return {"StepsType_Dance_Single","StepsType_Dance_Threepanel"}
		else
			return {"StepsType_Dance_Single","StepsType_Dance_Solo","StepsType_Dance_Threepanel"}
		end
	elseif IsGame("solo") then
		return {"StepsType_Dance_Solo"}
	elseif IsGame("pump") then
		return {"StepsType_Pump_Single",nil}
	elseif IsGame("smx") then
		return {"StepsType_Smx_Single",nil}
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
		if isOutFox(20220000) then
			return {"StepsType_Dance_Double","StepsType_Dance_Solodouble","StepsType_Dance_Threedouble"}
		else
			return {"StepsType_Dance_Double",nil,nil}
		end
	elseif IsGame("solo") then
		return {nil}
	elseif IsGame("pump") then
		return {"StepsType_Pump_Double","StepsType_Pump_HalfDouble"}
	elseif IsGame("smx") then
		return {"StepsType_Smx_Double10","StepsType_Smx_Double6"}
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

function SongMods(part)
	local add,add2 = "",isOutFoxV(20230624) and ",27" or ""

	if not isOni() then add = "20G," end

	local fail = isOutFoxV(20221111) and "FV" or "F"
	local options = ""

	if part == nil or part == 1 then
		options = addToOutput(options,(isEtterna() and "Speed," or "1,") .."2,4,"..fail..","..((isRegular() and VersionDateCheck(20160000)) and (isOpenDDR() and "0DDR" or "0,Flare") or "0")..",3",",")
		if not (IsGame("pump") or GAMESTATE:IsCourseMode()) then options = addToOutput(options,(IsGame("beat") or IsGame("be-mu")) and "IIDXFrame,IIDXDouble,IIDXJudgment" or "31",",") end
		if IIDXcheck() then options = addToOutput(options,"IIDXNote,IIDXNoteLength,IIDXBeam,IIDXBeamLength,IIDXExplosion,IIDXTurntable",",") end
		if not (IsGame("be-mu") or IsGame("beat") or IsGame("po-mu") or IsGame("popn")) then options = addToOutput(options,"32,32H",",") end
	end
	if part == nil or part == 2 then
		options = addToOutput(options,"5"..((isEtterna() or isOldStepMania()) and ",REE,AEE" or ",RE,RE2,AE,AE2,AE3")..(isOutFox() and ",AE4" or "")..",17,9",",")
	end

	if isRegular() then
		if part == nil or part == 3 then
			if isDouble() then options = addToOutput(options,"23",",") else options = addToOutput(options,"22,23",",") end
		end
		if part == nil or part == 2 then options = addToOutput(options,"10,11",",") end
	elseif isNonstop() then
		if part == nil or part == 3 then options = addToOutput(options,"22,23",",") end
	else
		if part == nil or part == 2 then options = addToOutput(options,"10,11",",") end
	end
	if part == nil or part == 2 then options = addToOutput(options,"12"..(isITGmania(20240317) and ",12ITG" or "")..",13,14,7,BGC,M,A,15",",") end
	if part == nil or part == 3 then
		options = addToOutput(options,"19,28,30,S,EB,CC,25",",")
		if isITGmania(20250327) then add2 = addToOutput(add2,",HLT",",") end
		if isITGmania(20220612) then add2 = addToOutput(add2,",DTW",",") end
		if isITGmania(20240307) then add2 = addToOutput(add2,",BB",",") end
		options = addToOutput(options,"20,"..add.."P,PF,29,21"..add2..",33",",")
	end

	if GAMESTATE:IsCourseMode() then
		if part == nil or part == 1 then options = "1,3" end
		if part == nil or part == 3 then
			if (GAMESTATE:GetNumPlayersEnabled() == 1 and not isDouble()) then
				if part == nil then options = addToOutput(options,"22R",",") elseif part == 3 then options = "22R" end
			end
		end
		if isVS() then
			if part == nil or part == 3 then options = addToOutput(options,"28,21"..add2..",33",",") end
		end
		if part == nil or part == 3 then options = addToOutput(options,"28,S,EB,CC,20,"..add.."P,PF,29,21"..add2..",33",",") end
	end

	if DoesDanceRepoExist() and (part == nil or part == 4) then
		options = addToOutput(options,"SelectDanceStage,OptionRowCharacters,CutInOverVideo,VideoOverStage,BoomSync,DiscoStars,RMStage,CharacterSync,CharaShadow,SNEnv",",")
	end

	if part == nil or part == 1 then options = addToOutput(options,"24,16",",") end
	if part == 1 then options = addToOutput(options,"After1",",") end
	if part == 2 then options = addToOutput(options,"After2",",") end
	if part == 3 then options = addToOutput(options,"After3",",") end
	if part == 4 then options = addToOutput(options,"After4",",") end
	return options
end

function ModeMenu()
	if isEtterna("0.55") and isEtterna("0.62") then return "Group,Title,Bpm,TopGrades,Artist,Genre,Favorites,Overall,Stream,Jumpstream,Handstream,Stamina,JackSpeed,Chordjack,Technical,Length,DateAdded,Author,Ungrouped" end
	local options = "Group,Title,Artist,Genre,Bpm,Length,"

	if isITGmania(20240225) then
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

	if isITGmania(20250304) then
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

function TitleMenu()
	local output = "01"
	if GameModeEnabled() then
		if ThemePrefs.Get("AllowBattle") then output = addToOutput(output,"02",",") end
		if ThemePrefs.Get("AllowMarathon") then output = addToOutput(output,"03",",") end
		if ThemePrefs.Get("AllowSurvival") then output = addToOutput(output,"04",",") end
		if ThemePrefs.Get("AllowFitness") then output = addToOutput(output,"05",",") end
		if ThemePrefs.Get("AllowJukebox") then output = addToOutput(output,"06",",") end
		if ThemePrefs.Get("AllowEdit") then output = addToOutput(output,"07",",") end
		if ThemePrefs.Get("AllowRecords") then output = addToOutput(output,"08",",") end
	else
		if ThemePrefs.Get("AllowBattle") then output = addToOutput(output,"02",",") end
		if ThemePrefs.Get("AllowMarathon") then output = addToOutput(output,"03",",") end
		if ThemePrefs.Get("AllowSurvival") then output = addToOutput(output,"04",",") end
		if ThemePrefs.Get("AllowFitness") then output = addToOutput(output,"05",",") end
		if ThemePrefs.Get("AllowEdit") then output = addToOutput(output,"07",",") end
	end
	output = addToOutput(output,"09,11",",")
	return output
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
				setenv("RotationP1",LoadUserPrefN(PLAYER_1, "Rotation", 5))
				setenv("RotationP2",LoadUserPrefN(PLAYER_2, "Rotation", 5))
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
	SetAllowLateJoin(true)

	if IsAutoStyle() then
		local style = split(",",GetAutoStyle())[1]
		for i,choice in ipairs(ChoiceSingle()) do if choice == style then SetUserPref("StylePosition",i) end end
		for i,choice in ipairs(ChoiceVersus()) do if choice == style then SetUserPref("StylePosition",i) end end
		for i,choice in ipairs(ChoiceDouble()) do if choice == style then SetUserPref("StylePosition",i) end end
	elseif GetUserPrefN("StylePosition") == nil then
		SetUserPref("StylePosition",1)
	elseif ChoiceSingle() and GetUserPrefN("StylePosition") > #ChoiceSingle() then
		SetUserPref("StylePosition",1)
	end

	local battle = ThemePrefs.Get("AutoBattle")
	if battle then setenv("BattleMode",battle) else setenv("BattleMode","rave") end
end

function InitPlayerOptions()
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		setenv("Flare"..pname(pn),(not isVS() and VersionDateCheck(20160000)) and LoadUserPrefN(pn, "Flare", tonumber(DefaultLuaModifiers["Flare"])) or 0)
		setenv("FlareFloat"..pname(pn),(not isVS() and VersionDateCheck(20160000)) and LoadUserPrefN(pn, "FlareFloat", tonumber(DefaultLuaModifiers["FlareFloat"])) or 0)
		setenv("FlareType"..pname(pn),(not isVS() and VersionDateCheck(20160000)) and LoadUserPrefN(pn, "FlareType", tonumber(DefaultLuaModifiers["FlareType"])) or 1)
		setenv("FlareAccurate"..pname(pn),(not isVS() and VersionDateCheck(20160000)) and LoadUserPrefB(pn, "FlareAccurate", tobool(DefaultLuaModifiers["FlareAccurate"])) or false)

		setenv("Effect"..pname(pn),not isVS() and LoadUserPrefN(pn, "Effect", tonumber(DefaultLuaModifiers["Effect"])) or 0)

		setenv("HideScore"..pname(pn),LoadUserPrefB(pn, "HideScore", tobool(DefaultLuaModifiers["HideScore"])) or false)
		setenv("HideJudgment"..pname(pn),LoadUserPrefB(pn, "HideJudgment", tobool(DefaultLuaModifiers["HideJudgment"])) or false)
		setenv("HideCombo"..pname(pn),LoadUserPrefB(pn, "HideCombo", tobool(DefaultLuaModifiers["HideCombo"])) or false)
		setenv("HideLife"..pname(pn),LoadUserPrefB(pn, "HideLife", tobool(DefaultLuaModifiers["HideLife"])) or false)

		setenv("UnderCombo"..pname(pn),LoadUserPrefB(pn, "UnderCombo", tobool(DefaultLuaModifiers["UnderCombo"])) or false)
		setenv("UnderTapJudgments"..pname(pn),LoadUserPrefB(pn, "UnderTapJudgments", tobool(DefaultLuaModifiers["UnderTapJudgments"])) or false)
		setenv("UnderHoldJudgments"..pname(pn),LoadUserPrefB(pn, "UnderHoldJudgments", tobool(DefaultLuaModifiers["UnderHoldJudgments"])) or false)

		setenv("ShowMovePlayerfieldStats"..pname(pn),LoadUserPrefN(pn, "ShowMovePlayerfieldStats", tonumber(DefaultLuaModifiers["ShowMovePlayerfieldStats"])) or 3)
		setenv("SetScoreType"..pname(pn),LoadUserPrefN(pn, "SetScoreType", tonumber(DefaultLuaModifiers["SetScoreType"])) or 2)
		setenv("ErrorBar"..pname(pn),LoadUserPrefN(pn, "ErrorBar", tonumber(DefaultLuaModifiers["ErrorBar"])) or 0)
		setenv("ShowColumns"..pname(pn),LoadUserPrefN(pn, "ShowColumns", tonumber(DefaultLuaModifiers["ShowColumns"])) or 0)
		if isITGmania(20240307) then setenv("BeatBars"..pname(pn),LoadUserPrefN(pn, "BeatBars", tonumber(DefaultLuaModifiers["BeatBars"])) or 0) end
		if (isOutFox(20210300) or isEtterna("0.50")) and GAMESTATE:GetCurrentGame():CountNotesSeparately() then
			if getenv("SetScoreType"..pname(pn)) == 7 then
				SCREENMAN:SystemMessage("WIFE3 is bugged if notes are counted separately! "..pname(pn).."'s ScoreType has been reset to Percent!")
				setenv("SetScoreType"..pname(pn),SaveUserPref(pn, "SetScoreType", 2) or 2)
			end
		end
		setenv("SetScoreDirection"..pname(pn),LoadUserPrefN(pn, "SetScoreDirection", tonumber(DefaultLuaModifiers["SetScoreDirection"])) or 1)
		setenv("SetScoreFA"..pname(pn),LoadUserPrefB(pn, "SetScoreFA", tobool(DefaultLuaModifiers["SetScoreFA"])) or false)
		setenv("ScreenFilter"..pname(pn),LoadUserPrefN(pn, "ScreenFilter", tonumber(DefaultLuaModifiers["ScreenFilter"])) or 0)

		setenv("ShowStats"..pname(pn),not isVS() and LoadUserPrefN(pn, "ShowStats", tonumber(DefaultLuaModifiers["ShowStats"])) or 0)
		setenv("ShowStatsSize"..pname(pn),not isVS() and LoadUserPrefN(pn, "ShowStatsSize", tonumber(DefaultLuaModifiers["ShowStatsSize"])) or 1)
		setenv("ShowStatsPos"..pname(pn),not isVS() and LoadUserPrefN(pn, "ShowStatsPos", tonumber(DefaultLuaModifiers["ShowStatsPos"])) or 0)
		setenv("PlayerNoteGraph"..pname(pn),not isVS() and LoadUserPrefN(pn, "PlayerNoteGraph", tonumber(DefaultLuaModifiers["PlayerNoteGraph"])) or 1)
		setenv("PlayerNoteGraphType"..pname(pn),not isVS() and LoadUserPrefN(pn, "PlayerNoteGraphType", tonumber(DefaultLuaModifiers["PlayerNoteGraphType"])) or 2)
		setenv("PlayerNoteGraphRange"..pname(pn),not isVS() and LoadUserPrefN(pn, "PlayerNoteGraphRange", tonumber(DefaultLuaModifiers["PlayerNoteGraphRange"])) or 1)
		setenv("PlayerNoteGraphData"..pname(pn),not isVS() and LoadUserPrefB(pn, "PlayerNoteGraphData", tobool(DefaultLuaModifiers["PlayerNoteGraphData"])) or false)
		setenv("SetPacemaker"..pname(pn),not isVS() and LoadUserPrefN(pn, "SetPacemaker", tonumber(DefaultLuaModifiers["SetPacemaker"])) or 0)
		setenv("SetPacemakerFail"..pname(pn),not isVS() and LoadUserPrefN(pn, "SetPacemakerFail", tonumber(DefaultLuaModifiers["SetPacemakerFail"])) or 0)

		setenv("ShowMods"..pname(pn),LoadUserPrefB(pn, "ShowMods", tobool(DefaultLuaModifiers["ShowMods"])) or false)
		setenv("ShowSpeedAssist"..pname(pn),LoadUserPrefB(pn, "ShowSpeedAssist", tobool(DefaultLuaModifiers["ShowSpeedAssist"])) or false)
		setenv("ShowStopAssist"..pname(pn),LoadUserPrefB(pn, "ShowStopAssist", tobool(DefaultLuaModifiers["ShowStopAssist"])) or false)
		setenv("SongFrame"..pname(pn),LoadUserPref(pn, "SongFrame", DefaultLuaModifiers["SongFrame"]) or "_normal")
		setenv("HoldJudgment"..pname(pn),LoadUserPref(pn, "HoldJudgment", DefaultLuaModifiers["HoldJudgment"]) or "_itg3")
		setenv("Judgment"..pname(pn),LoadUserPref(pn, "Judgment", DefaultLuaModifiers["Judgment"]) or "_itg3")
		setenv("GreenNumber"..pname(pn),LoadUserPrefB(pn, "GreenNumber", tobool(DefaultLuaModifiers["Effect"])) or false)

		setenv("IIDXFrame"..pname(pn),LoadUserPref(pn, "IIDXFrame", DefaultLuaModifiers["IIDXFrame"]) or "_random")
		setenv("IIDXDouble"..pname(pn),LoadUserPrefB(pn, "IIDXDouble", tobool(DefaultLuaModifiers["IIDXDouble"])) or false)
		setenv("IIDXJudgment"..pname(pn),LoadUserPref(pn, "IIDXJudgment", DefaultLuaModifiers["IIDXJudgment"]) or "default")
		setenv("IIDXNote"..pname(pn),LoadUserPref(pn, "IIDXNote", DefaultLuaModifiers["IIDXNote"]) or "default")
		setenv("IIDXNoteLength"..pname(pn),LoadUserPref(pn, "IIDXNoteLength", DefaultLuaModifiers["IIDXNoteLength"]) or "normal")
		setenv("IIDXBeam"..pname(pn),LoadUserPref(pn, "IIDXBeam", DefaultLuaModifiers["IIDXBeam"]) or "default")
		setenv("IIDXBeamLength"..pname(pn),LoadUserPref(pn, "IIDXBeamLength", DefaultLuaModifiers["IIDXBeamLength"]) or "normal")
		setenv("IIDXTurntable"..pname(pn),LoadUserPref(pn, "IIDXTurntable", DefaultLuaModifiers["IIDXTurntable"]) or "_default")
		setenv("IIDXExplosion"..pname(pn),LoadUserPref(pn, "IIDXExplosion", DefaultLuaModifiers["IIDXExplosion"]) or "_default")
	end

end

function OptionFlare()
	local t = {
		Name="Flare",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Off","F1","F2","F3","F4","F5","F6","F7","F8","F9","FX","F+","Old","New","Accurate" },
		LoadSelections = function(self, list, pn)
			local flare = getenv("Flare"..pname(pn))
			local flareFloat = getenv("FlareFloat"..pname(pn))
			local flareType = getenv("FlareType"..pname(pn))
			local flareAccurate = getenv("FlareAccurate"..pname(pn))
			list[flare+1] = true
			if flareFloat then list[12] = true end
			list[flareType+12] = true
			if flareAccurate then list[15] = true end
		end,
		SaveSelections = function() end,
		NotifyOfSelection= function(self, pn, choice)
			if choice <= 11 then
				setenv("Flare"..pname(pn),SaveUserPref(pn, "Flare", choice-1))
			elseif choice == 12 then
				local flareFloat = (getenv("FlareFloat"..pname(pn)) or false)
				setenv("FlareFloat"..pname(pn),SaveUserPref(pn, "FlareFloat", not flareFloat))
			elseif choice <= 14 then
				setenv("FlareType"..pname(pn),SaveUserPref(pn, "FlareType", choice-12))
			else
				local flareAccurate = (getenv("FlareAccurate"..pname(pn)) or false)
				setenv("FlareAccurate"..pname(pn),SaveUserPref(pn, "FlareAccurate", not flareAccurate))
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
			for i=1,#list do
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
		Choices = { "Hide Score", "Hide Judgment", "Hide Combo", "Hide Lifebar" },
		LoadSelections = function(self, list, pn)
			list[1] = getenv("HideScore"..pname(pn))
			list[2] = getenv("HideJudgment"..pname(pn))
			list[3] = getenv("HideCombo"..pname(pn))
			list[4] = getenv("HideLife"..pname(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("HideScore"..pname(pn),SaveUserPref(pn, "HideScore", list[1]))
			setenv("HideJudgment"..pname(pn),SaveUserPref(pn, "HideJudgment", list[2]))
			setenv("HideCombo"..pname(pn),SaveUserPref(pn, "HideCombo", list[3]))
			setenv("HideLife"..pname(pn),SaveUserPref(pn, "HideLife", list[4]))
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

function OptionMovePlayerfieldStats()
	local t = {
		Name="MovePlayerfieldStats",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Near","Near|Center","Center","Center|Far","Far" },
		LoadSelections = function(self, list, pn)
			local selected = getenv("ShowMovePlayerfieldStats"..pname(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("ShowMovePlayerfieldStats"..pname(pn),SaveUserPref(pn, "ShowMovePlayerfieldStats", i))
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
		if etterna or (not etterna and (isOutFox(20210300) and GAMESTATE:GetCurrentGame():CountNotesSeparately())) then
			return { "Score","Percent","EX","SN2","IIDX","POPN","Additive","Subtractive" }
		else
			return { "Score","Percent","EX","SN2","IIDX","POPN","WIFE3","Additive","Subtractive" }
		end
	end

	local options = GetScoreTypes(isEtterna("0.50"))
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

function OptionErrorBar()
	function Range()
		if isOpenDDR() then
			return { "Off","Fantastic","Excellent","Great","Decent","Miss" }
		else
			return { "Off","Fantastic","Excellent","Great","Decent","Way Off","Miss" }
		end
	end
	local t = {
		Name="ErrorBar",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = Range(),
		LoadSelections = function(self, list, pn)
			local selected = (getenv("ErrorBar"..pname(pn)) or 0) + 1
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("ErrorBar"..pname(pn),SaveUserPref(pn, "ErrorBar", i-1))
					break
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionDisableTimingWindow()
	local t = {
		Name="DisableTimingWindow",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Fantastic","Excellent","Great","Decent","Way Off" },
		LoadSelections = function(self, list, pn)
			local windows = {true,true,true,true,true}
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
			local disabledWindows = playeroptions:GetDisabledTimingWindows()

			for w in ivalues(disabledWindows) do windows[tonumber(ToEnumShortString(w):sub(-1))] = false end
			for i=1,#list do list[i] = not windows[i] end
		end,
		SaveSelections = function(self, list, pn)
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
			playeroptions:ResetDisabledTimingWindows()

			for i=1,#list do
				if list[i] then playeroptions:DisableTimingWindow("TimingWindow_W"..i) end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function NumberToBits(num,bits)
    bits = bits or math.max(1, select(2, math.frexp(num)))
    local t = {}    
    for b = bits, 1, -1 do
        t[b] = math.fmod(num, 2)
        num = math.floor((num - t[b]) / 2)
		t[b] = t[b] == 1
    end
    return t
end

function OptionShowColumns()
	function Range()
		if isOpenDDR() then
			return { "Preview","Miss","Decent","Great","Excellent","Fantastic" }
		else
			return { "Preview","Miss","Way Off","Decent","Great","Excellent","Fantastic" }
		end
	end
	local t = {
		Name="ShowColumns",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = Range(),
		LoadSelections = function(self, list, pn)
			local bits = NumberToBits(getenv("ShowColumns"..pname(pn)) or 0,isOpenDDR() and 6 or 7)
			for i=1,#list do list[i] = bits[8-i] end
		end,
		SaveSelections = function(self, list, pn)
			local total = 0
			for i=1,#list do if list[i] then total = total + math.pow(2,i-1) end end
			setenv("ShowColumns"..pname(pn),SaveUserPref(pn, "ShowColumns", total))
		end
	}
	setmetatable(t, t)
	return t
end

function OptionBeatBars()
	local t = {
		Name="BeatBars",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Measure","Quarter","Eighth","Sixteenth" },
		LoadSelections = function(self, list, pn)
			local bits = NumberToBits(getenv("BeatBars"..pname(pn)) or 0,4)
			for i=1,#list do list[i] = bits[5-i] end
		end,
		SaveSelections = function(self, list, pn)
			local total = 0
			for i=1,#list do if list[i] then total = total + math.pow(2,i-1) end end
			setenv("BeatBars"..pname(pn),SaveUserPref(pn, "BeatBars", total))
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
	if not (IsGame("beat") or IsGame("be-mu")) then
		options[#options+1] = "Full"
		options[#options+1] = "Mini (Bottom)"
		options[#options+1] = "Mini (Top)"
	else
		options[#options+1] = "Full"
		options[#options+1] = "Mini"
	end

	local t = {
		Name="PlayerStats",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = options,
		LoadSelections = function(self, list, pn)
			local showStats = (getenv("ShowStats"..pname(pn)) or 0) + 1
			local showStatsSize = (getenv("ShowStatsSize"..pname(pn)) or 0) + (getenv("ShowStatsPos"..pname(pn)) or 0)
			list[showStats] = true
			if not (IsGame("beat") or IsGame("be-mu")) then
				if showStatsSize and showStatsSize ~= 0 then
					list[showStatsSize+#self.Choices-3] = true
				else
					list[#self.Choices-2] = true
				end
			else
				list[showStatsSize+#self.Choices-2] = true
			end
		end,
		SaveSelections = function() end,
		NotifyOfSelection= function(self, pn, choice)
			if choice <= #self.Choices-3 then
				setenv("ShowStats"..pname(pn),SaveUserPref(pn, "ShowStats", choice-1))
			else
				if not (IsGame("beat") or IsGame("be-mu")) then
					setenv("ShowStatsSize"..pname(pn),SaveUserPref(pn, "ShowStatsSize", math.min(2,choice-#self.Choices+3)))
					setenv("ShowStatsPos"..pname(pn),SaveUserPref(pn, "ShowStatsPos", math.max(0,choice-#self.Choices+1)))
				else
					setenv("ShowStatsSize"..pname(pn),SaveUserPref(pn, "ShowStatsSize", math.min(2,choice-#self.Choices+2)))
				end
			end
			return true
		end
	}
	setmetatable(t, t)
	return t
end

function OptionPlayerNoteGraph()
	local t = {
		Name="PlayerNoteGraph",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Off","Normal","SPS","One","All","Fixed","Adjusted","Show Data" },
		LoadSelections = function(self, list, pn)
			local PlayerNoteGraph = (getenv("PlayerNoteGraph"..pname(pn)) or 1)
			local PlayerNoteGraphType = (getenv("PlayerNoteGraphType"..pname(pn)) or 1) + 3
			local PlayerNoteGraphRange = (getenv("PlayerNoteGraphRange"..pname(pn)) or 1) + 5
			local PlayerNoteGraphData = (getenv("PlayerNoteGraphData"..pname(pn)) or false)
			if PlayerNoteGraph and PlayerNoteGraph ~= 0 then
				list[PlayerNoteGraph] = true
			else
				list[1] = true
			end
			if PlayerNoteGraphType and PlayerNoteGraphType ~= 0 then
				list[PlayerNoteGraphType] = true
			else
				list[4] = true
			end
			if PlayerNoteGraphRange and PlayerNoteGraphRange ~= 0 then
				list[PlayerNoteGraphRange] = true
			else
				list[6] = true
			end
			list[8] = PlayerNoteGraphData
		end,
		SaveSelections = function() end,
		NotifyOfSelection= function(self, pn, choice)
			if choice <= 3 then
				setenv("PlayerNoteGraph"..pname(pn),SaveUserPref(pn, "PlayerNoteGraph", choice))
			elseif choice <= 5 then
				setenv("PlayerNoteGraphType"..pname(pn),SaveUserPref(pn, "PlayerNoteGraphType", choice-3))
			elseif choice <= 7 then
				setenv("PlayerNoteGraphRange"..pname(pn),SaveUserPref(pn, "PlayerNoteGraphRange", choice-5))
			else
				local PlayerNoteGraphData = (getenv("PlayerNoteGraphData"..pname(pn)) or false)
				setenv("PlayerNoteGraphData"..pname(pn),SaveUserPref(pn, "PlayerNoteGraphData", not PlayerNoteGraphData))
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
			for i=1,#list do
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

function OptionSetPacemakerFail()
	local t = {
		Name="SetPacemakerFail",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Off","Restart","Fail" },
		LoadSelections = function(self, list, pn)
			local selected = getenv("SetPacemakerFail"..pname(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("SetPacemakerFail"..pname(pn),SaveUserPref(pn, "SetPacemakerFail", i))
					break
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionPlayerAssists()
	local t = {
		Name="PlayerAssists",
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

function OptionPlayerModifiers()
	local t = {
		Name="PlayerModifiers",
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
			for i=1,#list do
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
		Values = { "_bunnies", "_disconnect", "_energy", "_hasse", "_love", "_nightmare", "_normal", "_pandy", "_smiley", "_vertex0", "_vertex1", "_vertex2", "_vertex3", "_virtual", "_random" },
		Choices = { "Bunnies", "Disconnect", "Energy", "Hasse", "Love", "Nightmare", "Normal", "Pandy", "Smiley", "Vertex Base", "Vertex¹", "Vertex²", "Vertex³", "Virtual", "Random" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("SongFrame"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("SongFrame"..pname(pn),SaveUserPref(pn, "SongFrame", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionIIDXFrame()
	local t = {
		Name = "IIDXFrame",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "_10th", "_red", "_happysky", "_distorted", "_gold", "_troopers", "_empress", "_sirius", "_resortanthem", "random" },
		Choices = { "10th Style", "Red", "Happy Sky", "Distorted", "Gold", "DJ Troopers", "Empress", "Sirius", "Resort Anthem", "Random" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("IIDXFrame"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("IIDXFrame"..pname(pn),SaveUserPref(pn, "IIDXFrame", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionIIDXDouble()
	local t = {
		Name="IIDXDouble",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { false, true, },
		Choices = { "Off", "On" },
		LoadSelections = function(self, list, pn)
			list[1] = not getenv("IIDXDouble"..pname(pn))
			list[2] = getenv("IIDXDouble"..pname(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("IIDXDouble"..pname(pn),SaveUserPref(pn, "IIDXDouble", list[2]))
		end
	}
	setmetatable(t, t)
	return t
end

function IIDXcheck()
	local notes = NOTESKIN:GetNoteSkinNames()
	for i=1,#notes do
		if notes[i] == "iidx-ac" then return true end
	end
	return false
end

function OptionIIDXJudgment()
	local t = {
		Name = "IIDXJudgment",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "default", "digital", "smart", "metallicblue", "techno", "wire", "abyss", "spada", "ancient", "onlyonejudge", "dotmatrix", "sinobuz", "segment", "rootage", "heroicverse", "bistrover", "casthour", "resident", "epolis", "pinkycrush", "random" },
		Choices = { "Default", "Digital", "Smart", "Metallic Blue", "Techno", "Wire", "Abyss", "Spada", "Ancient", "Only One Judge", "Dot Matrix", "Sinobuz", "Segment", "Rootage", "Heroic Verse", "Bistrover", "CastHour", "Resident", "Epolis", "Pinky Crush", "Random" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("IIDXJudgment"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("IIDXJudgment"..pname(pn),SaveUserPref(pn, "IIDXJudgment", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function IIDXNoteskinCheck(player)
	local noteskin = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):NoteSkin()
	return noteskin == "iidx-ac"
end

function OptionIIDXBeam()
	local t = {
		Name = "IIDXBeam",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "none", "default", "orange", "pink", "monochrome", "onlyonebeam", "copula", "cannonballers", "heroicverse", "bistrover", "fresnelbeam", "resident", "epolis", "pinkycrush", "random" },
		Choices = { "None", "Default", "Orange", "Pink", "Monochrome", "Only One Beam", "Copula", "Cannon Ballers", "Heroic Verse", "Bistrover", "Fresnel Beam", "Resident", "Epolis", "Pinky Crush", "Random" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("IIDXBeam"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("IIDXBeam"..pname(pn),SaveUserPref(pn, "IIDXBeam", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionIIDXBeamLength()
	local t = {
		Name = "IIDXBeamLength",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "long", "normal", "short", "veryshort", "random" },
		Choices = { "Long", "Normal", "Short", "Very Short", "Random" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("IIDXBeamLength"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("IIDXBeamLength"..pname(pn),SaveUserPref(pn, "IIDXBeamLength", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionIIDXNote()
	local t = {
		Name = "IIDXNote",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "default", "gorgeous", "aqua", "gyaru", "photon", "pastel", "simplecolor", "light", "tricoro", "bubble", "random" },
		Choices = { "Default", "Gorgeous", "Aqua", "Gyaru", "Photon", "Pastel", "Simple Color", "Light", "Tricoro", "Bubble", "Random" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("IIDXNote"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("IIDXNote"..pname(pn),SaveUserPref(pn, "IIDXNote", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionIIDXNoteLength()
	local t = {
		Name = "IIDXNoteLength",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "long", "normal", "short", "veryshort", "random" },
		Choices = { "Long", "Normal", "Short", "Very Short", "Random" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("IIDXNoteLength"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("IIDXNoteLength"..pname(pn),SaveUserPref(pn, "IIDXNoteLength", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionIIDXExplosion()
	local t = {
		Name = "IIDXExplosion",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "_default", "_1st", "_9th", "_red", "_happysky", "_distorted", "_gold", "_troopers", "_empress", "_sirius", "_resortanthem", "_lincle", "_tricoro", "_spada", "_onlyonebomb", "_pendual", "_copula", "_sinobuz", "_cannonballers", "_rootage", "_heroicverse", "_bistrover", "_likeflash", "_resident", "_epolis", "_pinkycrush", "_sparkleshower", "random" },
		Choices = { "Default", "1st", "9th", "Red", "Happy Sky", "Distorted", "Gold", "DJ Troopers", "Empress", "Sirius", "Resort Anthem", "Lincle", "Tricoro", "Spada", "Only One Bomb", "Pendual", "Copula", "Sinobuz", "Cannon Ballers", "Rootage", "Heroic Verse", "Bistrover", "Like Flash", "Resident", "Epolis", "Pinky Crush", "Sparkle Shower", "Random" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("IIDXExplosion"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("IIDXExplosion"..pname(pn),SaveUserPref(pn, "IIDXExplosion", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionIIDXTurntable()
	local t = {
		Name = "IIDXTurntable",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "_default", "_tran", "_jojo", "_delta", "_orangedisc", "_distorted", "_gold", "_troopers", "_empress", "_sirius", "_resortanthem", "_lincle", "_tricoro", "_spada", "_shakunetsu", "_onlyonerecord", "_pendual", "_copula", "_sinobuz", "_cannonballers", "_rootage", "_heroicverse", "_casthour", "_resident", "_strawberry", "_epolis", "_pinkycrush", "random" },
		Choices = { "Default", "Tran", "Jojo", "Delta", "Orange Disc", "Distorted", "Gold", "Dj Troopers", "Empress", "Sirius", "Resort Anthem", "Lincle", "Tricoro", "Spada", "Shakunetsu", "Only One Record", "Pendual", "Copula", "Sinobuz", "Cannon Ballers", "Rootage", "Heroic Verse", "CastHour", "Resident", "Strawberry", "Epolis", "Pinky Crush", "Random" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("IIDXTurntable"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("IIDXTurntable"..pname(pn),SaveUserPref(pn, "IIDXTurntable", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionHoldJudgment()
	local t = {
		Name = "HoldJudgment",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "_itg3", "_itg3_chroma", "_itg2", "_itg2_chroma" },
		Choices = { "ITG3", "ITG3 Chroma", "ITG2", "ITG2 Chroma" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("HoldJudgment"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("HoldJudgment"..pname(pn),SaveUserPref(pn, "HoldJudgment", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionJudgment()
	local t = {
		Name = "Judgment",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Values = { "_itg3", "_itg3_chroma", "_itg2", "_itg2_chroma", "_itg1", "_itg1_chroma" },
		Choices = { "ITG3", "ITG3 Chroma", "ITG2", "ITG2 Chroma", "ITG1", "ITG1 Chroma" },
		LoadSelections = function(self, list, pn)
			for i=1,#list do
				list[i] = getenv("Judgment"..pname(pn)) == self.Values[i]
			end
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("Judgment"..pname(pn),SaveUserPref(pn, "Judgment", self.Values[i]))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function OptionGreenNumber()
	local t = {
		Name = "GreenNumber",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Off", "On" },
		LoadSelections = function(self, list, pn)
			list[1] = getenv("GreenNumber"..pname(pn)) == false
			list[2] = getenv("GreenNumber"..pname(pn)) == true
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("GreenNumber"..pname(pn),SaveUserPref(pn, "GreenNumber", i==2))
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function ScreenAfterPlayerOptions(part)
	local p1 = part==2 or part==3 or part==4
	local p2 = part==2 or part==3 or part==4
	local p3 = part==2 or part==3 or part==4
	local p4 = part==2 or part==3 or part==4
	local choices = { "Gameplay", "SelectMusic" }
	local values = {}
	if part ~= 1 then choices[#choices+1] = "Options1" end
	if part ~= 2 and not GAMESTATE:IsCourseMode() then choices[#choices+1] = "Options2" end
	if part ~= 3 then choices[#choices+1] = "Options3" end
	local xms = IsGame("beat") or IsGame("be-mu") or IsGame("popn") or IsGame("po-mu")
	if part ~= 4 and not xms and DoesDanceRepoExist() then choices[#choices+1] = "Options4" end

	local screens = {
		["Gameplay"] = Branch.BeforeGameplay(),
		["SelectMusic"] = SelectMusicOrCourse(),
		["Options1"] = "ScreenPlayerOptions",
		["Options2"] = "ScreenPlayerOptions2",
		["Options3"] = "ScreenPlayerOptions3",
		["Options4"] = "ScreenPlayerOptions4"
	}
	local engine = isOutFox() and "OutFox" or isStepMania() and "StepMania" or isITGmania() and "ITGmania" or isEtterna() and "Etterna" or isOpenDDR() and "DDR" or "Engine"
	local names = {
		["Gameplay"] = "Gameplay",
		["SelectMusic"] = "SelectMusic",
		["Options1"] = "GameOptions" ,
		["Options2"] = engine.."Options",
		["Options3"] = "LuaOptions",
		["Options4"] = "DanceStageOptions"
	}
	for i=1,#choices do
		if choices[i] then
			values[i] = names[choices[i]]
		end
	end

	local t = {
		Name = "AfterPlayerOptions",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		Choices = values,
		LoadSelections = function(self, list, pn)
			list[1] = true
			setenv("PlayerOptions",screens[choices[1]])
		end,
		SaveSelections = function(self, list, pn)
			for i=1,#list do
				if list[i] then
					setenv("PlayerOptions",screens[choices[i]])
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

	if getenv("HideScore"..pname(pn)) and getenv("HideLife"..pname(pn)) and getenv("HideCombo"..pname(pn)) and getenv("HideJudgment"..pname(pn)) then
		output = addToOutput(output,"Hide All",", ")
	else
		if getenv("HideScore"..pname(pn)) then output = addToOutput(output,"Hide Score",", ") end
		if getenv("HideLife"..pname(pn)) then output = addToOutput(output,"Hide Life",", ") end
		if getenv("HideCombo"..pname(pn)) then output = addToOutput(output,"Hide Combo",", ") end
		if getenv("HideJudgment"..pname(pn)) then output = addToOutput(output,"Hide Judgment",", ") end
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
			if getenv("PlayerNoteGraph"..pname(pn)) > 1 then
				output = addToOutput(output,"Show Stats",", ")
			else
				output = addToOutput(output,"Show Stats & NoteGraph",", ")
			end
		elseif getenv("ShowStatsSize"..pname(pn)) == 1 then
			if getenv("PlayerNoteGraph"..pname(pn)) > 1 then
				output = addToOutput(output,"Show FullStats",", ")
			else
				output = addToOutput(output,"Show FullStats & NoteGraph",", ")
			end
		elseif getenv("ShowStatsSize"..pname(pn)) == 2 then
			if getenv("PlayerNoteGraph"..pname(pn)) > 1 then
				output = addToOutput(output,"Show MiniStats",", ")
			else
				output = addToOutput(output,"Show MiniStats & NoteGraph",", ")
			end
		end
	elseif getenv("PlayerNoteGraph"..pname(pn)) and getenv("PlayerNoteGraph"..pname(pn)) > 1 then
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