local function GetGradeFromPercent(percent)
	local grades = {
		{1.00,"☆☆\n☆☆"},
		{0.99,"☆☆\n☆"},
		{0.98,"☆☆"},
		{0.96,"☆"},
		{0.94,"S+"},
		{0.92,"S"},
		{0.89,"S-"},
		{0.86,"A+"},
		{0.83,"A"},
		{0.80,"A-"},
		{0.76,"B+"},
		{0.72,"B"},
		{0.68,"B-"},
		{0.64,"C+"},
		{0.60,"C"},
		{0.55,"C-"},
		{0.50,"D+"},
		{-999,"D"},
	}

	if percent >= grades[1][1] then return grades[g][2] end

	for g=1,#grades-1 do
		if percent < grades[g][1] and percent >= grades[g+1][1] then return grades[g+1][2] end
	end

	return "F"
end

local levels = {
	[2] = "StageAward_FullComboW3",
	[3] = "StageAward_SingleDigitW3",
	[4] = "StageAward_OneW3",
	[5] = "StageAward_FullComboW2",
	[6] = "StageAward_SingleDigitW2",
	[7] = "StageAward_OneW2",
	[8] = "StageAward_FullComboW1"
}

local states = {
	["StageAward_FullComboW3"]		= { Number = 2, Color = color("#67FF19"), SemiColor = color("#67FF1980") },
	["StageAward_SingleDigitW3"]	= { Number = 3, Color = color("#67FF19"), SemiColor = color("#67FF1980") },
	["StageAward_OneW3"]			= { Number = 4, Color = color("#67FF19"), SemiColor = color("#67FF1980") },
	["StageAward_FullComboW2"]		= { Number = 5, Color = color("#FFA959"), SemiColor = color("#FFA95980") },
	["StageAward_SingleDigitW2"]	= { Number = 6, Color = color("#FFA959"), SemiColor = color("#FFA95980") },
	["StageAward_OneW2"]			= { Number = 7, Color = color("#FFA959"), SemiColor = color("#FFA95980") },
	["StageAward_FullComboW1"]		= { Number = 8, Color = color("#7BE8FF") }
}

local LampsP1 = ThemePrefs.Get("ShowLamps") and Def.Sprite {
	Texture = "MusicWheelItem _lamp "..(isFinal() and "Final" or "Normal"),
	InitCommand=function(self) self:diffuse(color("0,0,0,0")) end,
	SetCommand=function(self,params)
		local level = 0
		if params.Song then
			local steps
			if params.Song == GAMESTATE:GetCurrentSong() then
				steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1) then
				local currentDifficulty = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()
				local allSteps = params.Song:GetAllSteps()
				for step in ivalues(allSteps) do
					if step:GetDifficulty() == currentDifficulty then steps = step break end
				end
			end
			if steps then
				local highscores = PROFILEMAN:GetProfile(PLAYER_1):GetHighScoreListIfExists(params.Song,steps)
				if highscores then highscores = highscores:GetHighScores() end
				if highscores and #highscores > 0 then
					for place,highscore in pairs(highscores) do
						if level <= 0 then 
							if highscore:GetGrade() ~= "Grade_Failed" then level = 1 elseif level <= 0 then level = -1 end
						end
						local stageAward = highscore:GetStageAward()
						if states[stageAward] then
							if states[stageAward].Number > level then level = states[stageAward].Number end
						end
					end
				end
			end
		end
		self:stopeffect()
		if level == -1 then
			self:stopeffect():diffuse(color("1,0,0,1"))
		elseif level == 0 then
			self:stopeffect():diffuse(color("0,0,0,0"))
		elseif level == 1 then
			self:stopeffect():diffuse(color("1,1,1,1"))
		elseif level >= 2 then
			self:stopeffect():diffuse(states[levels[level]].Color)
			if (level-2)%3 == 1 then
				self:stopeffect():diffuseshift():effectclock("timerglobal"):effectcolor1(states[levels[level]].Color):effectcolor2(states[levels[level]].SemiColor):effectperiod(1)
			elseif (level-2)%3 == 2 then
				self:stopeffect():diffuseshift():effectclock("timerglobal"):effectcolor1(states[levels[level]].Color):effectcolor2(states[levels[level]].SemiColor):effectperiod(1/6)
			end
		end
		if GAMESTATE:GetNumPlayersEnabled()==2 then self:cropbottom(0.5) end
	end
} or Def.ActorFrame{}
local GradesP1 = ThemePrefs.Get("ShowGrade") and Def.BitmapText{
	Font= "_z bold 19px",
	Text="?",
	InitCommand=function(self) self:x(128):y(-12):horizalign(left):zoom(1/2):diffuse(PlayerColor(PLAYER_1)):vertspacing(-16) end,
	SetCommand=function(self,params)
		local output = ""
		if params.Song then
			local steps
			if params.Song == GAMESTATE:GetCurrentSong() then
				steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1) then
				local currentDifficulty = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()
				local allSteps = params.Song:GetAllSteps()
				for step in ivalues(allSteps) do
					if step:GetDifficulty() == currentDifficulty then steps = step break end
				end
			end
			if steps then
				local highscores = PROFILEMAN:GetProfile(PLAYER_1):GetHighScoreListIfExists(params.Song,steps)
				if highscores then highscores = highscores:GetHighScores() end
				if highscores and #highscores > 0 then
					if highscores[1]:GetGrade() == "Grade_Failed" then output = "F" else output = GetGradeFromPercent(highscores[1]:GetPercentDP()) end
				end
			end
		end
		self:settext(output)
	end
} or Def.ActorFrame{}

