local player = ...
local scoreType = getenv("SetScoreType"..ToEnumShortString(player)) or 2
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

for w,v in pairs(weight) do
	if not isOutFox() and string.find(w,"Pro") then else weight[w] = tonumber(THEME:GetMetric('ScoreKeeperNormal', 'PercentScoreWeight'..w)) end
end

function animateScore(currentScore,fakeScore)
	if currentScore > fakeScore then
		displayScore = fakeScore + math.ceil((currentScore - fakeScore) / 4)
	elseif currentScore < fakeScore then
		displayScore = currentScore
	end
	return displayScore
end

local function UpdateScore(self)
	self:GetChild("Score"..ToEnumShortString(player)):queuecommand("RedrawScore")
end

return Def.ActorFrame{
	OnCommand=function(self) if isGamePlay() and scoreType ~= 2 then self:SetUpdateFunction(UpdateScore) end self:visible(isGamePlay()) end,
	LoadFont("_r bold numbers") .. {
		Name="Score"..ToEnumShortString(player),
		InitCommand=function(self)
			self:visible(not getenv("HideScore"..ToEnumShortString(player))):diffuse(PlayerColor(player)):x(math.floor(scale(player == PLAYER_1 and 0.25 or 0.75,0,1,SCREEN_LEFT,SCREEN_RIGHT)))
			if GAMESTATE:Env()["Workout"] then self:y(SCREEN_TOP+51) else self:y(SCREEN_TOP+61) end
			if scoreType == 1 then
				self:settextf("%09d",0) -- SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(8, 0),
					Diffuse = PlayerColorSemi(player),
				})
			elseif scoreType == 2 then
				self:settext(FormatPercentScore(0)) -- PERCENT
			elseif scoreType == 3 then
				self:settextf("%04d",0) -- EX
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(3, 0),
					Diffuse = PlayerColorSemi(player),
				})
			end
		end,
		OnCommand=function(self) self:addy(-100):sleep(0.5):decelerate(0.8):addy(100) end,
		OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end,
		JudgmentMessageCommand=function(self,param)
			local short = ToEnumShortString(param.TapNoteScore or param.HoldNoteScore)
			local update = weight[short] ~= 0
			if param.Player == player and update then self:queuecommand("RedrawScore") end
		end,
		RedrawScoreCommand=function(self)
			local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
			local output = 0
			if scoreType == 1 then
				output = animateScore(pss:GetScore(),displayScore)
				self:settextf("%09d",output) -- SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(9-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
			elseif scoreType == 2 then
				self:settext(FormatPercentScore(pss:GetPercentDancePoints())) -- PERCENT
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