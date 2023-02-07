function Get2PlayerJoinMessage()
	if not GAMESTATE:PlayersCanJoin() then return "" end
	if GAMESTATE:GetCoinMode()=='CoinMode_Free' or GAMESTATE:GetCoinMode()=='CoinMode_Home' then
		return "2 Player mode available"
	end
	local numSidesNotJoined = NUM_PLAYERS - GAMESTATE:GetNumSidesJoined()
	if GAMESTATE:GetPremium() == 'Premium_2PlayersFor1Credit' then
		numSidesNotJoined = numSidesNotJoined - 1
	end
	local coinsRequiredToJoinRest = numSidesNotJoined * PREFSMAN:GetPreference("CoinsPerCredit")
	local remaining = coinsRequiredToJoinRest - GAMESTATE:GetCoins()
	local s = "For 2 Players, insert " .. remaining .. " more coin(s)"
	if remaining > 1 then s = s.."s" end
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

function GetRandomModifierNames(n)
	local mods = {
		"x1","x1.5","x2","x2.5","x3","3.5x","x4","x5","x6","x8","c300","c450",
		"Incoming","Overhead","Space","Hallway","Distant",
		"Standard","Reverse","Split","Alternate","Cross","Centered",
		"Accel","Decel","Wave","Expand","Boomerang","Bumpy",
		"Dizzy","Drift","Mini","Flip","Invert","Tornado","Float","Beat",
		"Fade&nbsp;In","Fade&nbsp;Out","Blink","Invisible","Beat","Bumpy",
		"Mirror","Left","Right","Random","Blender",
		"No&nbsp;Jumps","No&nbsp;Holds","No&nbsp;Rolls","No&nbsp;Hands","No&nbsp;Quads","No&nbsp;Mines",
		"Simple","Stream","Wide","Quick","Skippy","Echo","Stomp",
		"Planted","Floored","Twister","Add&nbsp;Mines","No&nbsp;Stretch&nbsp;Jumps",
		"Hide&nbsp;Targets","Hide&nbsp;Judgment","Hide&nbsp;Background",
		"Metal","Cel","Flat","Robot","Vivid"
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
		return THEME:GetString("ScreenNameEntryTraditional","HelpTextHasHighScores") .. "\n" .. THEME:GetMetric( "ScreenNameEntryTraditional", "HelpTextHasHighScoresSelectAvailableText" )
	end
	return THEME:GetString("ScreenNameEntryTraditional","HelpTextNoHighScores")
end

function HumanAndProfile(pn)
	return GAMESTATE:IsHumanPlayer(pn) and MEMCARDMAN:GetCardState(pn) ~= 'MemoryCardState_none'
end

function EnabledAndProfile(pn)
	return GAMESTATE:IsPlayerEnabled(pn) and MEMCARDMAN:GetCardState(pn) ~= 'MemoryCardState_none'
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
	return PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade('StepsType_Dance_Single','Difficulty_Challenge',1)
end

function StarAward( pn )
	return PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade('StepsType_Dance_Single','Difficulty_Challenge',1)*4
		+PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade('StepsType_Dance_Single','Difficulty_Challenge',2)*3
		+PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade('StepsType_Dance_Single','Difficulty_Challenge',3)*2
		+PROFILEMAN:GetProfile(pn):GetTotalStepsWithTopGrade('StepsType_Dance_Single','Difficulty_Challenge',4)
end

function CalorieAward( pn )
	return PROFILEMAN:GetProfile(pn):GetCaloriesBurnedToday()
end

function PercentAward( pn )
	return (PROFILEMAN:GetProfile(pn):GetSongsActual('StepsType_Dance_Single','Difficulty_Challenge'))*100
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
	return tobool(THEME:GetMetric("Preferences", "EnableFinalTheme"))
end

function isScreenTitle()
	if SCREENMAN:GetTopScreen() then
		return SCREENMAN:GetTopScreen():GetName() == "ScreenTitleMenu" or SCREENMAN:GetTopScreen():GetName() == "ScreenTitleJoin"
	else
		return false
	end
end

function isITGmania()
	return ProductFamily() == "ITGmania"
end

function isOutFox()
	return ProductFamily() == "OutFox"
end

function isStepMania()
	return ProductFamily() == "StepMania"
end

function isWidescreen()
	return SCREEN_WIDTH / SCREEN_HEIGHT >= 1.7
end