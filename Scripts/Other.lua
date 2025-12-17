function Get2PlayerJoinMessage()
	if not GAMESTATE:PlayersCanJoin() or isEtterna("0.55") then return "" end
	local s = "2 Player mode available"
	if GAMESTATE:GetCoinMode()=='CoinMode_Free' or GAMESTATE:GetCoinMode()=='CoinMode_Home' then return s end
	local numSidesNotJoined = NUM_PLAYERS - GAMESTATE:GetNumSidesJoined()
	if GAMESTATE:GetPremium() == 'Premium_2PlayersFor1Credit' then
		numSidesNotJoined = numSidesNotJoined - 1
	end
	local coinsRequiredToJoinRest = numSidesNotJoined * PREFSMAN:GetPreference("CoinsPerCredit")
	local remaining = coinsRequiredToJoinRest - GAMESTATE:GetCoins()
	if remaining > 0 then
		s = "For 2 Players, insert " .. remaining .. " more coin"
		if remaining > 1 then s = s.."s" end
	end
	return s
end

function GetCreditType()
	return "INSERT COIN"
end

function GetRandomSongNames(n)
	local s = ""
	for i = 1,n do
		local song = SONGMAN:GetRandomSong()
		if song then s = s..song:GetDisplayFullTitle().."\n" end
	end
	return s
end

function GetRandomCourseNames(n)
	local s = ""
	for i = 1,n do
		local course = SONGMAN:GetRandomCourse()
		if course then s = s..course:GetDisplayFullTitle().."\n" end
	end
	return s
end

function GetStepChartFacts()
	local diffCount = {0,0,0,0,0,0}
	local diffNames = {"novice","easy","medium","hard","expert","edit"}
	local output = ""
	local songs = SONGMAN:GetAllSongs()
	local currentGroup = ""
	local currentDifficulty = ""
	local diffTranslate = {
		Difficulty_Beginner = 1,
		Difficulty_Easy = 2,
		Difficulty_Medium = 3,
		Difficulty_Hard = 4,
		Difficulty_Challenge = 5,
		Difficulty_Edit = 6
	}

	function updateOutput()
		output = addToOutput(output,currentGroup..":","\n")
		for diff=1,#diffCount do
			if diffCount[diff] > 0 then
				output = addToOutput(output,"  "..diffCount[diff].." "..diffNames[diff],"\n")
			end
		end
	end

	for song=1,#songs do
		if currentGroup ~= songs[song]:GetGroupName() then
			if currentGroup ~= "" then updateOutput() end
			currentGroup = songs[song]:GetGroupName()
			diffCount = {0,0,0,0,0,0}
		end
		local steps = songs[song]:GetAllSteps()
		for step=1,#steps do
			currentDifficulty = steps[step]:GetDifficulty()
			if diffTranslate[currentDifficulty] then
				diffCount[diffTranslate[currentDifficulty]] = diffCount[diffTranslate[currentDifficulty]] + 1
			end
		end
	end

	updateOutput()

	return output
end

