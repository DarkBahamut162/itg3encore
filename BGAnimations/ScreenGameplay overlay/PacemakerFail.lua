local player = ...
local scoreType = (getenv("SetScoreType"..pname(player)) or 2) == 2 and getenv("SetScoreDirection"..pname(player)) ~= 1
local scoreDirection = 2
local animate = ThemePrefs.Get("AnimatePlayerScore")
local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 18-getenv("SetPacemaker"..pname(player))))*10000
local failType = getenv("SetPacemakerFail"..pname(player))
local warning = target+math.min(500,math.max(100,math.round((10000-target)/500)*100))
local displayScore = 10000
local stopping,stop = false,true
local time = GetTimeSinceStart()
local update = true
local dif = 4
local c

local function animateScore(currentScore,fakeScore)
	if not animate then
		stop = true
		return currentScore
	else
		if currentScore < fakeScore - math.ceil((fakeScore - currentScore) / dif) then
			displayScore = fakeScore - math.ceil((fakeScore - currentScore) / dif)
		elseif currentScore <= fakeScore - math.ceil((fakeScore - currentScore) / dif) then
			if stopping then stop = true end
			displayScore = currentScore
		end

		return displayScore
	end
end

local function UpdateScore(self)
	if animate then
		if (GetTimeSinceStart() - time) >= 1/60 then
			update = true
			time = GetTimeSinceStart()
			if displayScore <= warning then
				warning = 0
				c["Score"..pname(player)]:diffuseshift():effectcolor1(PlayerColor(player)):effectcolor2(Color("Red")):effectperiod(1)
			elseif displayScore < target then
				target = 0
				c["Score"..pname(player)]:stopeffect():diffuseramp():effectcolor1(Color("Red")):effectcolor2(Color("White")):effect_hold_at_full(99999)
				c["Target"..pname(player)]:stopeffect():diffuseramp():effectcolor1(Color("Red")):effectcolor2(Color("White")):effect_hold_at_full(99999)
				if failType == 2 then
					setenv("Restart",getenv("Restart")+1)
					SCREENMAN:GetTopScreen():SetPrevScreenName(Branch.BeforeGameplay()):begin_backing_out()
				elseif failType == 3 then
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):FailPlayer()
					SCREENMAN:GetTopScreen():GetChild('Player'..pname(player)):SetLife(0)
					SCREENMAN:GetTopScreen():PostScreenMessage("SM_BeginFailed", 0)
				end
			end
		else
			update = false
		end
	end

	if not stop and update and (displayScore > 0 or (isSurvival(player) and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() >= GAMESTATE:GetCurrentSong():GetFirstSecond())) then self:GetChild("Score"..pname(player)):queuecommand("RedrawScore") end
end

local SN = {
	HoldNoteScore_LetGo = true,
	HoldNoteScore_MissedHold = true,
	TapNoteScore_Miss = true,
	TapNoteScore_W1 = true,
	TapNoteScore_W2 = true,
	TapNoteScore_W3 = true,
	TapNoteScore_W4 = true,
	TapNoteScore_W5 = true,
}

return Def.ActorFrame{
	InitCommand=function(self) c=self:GetChildren() self:addx(player == PLAYER_1 and -100 or 100):queuecommand("RedrawScore"):sleep(0.5):decelerate(0.8):addx(player == PLAYER_1 and 100 or -100) end,
	OnCommand=function(self) if isGamePlay() or isSurvival(player) then self:SetUpdateFunction(UpdateScore) end self:visible(isGamePlay()) end,
	OffCommand=function(self) stopping = true if not IsGame("pump") then if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addx(player == PLAYER_1 and -100 or 100) end end,
	Def.BitmapText {
		File = "_r bold numbers",
		Name="Target"..pname(player),
		Text=string.format("%1.2f%%",target/100),
		InitCommand=function(self)
			self:visible(not getenv("HideScore"..pname(player))):x(math.floor(scale(player == PLAYER_1 and 0.05 or 0.95,0,1,SCREEN_LEFT,SCREEN_RIGHT))):zoom(0.4*WideScreenDiff()):y(SCREEN_TOP+((getenv("FlareAccurate"..pname(player)) and not isSurvival(player)) and 56 or 66)*WideScreenDiff())
		end
	},
	Def.BitmapText {
		File = ((not scoreType or isSurvival(player)) and "_r bold numbers" or "_r bold shadow"),
		Name="Score"..pname(player),
		InitCommand=function(self)
			self:visible(not getenv("HideScore"..pname(player))):diffuse(PlayerColor(player)):x(math.floor(scale(player == PLAYER_1 and 0.05 or 0.95,0,1,SCREEN_LEFT,SCREEN_RIGHT))):zoomx(((not scoreType or isSurvival(player)) and 0.4 or 0.3)*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):y(SCREEN_TOP+((getenv("FlareAccurate"..pname(player)) and not isSurvival(player)) and 46 or 56)*WideScreenDiff())
		end,
		JudgmentMessageCommand=function(self,param)
			if stop then stop = false end
			if (param.HoldNoteScore and SN[param.HoldNoteScore]) or SN[param.TapNoteScore] then else return end
			if param.Player == player and update then self:stoptweening():queuecommand("RedrawScore") end
		end,
		RedrawScoreCommand=function(self)
			local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
			local output = 0
			if scoreDirection == 1 then
				output = animateScore(DP(player)*10000,displayScore)/100
			else
				output = animateScore((DPMax(player)-(DPCurMax(player)-DPCur(player)))/DPMax(player)*10000,displayScore)/100
			end
			if not scoreType or isSurvival(player) then
				self:settextf("%1.2f%%",output)
			else
				self:settext("PACEMAKER")
			end
		end,
		OffCommand=function(self) if scoreDirection == 2 then scoreDirection = 1 self:queuecommand("RedrawScore") end end
	}
}