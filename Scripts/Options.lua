function SongMods()
	--[[ oitg mods:
	19|tournament
	20|showstats
	22|orientation
	23|playfield
	25|screenfilter
	27|timingscale
	--]]

	local pm = GAMESTATE:GetPlayMode()
	local style = GAMESTATE:GetCurrentStyle()
	local styleType = style:GetStyleType()
	local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')

	-- shared begin
	--local options = "1,2,3,4,7,5,18,17,9,"
	local options = "1,2,4,F,3,5,RE,AE,17,9,"

	-- differences
	if pm == 'PlayMode_Regular' then
		if doubles then
			options = options .. "23,10,11,"
		else
			options = options .. "22,23,10,11,"
		end
	elseif pm == 'PlayMode_Nonstop' then
		options = options .. "22,23,"
	else
		-- survival/fallback
		options = options .. "10,11,"
	end

	-- next shared
	options = options .. "12,13,14,7,M,A,15,19,28,25,"

	-- differences 2 (should be "27,24," but timingscale is not in sm5)
	if pm == 'PlayMode_Regular' then
		if HasLuaCheck() then
			options = options .. "20,21,24,"
		else
			options = options .. "20,24,"
		end
	elseif pm == 'PlayMode_Nonstop' then
		if IsCourseSecret() then
			options = options .. "20,24,"
		else
			options = options .. "20,21,24,"
		end
	end

	if pm == 'PlayMode_Rave' or pm == 'PlayMode_Oni' then
		options = "1,3,28,20,21,"
	end

	-- ends on 16:
	options = options .. "16"
	return options
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
	-- underField
	setenv("UnderComboP1",false)
	setenv("UnderComboP2",false)
	setenv("UnderTapJudgmentsP1",false)
	setenv("UnderTapJudgmentsP2",false)
	setenv("UnderHoldJudgmentsP1",false)
	setenv("UnderHoldJudgmentsP2",false)
	-- tournament
	setenv("HideScoreP1",false)
	setenv("HideScoreP2",false)
	setenv("HideLifeP1",false)
	setenv("HideLifeP2",false)
	setenv("HideComboP1",false)
	setenv("HideComboP2",false)
	-- rotation
	setenv("RotationLeftP1",false)
	setenv("RotationRightP1",false)
	setenv("RotationUpsideDownP1",false)
	setenv("RotationLeftP2",false)
	setenv("RotationRightP2",false)
	setenv("RotationUpsideDownP2",false)

	-- effect
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
	-- mods display
	setenv("ShowModsP1",false)
	setenv("ShowModsP2",false)
	-- stats display
	setenv("ShowStatsP1",0)
	setenv("ShowStatsP2",0)
	-- screen filter
	setenv("ScreenFilterP1",0)
	setenv("ScreenFilterP2",0)
end

-- underField options
function OptionUnderFieldOptions()
	local t = {
		Name="UnderFieldOptions",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { "Combo", "Tap Judgments", "Hold Judgments" },
		LoadSelections = function(self, list, pn)
			local pX = pname(pn);
			list[1] = getenv("UnderCombo"..pX)
			list[2] = getenv("UnderTapJudgments"..pX)
			list[3] = getenv("UnderHoldJudgments"..pX)
		end,
		SaveSelections = function(self, list, pn)
			local pX = pname(pn);
			setenv("UnderCombo"..pX,list[1])
			setenv("UnderTapJudgments"..pX,list[2])
			setenv("UnderHoldJudgments"..pX,list[3])
		end,
	}
	setmetatable(t, t)
	return t
end

-- tournament options
function OptionTournamentOptions()
	local t = {
		Name="TournamentOptions",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Hide Score", "Hide Combo", "Hide Lifebar" },
		LoadSelections = function(self, list, pn)
			local pX = pname(pn);
			list[1] = getenv("HideScore"..pX)
			list[2] = getenv("HideCombo"..pX)
			list[3] = getenv("HideLife"..pX)
		end,
		SaveSelections = function(self, list, pn)
			local pX = pname(pn);
			setenv("HideScore"..pX,list[1])
			setenv("HideCombo"..pX,list[2])
			setenv("HideLife"..pX,list[3])
		end,
	}
	setmetatable(t, t)
	return t
