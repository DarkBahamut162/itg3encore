function ChoiceSingle()
	if IsGame("be-mu") then
		return "single7"
	elseif IsGame("po-mu") then
		return "po-mu-nine"
	else
		return "single"
	end
end

function ChoiceVersus()
	if IsGame("be-mu") then
		return "versus7"
	elseif IsGame("po-mu") then
		return "po-mu-nine-versus"
	else
		return "versus"
	end
end

function ChoiceDouble()
	if IsGame("be-mu") then
		return "double7"
	elseif IsGame("po-mu") then
		return "po-mu-nine-double"
	elseif IsGame("smx") then
		return "double10"
	else
		return "double"
	end
end

function SongMods()
	local style = GAMESTATE:GetCurrentStyle()
	local styleType = style:GetStyleType()
	local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')

	local options = "1,2,4,F,3,5,RE,AE,17,9,"

	if isRegular() then
		if doubles then
			options = options .. "23,10,11,"
		else
			options = options .. "22,23,10,11,"
		end
	elseif isNonstop() then
		options = options .. "22,23,"
	else
		options = options .. "10,11,"
	end

	options = options .. "12,13,14,7,BGC,M,A,15,19,28,S,25,"

	-- differences 2 (should be "27,24," but timingscale is not in sm5)
	if isRegular() then
		if HasLuaCheck() then
			options = options .. "20,P,21,24,"
		else
			options = options .. "20,P,24,"
		end
	elseif isNonstop() then
		if IsCourseSecret() then
			options = options .. "20,P,24,"
		else
			options = options .. "20,P,21,24,"
		end
	end

	if isRave() or (isOni() and not isLifeline(GAMESTATE:GetMasterPlayerNumber())) then
		options = "1,3,28,20,P,21,"
	elseif isOni() then
		options = "1,3,28,S,20,P,21,"
	end

	options = options .. "16"
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
end

