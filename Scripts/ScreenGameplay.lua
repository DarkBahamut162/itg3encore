function OffsetLifebarHeight(pn)
	if getenv("Rotation"..pname(pn)) == 2 or getenv("Rotation"..pname(pn)) == 3 then
		return SCREEN_CENTER_Y
	else
		return SCREEN_CENTER_Y+30
	end
end

local diffState = {
	Difficulty_Beginner = 0,
	Difficulty_Easy = 1,
	Difficulty_Medium = 2,
	Difficulty_Hard = 3,
	Difficulty_Challenge = 4,
	Difficulty_Edit = 5
}

function DifficultyToState(diff)
	return diffState[diff] or 5
end

function GetSongFrame()
	if IsGame("pump") then return "_piupro" end
	if GAMESTATE:IsCourseMode() then return "_normal" end
	local song = GAMESTATE:GetCurrentSong()
	local songTitle = song:GetDisplayFullTitle()
	local songDir = song:GetSongDir()
	local frame
	if string.find(songDir,"Dance Dance Revolution 8th Mix") or string.find(songDir,"Dance Dance Revolution Extreme") then
		frame = "_disconnect"
	elseif string.find(songTitle,"VerTex") then
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

function AllowOptionsMenu()
	if GAMESTATE:IsAnExtraStage() then
		return false
	else
		return true
	end
end

function GetComboXOffset(pn)
	if getenv("HideCombo" .. pname(pn)) then
		return "SCREEN_WIDTH*2"
	else
		return 0
	end
end

function GetTapScore(pn, category)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	return pss:GetTapNoteScores(category)
end

function GetHoldScore(pn, category)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	return pss:GetHoldNoteScores(category)
end

function GetNotesHit(pn)
	return GetTapScore(pn, "TapNoteScore_W1") + GetTapScore(pn, "TapNoteScore_W2") + GetTapScore(pn, "TapNoteScore_W3")
end

function PlayerFullComboed(pn)
	if GAMESTATE:IsPlayerEnabled(pn) then
		local SongOrCourse, StepsOrTrail

		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse()
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn)
		else
			SongOrCourse = GAMESTATE:GetCurrentSong()
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
		end

		local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
		local TotalHolds = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Holds')
		local TotalRolls = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Rolls')

		if GetNotesHit(pn) == TotalSteps and GetHoldScore(pn, "HoldNoteScore_Held") == (TotalHolds + TotalRolls) then return true end
	end
	return false
end

function AnyPlayerFullComboed()
	local output = false

	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if not output then
			output = PlayerFullComboed(pn)
		end
	end
	return output
end

local StepCount = {0,0}
function StepEvenOdd(player)
	local PX = (player == PLAYER_1) and 1 or 2
	StepCount[PX]=StepCount[PX]+1
	if StepCount[PX] % 2 == 0 then
		return 1
	else
		return -1
	end
end

local HoldCount = {0,0}
function HoldEvenOdd(player)
	local PX = (player == PLAYER_1) and 1 or 2
	HoldCount[PX]=HoldCount[PX]+1
	if HoldCount[PX] % 2 == 0 then
		return 1
	else
		return -1
	end
end

function Actor:LyricCommand(side)
	self:settext( Var "LyricText" )
	self:draworder(102)
	self:vertspacing(-10)

	self:stoptweening()
	self:shadowlengthx(0)
	self:shadowlengthy(5)
	self:strokecolor(color("#000000"))

	local Zoom = SCREEN_WIDTH / (self:GetZoomedWidth()+1)
	if( Zoom > 1 ) then
		Zoom = 1
	end
	self:zoomx( Zoom )

	local lyricColor = Var "LyricColor"
	local Factor = 1
	if side == "Back" then
		Factor = 0.5
	elseif side == "Front" then
		Factor = 0.9
	end
	self:diffuse( {
		lyricColor[1] * Factor,
		lyricColor[2] * Factor,
		lyricColor[3] * Factor,
		lyricColor[4] * Factor } )

	if side == "Front" then
		self:cropright(1)
	else
		self:cropleft(0)
	end

	self:diffusealpha(0)
	self:linear(0.2)
	self:diffusealpha(0.75)
	self:linear( Var "LyricDuration" * 0.75)
	if side == "Front" then
		self:cropright(0)
	else
		self:cropleft(1)
	end
	self:sleep( Var "LyricDuration" * 0.25 )
	self:linear(0.2)
	self:diffusealpha(0)
	return self
end

function GameplayMarginsFix(enabled_players,styletype)
	local style = GAMESTATE:GetCurrentStyle()
	if styletype == nil then styletype = style:GetStyleType() end
	if enabled_players == nil then enabled_players = GAMESTATE:GetEnabledPlayers() end
	local other = {
		[PLAYER_1] = PLAYER_2,
		[PLAYER_2] = PLAYER_1
	}
	local margins = {
		[PLAYER_1] = {40, 40},
		[PLAYER_2] = {40, 40}
	}

	if Center1Player() then
		local style_width = style:GetWidth(GAMESTATE:GetMasterPlayerNumber())
		local pn = enabled_players[1]
		local center = _screen.cx
		local left = center - style_width
		local right = _screen.w - center - style_width
		if not THEME:GetMetric("ScreenGameplay","AllowCenter1Player") then
			center = (_screen.w - style_width) / WideScreenDiff()
			left = center / 4 * WideScreenDiff()
			right = center / 4 * WideScreenDiff()
		end
		return math.abs(left), -math.abs(center), math.abs(right)
	end

	local half_screen = _screen.w / 2
	local left = {[PLAYER_1]= 0, [PLAYER_2]= half_screen}

	for i, pn in ipairs(enabled_players) do
		local edge = left[pn]
		local center = THEME:GetMetric("ScreenGameplay","Player"..ToEnumShortString(pn)..ToEnumShortString(styletype).."X")
		local style_width = style:GetWidth(pn)

		center = center - edge
		margins[pn][1] = center - (style_width / 2)
		margins[pn][2] = half_screen - center - (style_width / 2)

		if #enabled_players == 1 then
			margins[other[pn]][1] = margins[pn][2]
			margins[other[pn]][2] = margins[pn][1]
		end
	end

	local left = margins[PLAYER_1][1]
	local center = margins[PLAYER_1][2] + margins[PLAYER_2][1]
	local right = margins[PLAYER_2][2]

	return math.abs(left), math.abs(center), math.abs(right)
end

function NotefieldZoom()
	local style = GAMESTATE:GetCurrentStyle()
	local leftPX, centerPX, rightPX = GameplayMarginsFix()
	local screen_space = Center1Player() and SCREEN_WIDTH or SCREEN_CENTER_X
	local field_space = screen_space - math.abs(leftPX) - math.abs(rightPX)
	local style_width = style:GetWidth(GAMESTATE:GetMasterPlayerNumber())

	return field_space / style_width
end

function NotefieldZoomOutFox()
	local style_width = GAMESTATE:GetCurrentStyle():GetWidth(GAMESTATE:GetMasterPlayerNumber())
	if GAMESTATE:GetNumPlayersEnabled() == 1 then
		return (SCREEN_WIDTH - 36 - 36) / style_width
	end
	local field_space = SCREEN_CENTER_X - 40 * WideScreenDiff_(16/10) - 40 * WideScreenDiff_(16/10)

	return field_space / style_width
end