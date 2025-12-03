local SongOrCourse, StepsOrTrail, scorelist, topscore = {},{},{},{}
local bgNum = {}
local IIDX = false
local atLeastOneHighscoreExists = false
local trueVS = not isVS() and GAMESTATE:GetNumPlayersEnabled() == 2 and GAMESTATE:GetCurrentSteps(PLAYER_1) == GAMESTATE:GetCurrentSteps(PLAYER_2)

if getenv("ShowStatsP1") == nil or getenv("ShowStatsP2") == nil then return Def.ActorFrame{} else
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if GAMESTATE:IsCourseMode() then SongOrCourse[pn],StepsOrTrail[pn] = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(pn) else SongOrCourse[pn],StepsOrTrail[pn] = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(pn) end
		if not scorelist[pn] and GAMESTATE:IsHumanPlayer(pn) then scorelist[pn] = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse[pn],StepsOrTrail[pn]) end
		if not scorelist[pn] and GAMESTATE:IsHumanPlayer(pn) then scorelist[pn] = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse[pn],StepsOrTrail[pn]) end
		if scorelist[pn] and GAMESTATE:IsHumanPlayer(pn) then topscore[pn] = scorelist[pn]:GetHighScores()[1] end
		if getenv("ShowStatsP1") == (isOpenDDR() and 6 or 7) and getenv("ShowStatsP2") == (isOpenDDR() and 6 or 7) then
			if topscore[pn] == nil then bgNum[pn] = 4 else bgNum[pn] = 6 end
			IIDX = true
		else
			bgNum[pn] = math.min(6,getenv("ShowStats"..pname(pn)))
		end
	end
	if topscore[PLAYER_1] ~= nil or topscore[PLAYER_2] ~= nil then atLeastOneHighscoreExists = true end

	local t = Def.ActorFrame{}
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if GAMESTATE:IsHumanPlayer(pn) and bgNum[pn] > 0 then
			t[#t+1] = Def.ActorFrame{
				Name="Player"..pname(pn),
				loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/double"))(pn)..{
					InitCommand=function(self) self:zoom(trueVS and 3/4 or 1) end
				}
			}
		end
	end
	function CompareScoresRange( difference, range )
		local Player1Score=DP( PLAYER_1 )
		local Player2Score=DP( PLAYER_2 )
		local ScoreDifference = Player1Score - Player2Score
		local ReturnValue = scale(ScoreDifference, -difference, difference, range, -range)

		if ReturnValue <= -range then return -range
		elseif ReturnValue >= range then return range
		else return ReturnValue end
	end

	if trueVS then
		t[#t+1] = Def.ActorFrame{
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP+115) end,
			Def.Sprite {
				Texture = "bg",
				InitCommand=function(self) self:animate(0) end,
				JudgmentMessageCommand=function(self) self:queuecommand("Update") end,
				UpdateCommand=function(self) self:setstate(CompareScoresRange(0.05,80) < 0 and 1 or 2) end
			},
			Def.Sprite {
				Texture = "bar",
				InitCommand=function(self) self:y(10) end,
				JudgmentMessageCommand=function(self) self:queuecommand("Update") end,
				UpdateCommand=function(self) self:stoptweening():linear(0.1):rotationz(CompareScoresRange(0.05,80)) end
			},
			Def.Sprite { Texture = "frame" }
		}
	end

	return t
end