function InitOptions()
	GAMESTATE:SetFailTypeExplicitlySet(true)
	setenv("HighScoreableP1",false)
	setenv("HighScoreableP2",false)

	setenv("UnderComboP1",false)
	setenv("UnderComboP2",false)
	setenv("UnderTapJudgmentsP1",false)
	setenv("UnderTapJudgmentsP2",false)
	setenv("UnderHoldJudgmentsP1",false)
	setenv("UnderHoldJudgmentsP2",false)

	setenv("HideScoreP1",false)
	setenv("HideScoreP2",false)
	setenv("HideLifeP1",false)
	setenv("HideLifeP2",false)
	setenv("HideComboP1",false)
	setenv("HideComboP2",false)

	setenv("RotationLeftP1",false)
	setenv("RotationRightP1",false)
	setenv("RotationUpsideDownP1",false)
	setenv("RotationLeftP2",false)
	setenv("RotationRightP2",false)
	setenv("RotationUpsideDownP2",false)

	setenv("EffectWagP1",false)
	setenv("EffectPulseP1",false)
	setenv("EffectBounceP1",false)
	setenv("EffectSpinReverseP1",false)
	setenv("EffectSpinP1",false)
	setenv("EffectVibrateP1",false)
	setenv("EffectWagP2",false)
	setenv("EffectPulseP2",false)
	setenv("EffectBounceP2",false)
	setenv("EffectSpinReverseP2",false)
	setenv("EffectSpinP2",false)
	setenv("EffectVibrateP2",false)

	setenv("ShowModsP1",false)
	setenv("ShowModsP2",false)

	setenv("SetScoreTypeP1",2)
	setenv("SetScoreTypeP2",2)

	setenv("ShowStatsP1",0)
	setenv("ShowStatsP2",0)
	setenv("SetPacemakerP1",0)
	setenv("SetPacemakerP2",0)

	setenv("ScreenFilterP1",0)
	setenv("ScreenFilterP2",0)
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
			list[1] = getenv("UnderCombo"..ToEnumShortString(pn))
			list[2] = getenv("UnderTapJudgments"..ToEnumShortString(pn))
			list[3] = getenv("UnderHoldJudgments"..ToEnumShortString(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("UnderCombo"..ToEnumShortString(pn),list[1])
			setenv("UnderTapJudgments"..ToEnumShortString(pn),list[2])
			setenv("UnderHoldJudgments"..ToEnumShortString(pn),list[3])
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
			list[1] = getenv("HideScore"..ToEnumShortString(pn))
			list[2] = getenv("HideCombo"..ToEnumShortString(pn))
			list[3] = getenv("HideLife"..ToEnumShortString(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("HideScore"..ToEnumShortString(pn),list[1])
			setenv("HideCombo"..ToEnumShortString(pn),list[2])
			setenv("HideLife"..ToEnumShortString(pn),list[3])
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
			local selected = getenv("SetScoreType"..ToEnumShortString(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("SetScoreType"..ToEnumShortString(pn),i)
					break
				end
			end
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
			local selected = getenv("ShowStats"..ToEnumShortString(pn))+1
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("ShowStats"..ToEnumShortString(pn),i-1)
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
		Choices = {'C-','C','C+','B-','B','B+','A-','A','A+','S-','S','S+','★','★★','★★★','★★★★'},
		LoadSelections = function(self, list, pn)
			local selected = getenv("SetPacemaker"..ToEnumShortString(pn))
			if selected and selected ~= 0 then
				list[selected] = true
			else
				list[11] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("SetPacemaker"..ToEnumShortString(pn),i)
					break
				end
			end
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
			list[1] = getenv("ShowMods"..ToEnumShortString(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("ShowMods"..ToEnumShortString(pn),list[1])
		end
	}
	setmetatable(t, t)
	return t
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
			list[1] = getenv("RotationNormal"..ToEnumShortString(pn))
			list[2] = getenv("RotationLeft"..ToEnumShortString(pn))
			list[3] = getenv("RotationRight"..ToEnumShortString(pn))
			list[4] = getenv("RotationUpsideDown"..ToEnumShortString(pn))
			if GAMESTATE:GetNumPlayersEnabled() == 1 then list[5] = getenv("RotationSolo"..ToEnumShortString(pn)) end
		end,
		SaveSelections = function(self, list, pn)
			setenv("RotationNormal"..ToEnumShortString(pn),list[1])
			setenv("RotationLeft"..ToEnumShortString(pn),list[2])
			setenv("RotationRight"..ToEnumShortString(pn),list[3])
			setenv("RotationUpsideDown"..ToEnumShortString(pn),list[4])
			if GAMESTATE:GetNumPlayersEnabled() == 1 then setenv("RotationSolo"..ToEnumShortString(pn),list[5]) end
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
			list[1] = getenv("EffectVibrate"..ToEnumShortString(pn))
			list[2] = getenv("EffectSpin"..ToEnumShortString(pn))
			list[3] = getenv("EffectSpinReverse"..ToEnumShortString(pn))
			list[4] = getenv("EffectBounce"..ToEnumShortString(pn))
			list[5] = getenv("EffectPulse"..ToEnumShortString(pn))
			list[6] = getenv("EffectWag"..ToEnumShortString(pn))
		end,
		SaveSelections = function(self, list, pn)
			setenv("EffectVibrate"..ToEnumShortString(pn),list[1])
			setenv("EffectSpin"..ToEnumShortString(pn),list[2])
			setenv("EffectSpinReverse"..ToEnumShortString(pn),list[3])
			setenv("EffectBounce"..ToEnumShortString(pn),list[4])
			setenv("EffectPulse"..ToEnumShortString(pn),list[5])
			setenv("EffectWag"..ToEnumShortString(pn),list[6])
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
			local filterValue = getenv("ScreenFilter"..ToEnumShortString(pn))
			if filterValue ~= nil then
				local val = filterValue*10+1
				list[val] = true
			else
				setenv("ScreenFilter"..ToEnumShortString(pn),0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = 0
			for i=1,#list do
				if list[i] then val = (i-1)/10 end
			end
			setenv("ScreenFilter"..ToEnumShortString(pn),val)
		end
	}
	setmetatable(t, t)
	return t
end

function GetRateModHelper( rate )
	local msrate = string.format( "%.1f", GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate() )

	return msrate == rate
end

function GetRateMod()
	if GetRateModHelper('1.0') then return ''
	elseif GetRateModHelper('0.5') then return '0.5x Rate'
	elseif GetRateModHelper('0.6') then return '0.6x Rate'
	elseif GetRateModHelper('0.7') then return '0.7x Rate'
	elseif GetRateModHelper('0.8') then return '0.8x Rate'
	elseif GetRateModHelper('0.9') then return '0.9x Rate'
	elseif GetRateModHelper('1.1') then return '1.1x Rate'
	elseif GetRateModHelper('1.2') then return '1.2x Rate'
	elseif GetRateModHelper('1.3') then return '1.3x Rate'
	elseif GetRateModHelper('1.4') then return '1.4x Rate'
	elseif GetRateModHelper('1.5') then return '1.5x Rate'
	elseif GetRateModHelper('1.6') then return '1.6x Rate'
	elseif GetRateModHelper('1.7') then return '1.7x Rate'
	elseif GetRateModHelper('1.8') then return '1.8x Rate'
	elseif GetRateModHelper('1.9') then return '1.9x Rate'
	elseif GetRateModHelper('2.0') then return '2.0x Rate'
	else return '(Unknown rate mod)' end
end

function DisplayCustomModifiersText(pn)
	local output = ""

	if getenv("UnderCombo"..ToEnumShortString(pn)) and getenv("UnderTapJudgments"..ToEnumShortString(pn)) and getenv("UnderHoldJudgments"..ToEnumShortString(pn)) then
		output = addToOutput(output,"Under All",", ")
	else
		if getenv("UnderTapJudgments"..ToEnumShortString(pn)) and getenv("UnderHoldJudgments"..ToEnumShortString(pn)) then
			output = addToOutput(output,"Under Judgments",", ")
		else
			if getenv("UnderCombo"..ToEnumShortString(pn)) then output = addToOutput(output,"Under Combo",", ") end
			if getenv("UnderTapJudgments"..ToEnumShortString(pn)) then output = addToOutput(output,"Under Tap Judgments",", ") end
			if getenv("UnderHoldJudgments"..ToEnumShortString(pn)) then output = addToOutput(output,"Under Hold Judgments",", ") end
		end
	end

	if getenv("HideScore"..ToEnumShortString(pn)) and getenv("HideLife"..ToEnumShortString(pn)) and getenv("HideCombo"..ToEnumShortString(pn)) then
		output = addToOutput(output,"Hide All",", ")
	else
		if getenv("HideScore"..ToEnumShortString(pn)) then output = addToOutput(output,"Hide Score",", ") end
		if getenv("HideLife"..ToEnumShortString(pn)) then output = addToOutput(output,"Hide Life",", ") end
		if getenv("HideCombo"..ToEnumShortString(pn)) then output = addToOutput(output,"Hide Combo",", ") end
	end

	if getenv("RotationLeft"..ToEnumShortString(pn)) then output = addToOutput(output,"Rotated Left",", ") end
	if getenv("RotationRight"..ToEnumShortString(pn)) then output = addToOutput(output,"Rotated Right",", ") end
	if getenv("RotationUpsideDown"..ToEnumShortString(pn)) then output = addToOutput(output,"Rotated Downward",", ") end
	if getenv("RotationSolo"..ToEnumShortString(pn)) then output = addToOutput(output,"Centered",", ") end

	if getenv("EffectWag"..ToEnumShortString(pn)) then output = addToOutput(output,"Wag",", ")
	elseif getenv("EffectPulse"..ToEnumShortString(pn)) then output = addToOutput(output,"Pulse",", ")
	elseif getenv("EffectBounce"..ToEnumShortString(pn)) then output = addToOutput(output,"Bounce",", ")
	elseif getenv("EffectSpinReverse"..ToEnumShortString(pn)) then output = addToOutput(output,"Spin Left",", ")
	elseif getenv("EffectSpin"..ToEnumShortString(pn)) then output = addToOutput(output,"Spin Right",", ")
	elseif getenv("EffectVibrate"..ToEnumShortString(pn)) then output = addToOutput(output,"Vibrate",", ") end

	if getenv("ShowMods"..ToEnumShortString(pn)) then output = addToOutput(output,"Show Mods",", ") end
	if getenv("ShowStats"..ToEnumShortString(pn)) > 0 then output = addToOutput(output,"Show Stats",", ") end

	if getenv("ScreenFilter"..ToEnumShortString(pn)) > 0 then output = addToOutput(output,"Screen Filter ("..(getenv("ScreenFilter"..ToEnumShortString(pn))*100).."%)",", ") end

	if GetRateMod() ~= '' then output = addToOutput(output,GetRateMod(),", ") end

	return output
end