end

-- stats display
function OptionShowStats()
	local t = {
		Name="ShowStats",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Off","W1","W2","W3","W4","W5","Miss" },
		LoadSelections = function(self, list, pn)
			local pX = pname(pn);
			local pref = getenv("ShowStats"..pX)+1
			local selected = 0
			for i, choice in ipairs(self.Choices) do
				if i == (getenv("ShowStats"..pX) + 1) then
					selected = i
					break
				end
			end
			if selected ~= 0 then
				list[selected] = true
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local pX = pname(pn);
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					setenv("ShowStats"..pX,i-1)
					return
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

-- mods display
function OptionShowModifiers()
	local t = {
		Name="ShowModifiers",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Show Active Modifiers" },
		LoadSelections = function(self, list, pn)
			local pX = pname(pn);
			list[1] = getenv("ShowMods"..pX)
		end,
		SaveSelections = function(self, list, pn)
			local pX = pname(pn);
			setenv("ShowMods"..pX,list[1])
		end
	}
	setmetatable(t, t)
	return t
end

-- "DarkLink's Custom Mods"
-- i am ashamed to have to even put this code in the theme -f
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
		-- xxx: dumb shit
		Choices = AvailableArrowDirections(),
		LoadSelections = function(self, list, pn)
			local pX = pname(pn);
			list[1] = getenv("RotationNormal"..pX)
			list[2] = getenv("RotationLeft"..pX)
			list[3] = getenv("RotationRight"..pX)
			list[4] = getenv("RotationUpsideDown"..pX)
			if GAMESTATE:GetNumPlayersEnabled() == 1 then list[5] = getenv("RotationSolo"..pX) end
		end;
		SaveSelections = function(self, list, pn)
			local pX = pname(pn);
			setenv("RotationNormal"..pX,list[1])
			setenv("RotationLeft"..pX,list[2])
			setenv("RotationRight"..pX,list[3])
			setenv("RotationUpsideDown"..pX,list[4])
			if GAMESTATE:GetNumPlayersEnabled() == 1 then setenv("RotationSolo"..pX,list[5]) end
		end;
	};
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
			local pX = pname(pn);
			list[1] = getenv("EffectVibrate"..pX)
			list[2] = getenv("EffectSpin"..pX)
			list[3] = getenv("EffectSpinReverse"..pX)
			list[4] = getenv("EffectBounce"..pX)
			list[5] = getenv("EffectPulse"..pX)
			list[6] = getenv("EffectWag"..pX)
		end;
		SaveSelections = function(self, list, pn)
			local pX = pname(pn);
			setenv("EffectVibrate"..pX,list[1])
			setenv("EffectSpin"..pX,list[2])
			setenv("EffectSpinReverse"..pX,list[3])
			setenv("EffectBounce"..pX,list[4])
			setenv("EffectPulse"..pX,list[5])
			setenv("EffectWag"..pX,list[6])
		end;
	};
	setmetatable(t, t)
	return t
end
-- end of stuff I had to take from someone else