function GetRandomModifierNames(n)
	local mods = {
		"Xmod","Cmod","Mmod","Amod","CAmod","AVmod",
		"Overhead","Hallway","Distant","Incoming","Space",
		"Reverse","Split","Alternate","Cross","Centered",
		"Fail Immediate","Fail at 30 Misses","Fail Off",
		"NoteSkins",
		"Accel","Decel","Wave","Expand","Boomerang","Random",
		"BeatX","BeatY","BeatZ","Confusion","ConfusionX","ConfusionY",
		"DrunkX","DrunkZ","Flip","Invert","Tipsy",
		"AttenuateX","AttenuateY","AttenuateZ","Bounce","BounceZ","BumpyX","BumpyZ",
		"Digital","DigitalZ","ParabolaX","ParabolaY","ParabolaZ","Sawtooth","SawtoothZ",
		"Square","SquareZ","TornadoX","TornadoZ","XMode","Zigzag","ZigzagZ",
		"Dizzy","Twirl","Roll",
		"Fade Out","Fade In","Blink","Invisible","Vanish",
		"Normal Orientation","Left Orientation","Right Orientation","Upside-Down Orientation","Solo-Centered Orientation",
		"Vibrate","Spin Right","Spin Left","Bob","Pulse","Wag",
		"Simple","No Jumps","No Hands","No Quads","No Fakes",
		"No Holds","No Rolls","No Lifts","No Stretch Jumps",
		"Mirror","Backwards","Left","Right","Shuffle","Super Shuffle","Soft Shuffle",
		"Big","Quick","Skippy","Echo","Wide","Stomp","BMRize",
		"Planted","Floored","Twister","Holds To Rolls","Holds To Lift Holds",
		"Mini",
		"Allow BackGroundChanges","No BackGroundChanges","Random BackGroundChanges",
		"No Mines","Allow Mines","More Mines","Attack Mines",
		"No Attacks","Allow Attacks","Random Attacks",
		"Hide Targets","Hide Judgment","Hide Background",
		"Hide Score","Hide Combo","Hide Lifebar",
		"Under Combo","Under Tap Judgments","Under Hold Judgments",
		"Normal Score","Percent Score","EX Score",
		"Screen Filter",
		"Show Stats",
		"Pacemaker",
		"Rate"
	}
	mods = tableshuffle( mods )
	local s = ""
	for i = 1,math.min(n,table.getn(mods)) do
		s = s .. mods[i] .. "\n"
	end
	return s
end

function GetScreenNameEntryTraditionalHelpText()
	if GAMESTATE:AnyPlayerHasRankingFeats() then
		return THEME:GetString("ScreenNameEntryTraditional","HelpTextHasHighScores") .. "\n" .. THEME:GetString( "ScreenNameEntryTraditional", "HelpTextHasHighScoresSelectAvailableText" )
	end
	return THEME:GetString("ScreenNameEntryTraditional","HelpTextNoHighScores")
end

function HumanAndProfile(pn)
	return GAMESTATE:IsHumanPlayer(pn) and (not isEtterna("0.65") and MEMCARDMAN:GetCardState(pn) ~= 'MemoryCardState_none' or false)
end

function EnabledAndProfile(pn)
	return GAMESTATE:IsPlayerEnabled(pn) and (not isEtterna("0.65") and MEMCARDMAN:GetCardState(pn) ~= 'MemoryCardState_none' or false)
end

function HumanAndUSBReady(pn)
	return GAMESTATE:IsHumanPlayer(pn) and (not isEtterna("0.65") and MEMCARDMAN:GetCardState(pn) == 'MemoryCardState_ready' or false)
end

function EnabledAndUSBReady(pn)
	return GAMESTATE:IsPlayerEnabled(pn) and (not isEtterna("0.65") and MEMCARDMAN:GetCardState(pn) == 'MemoryCardState_ready' or false)
end

function USBReady(pn)
	return not isEtterna("0.65") and MEMCARDMAN:GetCardState(pn) == 'MemoryCardState_ready' or false
end

function AnyUSBReady()
	for pn in ivalues({PLAYER_1,PLAYER_2}) do
		if USBReady(pn) then return true end
	end
	return false
end

function GetDisplayNameFromProfileOrMemoryCard(pn)
	if PROFILEMAN:IsPersistentProfile(pn) then return GAMESTATE:GetPlayerDisplayName(pn) end
	if MEMCARDMAN:GetCardState(pn) ~= 'MemoryCardState_none' then return MEMCARDMAN:GetName(pn) end
	return ""
end

function ScreenEndingGetDisplayName(pn)
	if MEMCARDMAN:GetCardState(pn) ~= 'MemoryCardState_none' then return MEMCARDMAN:GetName(pn) end
	return "No Card"
end

function QuadAward( pn )
	return PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Challenge',1)
end

function StarAward( pn )
	return PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Challenge',1)*4
		+PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Challenge',2)*3
		+PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Challenge',3)*2
		+PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Challenge',4)
end

function CalorieAward( pn )
	return PROFILEMAN:GetProfile(pn):GetCaloriesBurnedToday()
end

