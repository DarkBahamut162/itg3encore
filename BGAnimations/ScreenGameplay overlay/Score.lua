local player = ...
local scoreType = getenv("SetScoreType"..pname(player)) or 2
local scoreDirection = getenv("SetScoreDirection"..pname(player)) or 1
local animate = ThemePrefs.Get("AnimatePlayerScore")
local displayScore = 0
local maxScore = 0
local weight = {
    CheckpointHit = 0,
    CheckpointMiss = 0,
    Held = 0,
    HitMine = 0,
    MissedHold = 0,
    LetGo = 0,
    Miss  = 0,
    ProW1 = 0,
    ProW2 = 0,
    ProW3 = 0,
    ProW4 = 0,
    ProW5 = 0,
    W1 = 0,
    W2 = 0,
    W3 = 0,
    W4 = 0,
    W5 = 0
}
local stopping,stop = false,true
local time = GetTimeSinceStart()
local update = true
local dif = 1

if scoreType == 1 then dif = 4 elseif scoreType == 2 then dif = 10 elseif scoreType == 3 then dif = 5 end

for w,v in pairs(weight) do
	if not isOutFox() and string.find(w,"Pro") then else weight[w] = tonumber(THEME:GetMetric('ScoreKeeperNormal', 'PercentScoreWeight'..w)) end
end

local function animateScore(currentScore,fakeScore)
	if not animate then
		stop = true
		return currentScore
	else
		if currentScore >= fakeScore then
			if currentScore > fakeScore + math.ceil((currentScore - fakeScore) / dif) then
				displayScore = fakeScore + math.ceil((currentScore - fakeScore) / dif)
			elseif currentScore <= fakeScore + math.ceil((currentScore - fakeScore) / dif) then
				if stopping then stop = true end
				displayScore = currentScore
			end
		else
			if currentScore < fakeScore - math.ceil((fakeScore - currentScore) / dif) then
				displayScore = fakeScore - math.ceil((fakeScore - currentScore) / dif)
			elseif currentScore <= fakeScore - math.ceil((fakeScore - currentScore) / dif) then
				if stopping then stop = true end
				displayScore = currentScore
			end
		end

		return displayScore
	end
end

local function UpdateScore(self)
	if animate then
		if (GetTimeSinceStart() - time) >= 1/60 then
			update = true
			time = GetTimeSinceStart()
		else
			update = false
		end
	end

	if not stop and update and (displayScore > 0 or (isSurvival(player) and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() >= GAMESTATE:GetCurrentSong():GetFirstSecond())) then self:GetChild("Score"..pname(player)):queuecommand("RedrawScore") end
end

return Def.ActorFrame{
	OnCommand=function(self)
		if isGamePlay() or isSurvival(player) then self:SetUpdateFunction(UpdateScore) end self:visible(isGamePlay())
		if scoreDirection == 2 then
			if scoreType == 1 then
				if GAMESTATE:GetCurrentSong():IsMarathon() then
					displayScore = 300000000
					maxScore = 300000000
				elseif GAMESTATE:GetCurrentSong():IsLong() then
					displayScore = 200000000
					maxScore = 200000000
				else
					displayScore = 100000000
					maxScore = 100000000
				end
			elseif scoreType == 2 then
				displayScore = 10000
			elseif scoreType == 3 then
				displayScore = DPMax(player)
			end
		end
		self:queuecommand("RedrawScore"):addy(-100):sleep(0.5):decelerate(0.8):addy(100)
	end,
	OffCommand=function(self) stopping = true if not IsGame("pump") then if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end end,
	Def.BitmapText {
		File = "_r bold numbers",
		Name="Score"..pname(player),
		InitCommand=function(self)
			self:visible(not getenv("HideScore"..pname(player))):diffuse(PlayerColor(player)):x(math.floor(scale(player == PLAYER_1 and 0.25 or 0.75,0,1,SCREEN_LEFT,SCREEN_RIGHT))):zoom(WideScreenDiff())
			if getenv("Workout") then
				if IsGame("pump") then
					if getenv("Rotation"..pname(player)) == 5 then
						self:y(SCREEN_TOP+61*WideScreenDiff())
					else
						self:y(SCREEN_TOP+41*WideScreenDiff())
					end
				else
					self:y(SCREEN_TOP+51*WideScreenDiff())
				end
			else
				if IsGame("pump") then
					if getenv("Rotation"..pname(player)) == 5 then
						self:y(SCREEN_TOP+61*WideScreenDiff())
					else
						self:y(SCREEN_TOP+51*WideScreenDiff())
					end
				else
					self:y(SCREEN_TOP+61*WideScreenDiff())
				end
			end
			if IsGame("pump") then self:addy(10) if GAMESTATE:GetNumPlayersEnabled() == 1 and getenv("Rotation"..pname(player)) == 5 then self:CenterX() end end
		end,
		JudgmentMessageCommand=function(self,param)
			if stop then stop = false end
			local short = ToEnumShortString(param.HoldNoteScore and param.HoldNoteScore or param.TapNoteScore)
			local update = weight[short] and weight[short] ~= 0
			if param.Player == player and update then self:stoptweening():queuecommand("RedrawScore") end
		end,
		RedrawScoreCommand=function(self)
			local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
			local output = 0
			if isSurvival(player) then
				self:settext(SecondsToMSSMsMs(pss:GetLifeRemainingSeconds())) -- SURVIVAL
			elseif scoreType == 1 then
				if scoreDirection == 1 then
					output = animateScore(pss:GetScore(),displayScore)
				else
					output = animateScore(maxScore-(pss:GetCurMaxScore()-pss:GetScore()),displayScore)
				end
				self:settextf("%09d",output) -- SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(9-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
			elseif scoreType == 2 then
				if scoreDirection == 1 then
					output = animateScore(DP(player)*10000,displayScore)/100
				else
					output = animateScore((DPMax(player)-(DPCurMax(player)-DPCur(player)))/DPMax(player)*10000,displayScore)/100
				end
				self:settextf("%1.2f%%",output) -- PERCENT
			elseif scoreType == 3 then
				if scoreDirection == 1 then
					output = animateScore(DPCur(player),displayScore)
				else
					output = animateScore((DPMax(player)-(DPCurMax(player)-DPCur(player))),displayScore)
				end
				self:settextf("%04d",output) -- EX
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(output >= 0 and 4-string.len(''..output) or 0, 0),
					Diffuse = PlayerColorSemi(player),
				})
			end
		end
	}
}