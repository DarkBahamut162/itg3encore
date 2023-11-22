local player = ...
local scoreType = getenv("SetScoreType"..pname(player)) or 2
local displayScore = 0
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
local stopping,stop = false,false
local dif = 1

if scoreType == 1 then dif = 4 elseif scoreType == 2 then dif = 10 elseif scoreType == 3 then dif = 5 end

for w,v in pairs(weight) do
	if not isOutFox() and string.find(w,"Pro") then else weight[w] = tonumber(THEME:GetMetric('ScoreKeeperNormal', 'PercentScoreWeight'..w)) end
end

local function animateScore(currentScore,fakeScore)
	local percent = GAMESTATE:GetCurrentSong():GetLastSecond()/GAMESTATE:GetSongPosition():GetMusicSecondsVisible()

	if currentScore > fakeScore + math.ceil((currentScore - fakeScore) / dif) then
		displayScore = fakeScore + math.ceil((currentScore - fakeScore) / dif)
	elseif currentScore <= fakeScore + math.ceil((currentScore - fakeScore) / dif) then
		if stopping then stop = true end
		displayScore = currentScore
	end

	return displayScore
end

local function UpdateScore(self)
	if not stop and (displayScore > 0 or (isSurvival(player) and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() >= GAMESTATE:GetCurrentSong():GetFirstSecond())) then self:GetChild("Score"..pname(player)):queuecommand("RedrawScore") end
end

return Def.ActorFrame{
	OnCommand=function(self)
		if isGamePlay() or isSurvival(player) then self:SetUpdateFunction(UpdateScore) end self:visible(isGamePlay())
		self:queuecommand("RedrawScore"):addy(-100):sleep(0.5):decelerate(0.8):addy(100)
	end,
	OffCommand=function(self) stopping = true if not IsGame("pump") then if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end end,
	LoadFont("_r bold numbers") .. {
		Name="Score"..pname(player),
		InitCommand=function(self)
			self:visible(not getenv("HideScore"..pname(player))):diffuse(PlayerColor(player)):x(math.floor(scale(player == PLAYER_1 and 0.25 or 0.75,0,1,SCREEN_LEFT,SCREEN_RIGHT))):zoom(WideScreenDiff())
			if getenv("Workout") then
				if IsGame("pump") then
					if getenv("RotationSolo"..pname(player)) then
						self:y(SCREEN_TOP+61*WideScreenDiff())
					else
						self:y(SCREEN_TOP+41*WideScreenDiff())
					end
				else
					self:y(SCREEN_TOP+51*WideScreenDiff())
				end
			else
				self:y(SCREEN_TOP+61*WideScreenDiff())
			end
			if IsGame("pump") then self:addy(10) if GAMESTATE:GetNumPlayersEnabled() == 1 and getenv("RotationSolo"..pname(player)) then self:CenterX() end end
		end,
		JudgmentMessageCommand=function(self,param)
			local short = ToEnumShortString(param.TapNoteScore or param.HoldNoteScore)
			local update = weight[short] and weight[short] > 0
			if param.Player == player and update then self:stoptweening():queuecommand("RedrawScore") end
		end,
		RedrawScoreCommand=function(self)
			local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
			local output = 0
			if isSurvival(player) then
				self:settext(SecondsToMSSMsMs(pss:GetLifeRemainingSeconds())) -- SURVIVAL
			elseif scoreType == 1 then
				output = animateScore(pss:GetScore(),displayScore)
				self:settextf("%09d",output) -- SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(9-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
			elseif scoreType == 2 then
				output = animateScore(pss:GetPercentDancePoints()*10000,displayScore)/100
				self:settextf("%1.2f%%",output) -- PERCENT
			elseif scoreType == 3 then
				output = animateScore(pss:GetActualDancePoints(),displayScore)
				self:settextf("%04d",output) -- EX
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(4-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
			end
		end
	}
}