-- screen filter a la sm-ssc!
function OptionRowScreenFilter()
	local t = {
		Name="ScreenFilter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { 'Disabled', 'Dark', 'Darker', 'Darkest', 'Wesley Snipes' },
		LoadSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local filterValue = getenv("ScreenFilter"..pName)
			if filterValue ~= nil then
				local val = 1
				if filterValue == 0.5 then val = 2
				elseif filterValue == 0.65 then val = 3
				elseif filterValue == 0.85 then val = 4
				elseif filterValue == 1.0 then val = 5
				end
				list[val] = true
			else
				setenv("ScreenFilter"..pName,0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local val = 0
			if list[1] then val = 0
			elseif list[2] then val = 0.5
			elseif list[3] then val = 0.65
			elseif list[4] then val = 0.85
			elseif list[5] then val = 1.0
			end
			setenv("ScreenFilter"..pName,val)
		end,
	};
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

function DisplayCustomModifiersText(pn)	--gives me text of all custom modifiers that are applied (and rate mods)
	local t = ""
	local pName = (pn == PLAYER_2 and 2 or 1)
	pName = string.format("P%i",pName)
	
	if getenv("UnderCombo"..pName) and getenv("UnderTapJudgments"..pName) and getenv("UnderHoldJudgments"..pName) then
		if t == "" then t = "Under All" else t = t .. ", Under All" end
	else
		if getenv("UnderTapJudgments"..pName) and getenv("UnderHoldJudgments"..pName) then
			if t == "" then t = "Under Judgments" else t = t .. ", Under Judgments" end
		else
			if getenv("UnderCombo"..pName) then if t == "" then t = "Under Combo" else t = t .. ", Under Combo" end end
			if getenv("UnderTapJudgments"..pName) then if t == "" then t = "Under Tap Judgments" else t = t .. ", Under Tap Judgments" end end
			if getenv("UnderHoldJudgments"..pName) then if t == "" then t = "Under Hold Judgments" else t = t .. ", Under Hold Judgments" end end
		end
	end
	
	if getenv("HideScore"..pName) and getenv("HideLife"..pName) and getenv("HideCombo"..pName) then
		if t == "" then t = "Hide All" else t = t .. ", Hide All" end
	else
		if getenv("HideScore"..pName) then if t == "" then t = "Hide Score" else t = t .. ", Hide Score" end end
		if getenv("HideLife"..pName) then if t == "" then t = "Hide Life" else t = t .. ", Hide Life" end end
		if getenv("HideCombo"..pName) then if t == "" then t = "Hide Combo" else t = t .. ", Hide Combo" end end
	end

	if getenv("RotationLeft"..pName) then if t == "" then t = "Rotated Left" else t = t .. ", Rotated Left" end end
	if getenv("RotationRight"..pName) then if t == "" then t = "Rotated Right" else t = t .. ", Rotated Right" end end
	if getenv("RotationUpsideDown"..pName) then if t == "" then t = "Rotated Downward" else t = t .. ", Rotated Downward" end end
	if getenv("RotationSolo"..pName) then if t == "" then t = "Centered" else t = t .. ", Centered" end end
	
	if getenv("EffectWag"..pName) then if t == "" then t = "Wag" else t = t .. ", Wag" end 
	elseif getenv("EffectPulse"..pName) then if t == "" then t = "Pulse" else t = t .. ", Pulse" end 
	elseif getenv("EffectBounce"..pName) then if t == "" then t = "Bounce" else t = t .. ", Bounce" end 
	elseif getenv("EffectSpinReverse"..pName) then if t == "" then t = "Spin Left" else t = t .. ", Spin Left" end 
	elseif getenv("EffectSpin"..pName) then if t == "" then t = "Spin Right" else t = t .. ", Spin Right" end 
	elseif getenv("EffectVibrate"..pName) then if t == "" then t = "Vibrate" else t = t .. ", Vibrate" end end

	if getenv("ShowMods"..pName) then if t == "" then t = "Show Mods" else t = t .. ", Show Mods" end end
	if getenv("ShowStats"..pName) > 0 then if t == "" then t = "Show Stats" else t = t .. ", Show Stats" end end

	if getenv("ScreenFilter"..pName) == 0.5 then if t == "" then t = "Dark Filter" else t = t .. ", Dark Filter" end end
	if getenv("ScreenFilter"..pName) == 0.65 then if t == "" then t = "Darker Filter" else t = t .. ", Darker Filter" end end
	if getenv("ScreenFilter"..pName) == 0.85 then if t == "" then t = "Darkest Filter" else t = t .. ", Darkest Filter" end end
	if getenv("ScreenFilter"..pName) == 1.0 then if t == "" then t = "Wesley Snipes" else t = t .. ", Wesley Snipes" end end
	
	if GetRateMod() ~= '' then if t == "" then t = GetRateMod() else t = t .. ", " .. GetRateMod() end end
	
	return t
	
end