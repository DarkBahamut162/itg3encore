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
	local pm = GAMESTATE:GetPlayMode()
	local style = GAMESTATE:GetCurrentStyle()
	local styleType = style:GetStyleType()
	local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')

	local options = "1,2,4,F,3,5,RE,AE,17,9,"

	if pm == 'PlayMode_Regular' then
		if doubles then
			options = options .. "23,10,11,"
		else
			options = options .. "22,23,10,11,"
		end
	elseif pm == 'PlayMode_Nonstop' then
		options = options .. "22,23,"
	else
		options = options .. "10,11,"
	end

	options = options .. "12,13,14,7,M,A,15,19,28,25,"

	-- differences 2 (should be "27,24," but timingscale is not in sm5)
	if pm == 'PlayMode_Regular' then
		if HasLuaCheck() then
			options = options .. "20,P,21,24,"
		else
			options = options .. "20,P,24,"
		end
	elseif pm == 'PlayMode_Nonstop' then
		if IsCourseSecret() then
			options = options .. "20,P,24,"
		else
			options = options .. "20,P,21,24,"
		end
	end

	if pm == 'PlayMode_Rave' or pm == 'PlayMode_Oni' then
		options = "1,3,28,20,P,21,"
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
	local t = ""

	if getenv("UnderCombo"..ToEnumShortString(pn)) and getenv("UnderTapJudgments"..ToEnumShortString(pn)) and getenv("UnderHoldJudgments"..ToEnumShortString(pn)) then
		if t == "" then t = "Under All" else t = t .. ", Under All" end
	else
		if getenv("UnderTapJudgments"..ToEnumShortString(pn)) and getenv("UnderHoldJudgments"..ToEnumShortString(pn)) then
			if t == "" then t = "Under Judgments" else t = t .. ", Under Judgments" end
		else
			if getenv("UnderCombo"..ToEnumShortString(pn)) then if t == "" then t = "Under Combo" else t = t .. ", Under Combo" end end
			if getenv("UnderTapJudgments"..ToEnumShortString(pn)) then if t == "" then t = "Under Tap Judgments" else t = t .. ", Under Tap Judgments" end end
			if getenv("UnderHoldJudgments"..ToEnumShortString(pn)) then if t == "" then t = "Under Hold Judgments" else t = t .. ", Under Hold Judgments" end end
		end
	end

	if getenv("HideScore"..ToEnumShortString(pn)) and getenv("HideLife"..ToEnumShortString(pn)) and getenv("HideCombo"..ToEnumShortString(pn)) then
		if t == "" then t = "Hide All" else t = t .. ", Hide All" end
	else
		if getenv("HideScore"..ToEnumShortString(pn)) then if t == "" then t = "Hide Score" else t = t .. ", Hide Score" end end
		if getenv("HideLife"..ToEnumShortString(pn)) then if t == "" then t = "Hide Life" else t = t .. ", Hide Life" end end
		if getenv("HideCombo"..ToEnumShortString(pn)) then if t == "" then t = "Hide Combo" else t = t .. ", Hide Combo" end end
	end

	if getenv("RotationLeft"..ToEnumShortString(pn)) then if t == "" then t = "Rotated Left" else t = t .. ", Rotated Left" end end
	if getenv("RotationRight"..ToEnumShortString(pn)) then if t == "" then t = "Rotated Right" else t = t .. ", Rotated Right" end end
	if getenv("RotationUpsideDown"..ToEnumShortString(pn)) then if t == "" then t = "Rotated Downward" else t = t .. ", Rotated Downward" end end
	if getenv("RotationSolo"..ToEnumShortString(pn)) then if t == "" then t = "Centered" else t = t .. ", Centered" end end

	if getenv("EffectWag"..ToEnumShortString(pn)) then if t == "" then t = "Wag" else t = t .. ", Wag" end
	elseif getenv("EffectPulse"..ToEnumShortString(pn)) then if t == "" then t = "Pulse" else t = t .. ", Pulse" end
	elseif getenv("EffectBounce"..ToEnumShortString(pn)) then if t == "" then t = "Bounce" else t = t .. ", Bounce" end
	elseif getenv("EffectSpinReverse"..ToEnumShortString(pn)) then if t == "" then t = "Spin Left" else t = t .. ", Spin Left" end
	elseif getenv("EffectSpin"..ToEnumShortString(pn)) then if t == "" then t = "Spin Right" else t = t .. ", Spin Right" end
	elseif getenv("EffectVibrate"..ToEnumShortString(pn)) then if t == "" then t = "Vibrate" else t = t .. ", Vibrate" end end

	if getenv("ShowMods"..ToEnumShortString(pn)) then if t == "" then t = "Show Mods" else t = t .. ", Show Mods" end end
	if getenv("ShowStats"..ToEnumShortString(pn)) > 0 then if t == "" then t = "Show Stats" else t = t .. ", Show Stats" end end

	if getenv("ScreenFilter"..ToEnumShortString(pn)) > 0 then if t == "" then t = "Screen Filter ("..(getenv("ScreenFilter"..ToEnumShortString(pn))*100).."%)" else t = t .. ", Screen Filter ("..(getenv("ScreenFilter"..ToEnumShortString(pn))*100).."%)" end end

	if GetRateMod() ~= '' then if t == "" then t = GetRateMod() else t = t .. ", " .. GetRateMod() end end

	return t
end