function PercentAward( pn )
	return (PROFILEMAN:GetProfile(pn):GetSongsActual(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Challenge'))*100
end

function StarIcon( Actor,pn )
	local stars = StarAward( pn )
	if stars < 10 then Actor:visible(0) end
	if stars >= 10 then Actor:setstate(4) end
	if stars >= 25 then Actor:setstate(5) end
	if stars >= 50 then Actor:setstate(6) end
	if stars >= 100 then Actor:setstate(7) end
end

function QuadIcon( Actor,pn )
	local quads = QuadAward( pn )
	if quads < 10 then Actor:visible(0) end
	if quads >= 10 then Actor:setstate(8) end
	if quads >= 25 then Actor:setstate(9) end
	if quads >= 50 then Actor:setstate(10) end
	if quads >= 100 then Actor:setstate(11) end
end

function PercentIcon( Actor,pn )
	local perc = PercentAward( pn )
	if perc < 500 then Actor:visible(0) end
	if perc >= 500 then Actor:setstate(0) end
	if perc >= 2500 then Actor:setstate(1) end
	if perc >= 7500 then Actor:setstate(2) end
	if perc >= 15000 then Actor:setstate(3) end
end

function CalorieIcon( Actor,pn )
	local cals = CalorieAward( pn )
	if cals < 250 then Actor:visible(0) end
	if cals >= 250 then Actor:setstate(12) end
	if cals >= 750 then Actor:setstate(13) end
	if cals >= 1500 then Actor:setstate(14) end
	if cals >= 3000 then Actor:setstate(15) end
end

function getProfileSongs( pn )
	return "Played Songs:\n" .. PROFILEMAN:GetProfile(pn):GetTotalNumSongsPlayed()
end

function isFinal()
	return ThemePrefs.Get("EncoreThemeMode")
end

function isScreenTitle()
	return isTopScreen("ScreenTitleMenu") or isTopScreen("ScreenTitleJoin")
end

function isGamePlay()
	return isTopScreen('ScreenGameplay') or isTopScreen('ScreenGameplaySyncMachine') or isTopScreen('ScreenNetGameplay') or isTopScreen('ScreenCreditsGameplay') or isTopScreen('ScreenGameplayWorkout') or isTopScreen('ScreenDemonstration') or isTopScreen('ScreenJukebox')
end

function isPlayMode(mode)
	if isEtterna("0.70.2") then
		return "PlayMode_Regular" == mode
	else
		return GAMESTATE:GetPlayMode() == mode
	end
end

function isDouble()
	local styleType = GAMESTATE:GetCurrentStyle():GetStyleType()
	return styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides'
end

function isITGmania(version)
	if version then return ProductFamily() == "ITGmania" and VersionDateCheck(version) else return ProductFamily() == "ITGmania" end
end

function isOutFox(version)
	local productCheck = ProductFamily() == "OutFox" or (isStepMania() and tonumber(split("-",ProductVersion())[1]) == 5.3)
	if version then return productCheck and VersionDateCheck(version) else return productCheck end
end

function isEtterna(version)
	if ProductFamily() == "Etterna" then
		if type(version) == "number" then version = "0" end
		if version then return EtternaVersionCheck(version) else return true end
	elseif ProductFamily() == "StepMania - Etterna" then
		if type(version) == "string" then version = 20170908 end
		if version then return VersionDateCheck(version) else return true end
	end
	return false
end

function isOutFoxV(version)
	local versionSplit = tonumber(split("-",ProductVersion())[1]:sub(1,3))
	-- Thanks LTS
	if not versionSplit then versionSplit = tonumber(split("-",ProductVersion())[2]:sub(1,3)) end
	local productCheck = isOutFox() and versionSplit >= 0.5 and versionSplit < 5
	if version then return productCheck and VersionDateCheck(version) else return productCheck end
end

function VersionDateCheck(version)
	return tonumber(VersionDate()) >= version
end

function EtternaVersionCheck(version)
	local current = split("%.",split("-",ProductVersion())[1])
	local check = split("%.",version)
	local curV,checkV = 0,0
	if #current <= 1 then current = {"0","66"} end -- Etterna is run by idiots
	for i = 1,#current do curV = curV + tonumber(current[i])*math.pow(10,6-(i*2)) end
	for i = 1,#check do checkV = checkV + tonumber(check[i])*math.pow(10,6-(i*2)) end
	if curV >= 50000 then curV = 05500 end
	return curV >= checkV
end

function isOutFoxV043(version)
	if version then return isOutFoxV(20240000) and VersionDateCheck(version) else return isOutFoxV(20240000) end
end

function hasAvatar(pn)
	if isOutFox() then
		return Basename(LoadModule("Options.GetProfileData.lua")(pn)["Image"]) ~= "UserProfile generic icon.png"
	else
		return false
	end
end

function isStepMania(version)
	if version then return ProductFamily() == "StepMania" and VersionDateCheck(version) else return ProductFamily() == "StepMania" end
end

function isOldStepMania()
	return ProductFamily() == "StepMania" and not VersionDateCheck(20180000)
end

function isOpenDDR()
	return ProductFamily() == "OpenDDR"
end

function isTopScreen(screen)
	if SCREENMAN:GetTopScreen() then
		return SCREENMAN:GetTopScreen():GetName() == screen
	else
		return Var "LoadingScreen" == screen
	end
end

function addToOutput(output,add,pre)
	if string.len(output) == 0 then
		return add
	else
		if pre then return output..pre..add else return output..add end
	end
end

function Center1Player()
	if isDouble() then
		return true
	else
		return getenv("Rotation"..pname(GAMESTATE:GetMasterPlayerNumber())) == 5
	end
end

function WideScreenDiff()
	return math.min(1,GetScreenAspectRatio() / (4/3))
end

function WideScreenDiff_(aspect)
	return math.min(1,GetScreenAspectRatio() / aspect)
end

function WideScreenSemiDiff()
	return 1-(1-WideScreenDiff())*0.5
end

function WideScreenSemiDiff_(aspect)
	return 1-(1-WideScreenDiff_(aspect))*0.5
end

function GetLives(player)
	local song, steps = nil, nil
	local stepCounter, holdCounter, songInSeconds = 0, 0, 0
	local lives = 1

	if GAMESTATE:IsCourseMode() then
		steps = GAMESTATE:GetCurrentTrail(player)
		for entry in ivalues(steps:GetTrailEntries()) do
			stepCounter = stepCounter + entry:GetSteps():GetRadarValues(player):GetValue('RadarCategory_TapsAndHolds')
			holdCounter = holdCounter + entry:GetSteps():GetRadarValues(player):GetValue('RadarCategory_Holds')
			songInSeconds = songInSeconds + (entry:GetSong():GetLastSecond() - entry:GetSong():GetFirstSecond())
		end
	else
		songs = GAMESTATE:GetCurrentSong()
		steps = GAMESTATE:GetCurrentSteps(player)
		stepCounter = steps:GetRadarValues(player):GetValue('RadarCategory_TapsAndHolds')
		holdCounter = steps:GetRadarValues(player):GetValue('RadarCategory_Holds')
		songInSeconds = songInSeconds + (songs:GetLastSecond() - songs:GetFirstSecond())
	end

	if not GAMESTATE:IsCourseMode() then
		if steps:GetDifficulty() == "Difficulty_Challenge" then
			lives = 70
		end
		if steps:GetDescription() == 'Nonstop' then
			lives = 5
		end
	end

	if lives < 5 then
		if holdCounter >= 15 and holdCounter < 25 then
			lives = 25
		elseif holdCounter >= 25 and holdCounter < 50 then
			lives = 20
		elseif holdCounter >= 50 and holdCounter < 100 then
			lives = 10
		elseif holdCounter >= 100 then
			lives = 5
		else
			local calc = songInSeconds / stepCounter * 100
			lives = math.ceil( calc / 5 ) * 5

			if lives < 10 then
				lives = 10
			end
			if lives > 60 then
				lives = 60
			end
		end
	end

	return lives
end

function USBCheck()
	if not getenv("USBCheck") then
		setenv("USBCheck",true)
		return false
	end
	return true
end

local OptionsListKeys = {
	PrevItem = "MenuLeft",
	NextItem = "MenuRight"
}

function GetOptionsListMapping(name)
	return OptionsListKeys[name]
end

function JudgmentTransformCommand( self, params )
	local y = -30
	local ShowMovePlayerfieldStats = getenv("ShowMovePlayerfieldStats"..pname(params.Player)) or 3
	local add = SCREEN_CENTER_Y/5*(ShowMovePlayerfieldStats-3)
	if params.bReverse then
		y = y * -1
		add = add * -1
	end
	local mods = string.find(GAMESTATE:GetPlayerState(params.Player):GetPlayerOptionsString("ModsLevel_Song"),"FlipUpsideDown")
	if mods then
		y = y * -1
		add = add * -1
	end
	if isOutFoxV(20231200) and (IsGame("be-mu") or IsGame("po-mu")) then
		y = y * -1
		add = add * -1
	end
	local zoom = isOutFox() and 1 or (1+math.min(1,NotefieldZoom()))/2

	self:x( 0 )
	self:y( y*zoom + add )
	self:zoom( zoom )
end

function JudgmentTransformSharedCommand( self, params )
	JudgmentTransformCommand( self, params )
end

function ComboTransformCommand( self, params )
	local y = 30
	local ShowMovePlayerfieldStats = getenv("ShowMovePlayerfieldStats"..pname(params.Player)) or 3
	local add = SCREEN_CENTER_Y/5*(ShowMovePlayerfieldStats-3)
	if params.bReverse then
		y = -40
		add = add * -1
	end
	local mods = string.find(GAMESTATE:GetPlayerState(params.Player):GetPlayerOptionsString("ModsLevel_Song"),"FlipUpsideDown")
	if mods then
		y = y * -1
		add = add * -1
	end
	if isOutFoxV(20231200) and (IsGame("be-mu") or IsGame("po-mu")) then
		y = y * -1
		add = add * -1
	end
	local zoom = isOutFox() and 1 or (1+math.min(1,NotefieldZoom()))/2

	self:x( 0 )
	self:y( y*zoom + add )
	self:zoom( zoom )
end

function FindInTable(needle, haystack)
	for i = 1, #haystack do
		if needle == haystack[i] then
			return i
		end
	end
	return nil
end

local GameAndMenuButtons = {
	dance		= { "Left", "Down", "Up", "Right" },
	groove		= { "Left", "Down", "Up", "Right" },
	pump		= { "DownLeft", "UpLeft", "Center", "UpRight", "DownRight" },
	smx			= { "Left", "Down", "Up", "Right" },
	["be-mu"]	= { "Key1", "Key7", "Scratch up", "Scratch down" },
	techno		= { "Left", "Down", "Up", "Right" },
	["po-mu"]	= { "Left Yellow", "Left Blue", "Red", "Right Blue", "Right Yellow" },
}

local LocalizedGameButtons = {}

local DelocalizeGameButton = function(localized_btn)
	local game = GAMESTATE:GetCurrentGame():GetName()
	if not GameAndMenuButtons[game] then return false end

	local language = THEME:GetCurLanguage()
	if not LocalizedGameButtons[language] then
		local t = {}
		for gb in ivalues(GameAndMenuButtons[game]) do
			t[THEME:GetString("GameButton", gb)] = gb
		end
		LocalizedGameButtons[language] = t
	end

	return LocalizedGameButtons[language][localized_btn]
end

function IsGameAndMenuButton(localized_btn)
	if PREFSMAN:GetPreference("OnlyDedicatedMenuButtons") then return false end

	local btn = DelocalizeGameButton(localized_btn)
	if not btn then return false end

	return FindInTable(btn, GameAndMenuButtons[GAMESTATE:GetCurrentGame():GetName()])
end

function WideScaleFixed(AR4_3, AR16_9)
	return clamp(scale( SCREEN_WIDTH, 640, 854, AR4_3, AR16_9 ), AR4_3, AR16_9)
end

function canRender()
	return "d3d" ~= string.lower(split(',',PREFSMAN:GetPreference('VideoRenderers'))[1])
end

function setX(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):XMod(value/100)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):XMod(value/100)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):XMod(value/100)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):XMod(value/100)
end

