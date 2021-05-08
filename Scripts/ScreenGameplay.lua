-- ScreenGameplay-related stuff

function OffsetLifebarHeight(pn)
	--[[
	if CustomMods[pn].left or CustomMods[pn].right then
		return SCREEN_CENTER_Y
	else
		return SCREEN_CENTER_Y+30
	end
	--]]
	return SCREEN_CENTER_Y+30
end

-- To be called wherever the lifebars are positioned
function GetLifebarAdjustment()
	--[[
	local lifetype = ProfileTable.LifebarAdjustment
	-- assume "coin" unless otherwise specified
	if not lifetype then return "0" end
	return lifetype
	--]]
	return "0"
end

-- Returns true if life is hidden, false otherwise; (for use in metrics.ini)
function HideLife(pn)
	--return CustomMods[pn].hidelife or false
	return false
end

local diffState = {
	Difficulty_Beginner = 0,
	Difficulty_Easy = 1,
	Difficulty_Medium = 2,
	Difficulty_Hard = 3,
	Difficulty_Challenge = 4,
	Difficulty_Edit = 5,
};
function DifficultyToState(diff)
	return diffState[diff]
end

-- used for gameplay overlay and life meter
function GetSongFrame()
	local song = GAMESTATE:GetCurrentSong()
	-- fuck courses.
	if not song then return "_normal" end

	local songTitle = song:GetDisplayFullTitle()
	local songArtist = song:GetDisplayArtist()
	local songDir = song:GetSongDir()

	-- todo: tighten up song/string matching
	local frame
	if string.find(songDir,"Dance Dance Revolution 8th Mix") or string.find(songDir,"Dance Dance Revolution Extreme") then
		frame = "_extreme"
	elseif string.find(songTitle,"VerTex") then -- probably matches vertex beta
		frame = "_vertex"
	elseif string.find(songTitle,"Dream to Nightmare") then
		frame = "_nightmare"
	elseif string.find(songTitle,"Summer ~Speedy Mix~") then
		frame = "_smiley"
	elseif string.find(songTitle,"Pandemonium") then
		frame = "_pandy"
	elseif string.find(songTitle,"Pink Fuzzy Bunnies") then
		frame = "_bunnies"
	elseif string.find(songTitle,"Virtual Emotion") then
		frame = "_virtual"
	elseif string.find(songTitle,"Hasse Mich") then
		frame = "_hasse"
	elseif string.find(songTitle,"Energizer") then
		frame = "_energy"
	elseif string.find(songTitle,"Love Eternal") then
		frame = "_love"
	elseif string.find(songTitle,"Disconnected Hardkore") then
		frame = "_disconnect"
	else
		frame = "_normal"
	end
	return frame
end

function songfail(bVertex)
	local curSong = GAMESTATE:GetCurrentSong()
	if curSong then
		local title = curSong:GetDisplayFullTitle()
		if title == "VerTex" or title == "VerTex²" or title == "VerTex^3" or
			title == "VerTex³" or title == "VerTex3" or title == "VVV" then
			return bVertex and true or false
		end
	end

	return not bVertex
end

function PlayerFullComboed(pn)
	if GAMESTATE:IsPlayerEnabled(pn) then
		local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
		if fct:FullComboOfScore('TapNoteScore_W1') == true or
			fct:FullComboOfScore('TapNoteScore_W2') == true or
			fct:FullComboOfScore('TapNoteScore_W3') == true then
			return true;
		end
	end	
	return false
end

function AnyPlayerFullComboed(self)
	if PlayerFullComboed(PLAYER_1) or PlayerFullComboed(PLAYER_2) then 
		return true
	end
end

-- Needed for judgment rotation
local StepCount = 0;
function StepEvenOdd()
	StepCount=StepCount+1;
	if StepCount % 2 == 0 then
		return 1
	else
		return -1
	end
end

-- Needed for hold rotation
local HoldCount = 0;
function HoldEvenOdd()
	HoldCount=HoldCount+1;
	if HoldCount % 2 == 0 then
		return 1
	else
		return -1
	end
end