local LampsP2 = ThemePrefs.Get("ShowLamps") and Def.Sprite {
	Texture = "MusicWheelItem _lamp "..(isFinal() and "Final" or "Normal"),
	InitCommand=function(self) self:diffuse(color("0,0,0,0")) end,
	SetCommand=function(self,params)
		local level = 0
		if params.Song then
			local steps
			if params.Song == GAMESTATE:GetCurrentSong() then
				steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2) then
				local currentDifficulty = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()
				local allSteps = params.Song:GetAllSteps()
				for step in ivalues(allSteps) do
					if step:GetDifficulty() == currentDifficulty then steps = step break end
				end
			end
			if steps then
				local highscores = PROFILEMAN:GetProfile(PLAYER_2):GetHighScoreListIfExists(params.Song,steps)
				if highscores then highscores = highscores:GetHighScores() end
				if highscores and #highscores > 0 then
					for place,highscore in pairs(highscores) do
						if level <= 0 then 
							if highscore:GetGrade() ~= "Grade_Failed" then level = 1 elseif level <= 0 then level = -1 end
						end
						local stageAward = highscore:GetStageAward()
						if states[stageAward] then
							if states[stageAward].Number > level then level = states[stageAward].Number end
						end
					end
				end
			end
		end
		self:stopeffect()
		if level == -1 then
			self:stopeffect():diffuse(color("1,0,0,1"))
		elseif level == 0 then
			self:stopeffect():diffuse(color("0,0,0,0"))
		elseif level == 1 then
			self:stopeffect():diffuse(color("1,1,1,1"))
		elseif level >= 2 then
			self:stopeffect():diffuse(states[levels[level]].Color)
			if (level-2)%3 == 1 then
				self:stopeffect():diffuseshift():effectclock("timerglobal"):effectcolor1(states[levels[level]].Color):effectcolor2(states[levels[level]].SemiColor):effectperiod(1)
			elseif (level-2)%3 == 2 then
				self:stopeffect():diffuseshift():effectclock("timerglobal"):effectcolor1(states[levels[level]].Color):effectcolor2(states[levels[level]].SemiColor):effectperiod(1/6)
			end
		end
		if GAMESTATE:GetNumPlayersEnabled()==2 then self:croptop(0.5) end
	end
} or Def.ActorFrame{}
local GradesP2 = ThemePrefs.Get("ShowGrade") and Def.BitmapText{
	Font= "_z bold 19px",
	Text="?",
	InitCommand=function(self) self:x(128):y(12):horizalign(left):zoom(1/2):diffuse(PlayerColor(PLAYER_2)) end,
	SetCommand=function(self,params)
		local output = ""
		if params.Song then
			local steps
			if params.Song == GAMESTATE:GetCurrentSong() then
				steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2) then
				local currentDifficulty = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()
				local allSteps = params.Song:GetAllSteps()
				for step in ivalues(allSteps) do
					if step:GetDifficulty() == currentDifficulty then steps = step break end
				end
			end
			if steps then
				local highscores = PROFILEMAN:GetProfile(PLAYER_2):GetHighScoreListIfExists(params.Song,steps)
				if highscores then highscores = highscores:GetHighScores() end
				if highscores and #highscores > 0 then
					if highscores[1]:GetGrade() == "Grade_Failed" then output = "F" else output = GetGradeFromPercent(highscores[1]:GetPercentDP()) end
				end
			end
		end
		self:settext(output)
	end
} or Def.ActorFrame{}