function setC(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):CMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):CMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):CMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):CMod(value)
end

function setM(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):MMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):MMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):MMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):MMod(value)
end

function setA(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):AMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):AMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):AMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):AMod(value)
end

function setAV(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):AVMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):AVMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):AVMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):AVMod(value)
end

function setCA(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):CAMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):CAMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):CAMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):CAMod(value)
end

function offsetMS(value)
	local val = PREFSMAN:GetPreference(value)
	local ms = round(val * 1000)

	low = math.min(-1000, ms)
	high = math.max(1000, ms)

	local function AllChoices()
		local ret = { }
		for i = 1,high-low do
			ret[i] = string.format('%d ms',i+low-1)
		end
		return ret
	end

	return {
		Name = value,
		Choices = AllChoices(),
		LayoutType = "ShowOneInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		LoadSelections = function(self, list, pn)
			local i = ms - low + 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i=1, #AllChoices() do
				if list[i] then
					PREFSMAN:SetPreference(value, (low + i - 1) / 1000)
					break
				end
			end
		end
	}
end

function PreferenceBoolean(value)
	return {
		Name = value,
		Choices = {THEME:GetString("OptionNames","Off"), THEME:GetString("OptionNames","On")},
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		LoadSelections = function(self, list, pn)
			local pref = PREFSMAN:GetPreference(value) and 2 or 1
			list[pref] = true
		end,
		SaveSelections = function(self, list, pn)
			local pref = (list[2]==true)
			PREFSMAN:SetPreference(value, pref)
		end
	}
