-- ScreenGameplay-related stuff

function OffsetLifebarHeight(pn)
	local pX = pname(pn);
	if getenv("RotationLeft"..pX) or getenv("RotationRight"..pX) then
		return SCREEN_CENTER_Y
	else
		return SCREEN_CENTER_Y+30
	end
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

function Field(pn)
	local pX = pname(pn);

	-- Local Variables for Easier Editing.
	local s = "y,SCREEN_TOP+240;"
	local left = "rotationz,270;"
	local right = "rotationz,90;"
	local upsidedown = "rotationz,180;addy,20;"
	local solo = "x,SCREEN_CENTER_X;"
	local vibrate = "vibrate;effectmagnitude,20,20,20;"
	local spin = "spin;effectclock,beat;effectmagnitude,0,0,45;"
	local bob = "bob;effectclock,beat;effectmagnitude,30,30,30;"
	local pulse = "pulse;effectclock,beat;"
	local wag = "wag;effectclock,beat;"
	local spinreverse = "spin;effectclock,beat;effectmagnitude,0,0,-45;"
	local leftsideoffset = "x,SCREEN_LEFT+190+" .. GetLifebarAdjustment() ..";"
	local rightsideoffset = "x,SCREEN_RIGHT-190-" .. GetLifebarAdjustment() ..";"
	local player1centeroffset = "x,SCREEN_CENTER_X-160-".. GetLifebarAdjustment() .. ";"
	local player2centeroffset = "x,SCREEN_CENTER_X+160+" .. GetLifebarAdjustment() ..";"
	local right1poffset = "addx,SCREEN_WIDTH/2;"
	local left1poffset = "addx,-SCREEN_WIDTH/2;"

	if getenv("RotationLeft"..pX) == true then 
		s = left
			if pn == PLAYER_1 then
				s = s .. leftsideoffset
			else
				s = s .. player2centeroffset
			end		
		if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			s = s .. left1poffset end
	elseif getenv("RotationRight"..pX) == true then 
		s = right
			if pn == PLAYER_2 then
				s = s .. rightsideoffset
			else
				s = s .. player1centeroffset
			end	
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			s = s .. right1poffset end
	elseif getenv("RotationUpsideDown"..pX) == true then
		s = upsidedown
	elseif getenv("RotationSolo"..pX) == true then
		s = solo
	else
		s = s
	end
	
	if getenv("EffectSpin"..pX) == true then
		s = s .. spin end
		
	if getenv("EffectSpinReverse"..pX) == true then
		s = s .. spinreverse end
	
	if getenv("EffectVibrate"..pX) == true then
		s = s .. vibrate end
		
	if getenv("EffectBounce"..pX) == true then
		s = s .. bob end
		
	if getenv("EffectPulse"..pX) == true then
		s = s .. pulse end
		
	if getenv("EffectWag"..pX) == true then
		s = s .. wag end
	
	return s	
	
end