return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheelItem _Song NormalPart"..(isFinal() and "Final" or "Normal")
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
		LampsP1,
		Def.Sprite{
			Condition=isOutFox(20230000),
			InitCommand=function(self) self:Load( THEME:GetPathB("","_thanks/_outfox/logo") ):xy(120,-12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(PlayerColor(PLAYER_1)):effectcolor2(PlayerColorSemi(PLAYER_1)) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = false

					if isOutFoxV(20230628) then
						isFav = GetPlayerOrMachineProfile(PLAYER_1):SongIsFavorite(params.Song)
					elseif isOutFox(20230000) then
						isFav = FindInTable(params.Song, getOFFavorites(PLAYER_1))
					end

					if isFav then
						local spmp = VersionDateCheck(20150300) and params.Song:GetPreviewMusicPath() or GetPreviewMusicPath(params.Song)
						self:effectclock(spmp ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		},
		Def.Sprite{
			Condition=ThemePrefs.Get("SLFavorites"),
			InitCommand=function(self) self:Load( THEME:GetPathB("ScreenEndingOkay","overlay/intro/arrow") ):xy(104,-12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(PlayerColor(PLAYER_1)):effectcolor2(PlayerColorSemi(PLAYER_1)) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = isEtterna() and params.Song:IsFavorited() or FindInTable(params.Song, getSLFavorites(ToEnumShortString(PLAYER_1)))

					if isFav then
						local spmp = VersionDateCheck(20150300) and params.Song:GetPreviewMusicPath() or GetPreviewMusicPath(params.Song)
						self:effectclock(spmp ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		},
		GradesP1
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
		LampsP2,
		Def.Sprite{
			Condition=isOutFox(20230000),
			InitCommand=function(self) self:Load( THEME:GetPathB("","_thanks/_outfox/logo") ):xy(120,12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(PlayerColor(PLAYER_2)):effectcolor2(PlayerColorSemi(PLAYER_2)) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = false

					if isOutFoxV() then
						isFav = GetPlayerOrMachineProfile(PLAYER_2):SongIsFavorite(params.Song)
					elseif isOutFox(20230000) then
						isFav = FindInTable(params.Song, getOFFavorites(PLAYER_2))
					end

					if isFav then
						local spmp = VersionDateCheck(20150300) and params.Song:GetPreviewMusicPath() or GetPreviewMusicPath(params.Song)
						self:effectclock(spmp ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		},
		Def.Sprite{
			Condition=ThemePrefs.Get("SLFavorites"),
			InitCommand=function(self) self:Load( THEME:GetPathB("ScreenEndingOkay","overlay/intro/arrow") ):xy(104,12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(PlayerColor(PLAYER_2)):effectcolor2(PlayerColorSemi(PLAYER_2)) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = FindInTable(params.Song, getSLFavorites(ToEnumShortString(PLAYER_2)))

					if isFav then
						local spmp = VersionDateCheck(20150300) and params.Song:GetPreviewMusicPath() or GetPreviewMusicPath(params.Song)
						self:effectclock(spmp ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		},
		GradesP2
	}
}