end

function PreferenceRangeTime(args)
	args = split("_",args)
	local value,min,max,steps = args[1],tonumber(args[2]),tonumber(args[3]),tonumber(args[4])
	local range = math.floor((max-min)/steps)

	local choices = {}
	local values = {}

	for i = 0,range do
		values[i+1] = min+(steps*i)
		choices[i+1] = string.format('%d:%02d',math.floor(values[i+1]/60),values[i+1]%60)
	end

	return {
		Name = value,
		Choices = choices,
		Values = values,
		LayoutType = "ShowOneInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		LoadSelections = function(self, list, pn)
			local val = PREFSMAN:GetPreference(value)
			if not val then return end

			local i = FindInTable(val, values) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i=1, #values do
				if list[i] then
					PREFSMAN:SetPreference(value, values[i])
					break
				end
			end
		end
	}
end

function CustomSongsLoadTimeout()
	local choices = {}
	local values = {}

	for i = 1,9 do
		values[#values+1] = i
		choices[#values+1] = string.format('%ds',values[#values])
	end
	for i = 0,10 do
		values[#values+1] = 10+i*5
		choices[#values+1] = string.format('%ds',values[#values])
	end

	return {
		Name="CustomSongsLoadTimeout",
		Choices=choices,
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		LoadSelections = function(self, list, pn)
			local pref = PREFSMAN:GetPreference("CustomSongsLoadTimeout")
			local i = FindInTable(pref, values) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i=1, #choices do
				if list[i] then
					PREFSMAN:SetPreference("CustomSongsLoadTimeout", values[i])
					break
				end
			end
		end
	}
end

function CustomSongsMaxSeconds()
	local choices = {}
	local values = {}

	for i = 0,(900-105)/15 do
		values[i+1] = 105+(15*i)
		choices[i+1] = string.format('%d:%02d',math.floor(values[i+1]/60),values[i+1]%60)
	end

	table.insert(choices, "2:00:00")
	table.insert(values, 7200)

	return {
		Name="CustomSongsMaxSeconds",
		Choices=choices,
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		LoadSelections = function(self, list, pn)
			local time = SecondsToMMSS(PREFSMAN:GetPreference("CustomSongsMaxSeconds")):gsub("^0*", "")
			local i = FindInTable(time, choices) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i=1, #choices do
				if list[i] then
					PREFSMAN:SetPreference("CustomSongsMaxSeconds", values[i])
					break
				end
			end
		end
	}
end

function CustomSongsMaxMegabytes()
	local choices = {}
	local values = {}

	for i = 1,9 do
		values[#values+1] = i
		choices[#values+1] = string.format('%d MB',values[#values])
	end
	for i = 1,9 do
		values[#values+1] = 10*i
		choices[#values+1] = string.format('%d MB',values[#values])
	end
	for i = 1,10 do
		values[#values+1] = 100*i
		choices[#values+1] = string.format('%d MB',values[#values])
	end

	return {
		Name="CustomSongsMaxMegabytes",
		Choices=choices,
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		LoadSelections = function(self, list, pn)
			local pref = PREFSMAN:GetPreference("CustomSongsMaxMegabytes")
			local i = FindInTable(pref, values) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i=1, #choices do
				if list[i] then
					PREFSMAN:SetPreference("CustomSongsMaxMegabytes", values[i])
					break
				end
			end
		end
	}
end

function EditorNoteskin()
	local skins = NOTESKIN:GetNoteSkinNames()
	return {
		Name = "EditorNoteSkin",
		LayoutType = "ShowOneInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = skins,
		LoadSelections = function(self, list, pn)
			local skin = PREFSMAN:GetPreference("EditorNoteSkinP1") or
				PREFSMAN:GetPreference("EditorNoteSkinP2") or
				THEME:GetMetric("Common", "DefaultNoteSkinName")
			if not skin then return end

			local i = FindInTable(skin, skins) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i = 1, #skins do
				if list[i] then
					PREFSMAN:SetPreference("EditorNoteSkinP1", skins[i])
					PREFSMAN:SetPreference("EditorNoteSkinP2", skins[i])
					break
				end
			end
		end
	}
end

function CachePref()
	local name = (isOldStepMania() or isEtterna()) and "BannerCache" or "ImageCache"
	local var = (isOldStepMania() or isEtterna()) and "BannerCacheMode" or "ImageCacheMode"
	local IMGCache = PREFSMAN:GetPreference(name)
	local values = { var.."_Off", var.."_LowResPreload", var.."_LowResLoadOnDemand", var.."_Full" }
	local choices = { "Off", "LowResPreload", "LowResLoadOnDemand", "Full" }

	if isOutFoxV(20250000) then
		values = { var.."_Off", var.."_LowRes", var.."_MidRes", var.."_FullRes" }
		choices = { "Off", "LowRes", "MidRes", "FullRes" }
	elseif isOutFoxV() then
		values = { var.."_Off", var.."_LowRes", var.."_FullRes" }
		choices = { "Off", "LowRes", "FullRes" }
	end

	local t = {
		Name = name,
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Values = values,
		Choices = choices,
		LoadSelections = function(self, list, pn)
			IMGCache = PREFSMAN:GetPreference(name)
			for i, value in ipairs(self.Values) do
				list[i] = IMGCache == value
			end
		end,
		SaveSelections = function(self, list, pn)
			for i, choice in ipairs(self.Choices) do
				if list[i] then
					if IMGCache ~= self.Values[i] then
						local output = ""
						if not isOutFoxV() then
							if isOutFox(20201000) then
								if i == 4 then
									if PREFSMAN:PreferenceExists("ShowBanners") and not tobool(PREFSMAN:GetPreference("ShowBanners")) or false then
										output = var.." has next to no effect since Banners have been turned off!"
										if not bannerForced then output = addToOutput(output,"Replacement BannerDisplay activated!"," | ") end
										bannerForced = true
									else
										output = var.." successfully changed to "..self.Choices[i]
										if bannerForced then output = addToOutput(output,"Replacement BannerDisplay deactivated!"," | ") end
										bannerForced = false
									end
								else
									output = var.." is currently bugged within this version of Project OutFox"
									if not bannerForced then output = addToOutput(output,"Replacement BannerDisplay activated!"," | ") end
									bannerForced = true
								end
							else
								if i == 2 then
									output = "This option only takes effect on Preload!"
									if not bannerForced then output = addToOutput(output,"Replacement BannerDisplay activated!"," | ") end
									bannerForced = true
								else
									output = var.." successfully changed to "..self.Choices[i]
									if i == 1 then
										if not bannerForced then output = addToOutput(output,"Replacement BannerDisplay activated!"," | ") end
										bannerForced = true
									else
										if bannerForced then output = addToOutput(output,"Replacement BannerDisplay deactivated!"," | ") end
										bannerForced = false
									end
								end
							end
						end
						PREFSMAN:SetPreference(name, self.Values[i])
						if output ~= "" then SCREENMAN:SystemMessage(output) end
					end
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function VideoRenderer()
	local choices = { "opengl" }
	local values  = { "opengl" }

	if isOutFox(20200205) then
		table.insert(choices, "glad")
		values = { "opengl,glad", "glad,opengl" }
	else
		local architecture = HOOKS:GetArchName():lower()
		if architecture:match("windows") then
			table.insert(choices, "d3d")
			values = { "opengl,d3d", "d3d,opengl" }
		end
	end

	return {
		Name = "VideoRenderer",
		Choices = choices,
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		LoadSelections = function(self, list, pn)
			local pref = PREFSMAN:GetPreference("VideoRenderers")

			for renderer in pref:gmatch("(%w+),?") do
				pref = renderer
				break
			end

			if not pref then return end

			local i = FindInTable(pref, self.Choices) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i=1, #list do
				if list[i] then
					PREFSMAN:SetPreference("VideoRenderers", values[i])
					break
				end
			end
		end
	}
end

function PreferredSampleRate()
	local choices = { "Default", "44100 Hz", "48000 Hz" }
	local values  = { 0, 44100, 48000 }

	return {
		Name = "PreferredSampleRate",
		Choices = choices,
		Values = values,
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		LoadSelections = function(self, list, pn)
			local pref = PREFSMAN:GetPreference("SoundPreferredSampleRate")
			local i = FindInTable(pref, self.Values) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i=1, #list do
				if list[i] then
					PREFSMAN:SetPreference("SoundPreferredSampleRate", values[i])
					if isOutFoxV(20230513) then PREFSMAN:SetPreference("SoundPortAudioPreferredSampleRate", values[i]) end
					if isOutFoxV(20230327) then PREFSMAN:SetPreference("SoundrtAudioPreferredSampleRate", values[i]) end
					break
				end
			end
		end
	}
end

function GetProfileToEdit(player)
	local ret = {
		Name = "GetProfileToEdit"..(player and pname(player) or "P0"),
		Choices = {"No USB Detected"},
		LayoutType = "ShowAllInRow",
		SelectType = "SelectMultiple",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		LoadSelections = function() end,
		SaveSelections = function(self)
			local pname = self.Name:sub(-2)
			if pname == "P0" then
				SOUND:PlayOnce(THEME:GetPathS("Common","Start"))
				setenv("EditUSBProfile",player)						
				SCREENMAN:GetTopScreen():SetNextScreenName( "ScreenOptionsService" )
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
			else
				local player = pname == "P1" and PLAYER_1 or PLAYER_2
				if USBReady(player) then
					SOUND:PlayOnce(THEME:GetPathS("Common","Start"))
					setenv("EditUSBProfile",player)						
					SCREENMAN:GetTopScreen():SetNextScreenName( "ScreenOptionsCustomizeProfile" )
					SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
				else
					SOUND:PlayOnce(THEME:GetPathS("Common","invalid"))
				end
			end
		end,
		GenChoices= function(self)
			GAMESTATE:LoadProfiles()
			local pname = self.Name:sub(-2)
			if pname == "P0" then
				self.Choices={"Exit"}
			else
				local player = pname == "P1" and PLAYER_1 or PLAYER_2
				local output = PROFILEMAN:GetProfile(player):GetDisplayName()
				if output == "" then output = "NoName" end
				self.Choices={output}
			end
		end
	}
	if not player or USBReady(player) then ret:GenChoices() end
	return ret
end