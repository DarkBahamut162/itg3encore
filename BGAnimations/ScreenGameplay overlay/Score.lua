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

if scoreType == 1 or scoreType == 4 then dif = 4 elseif scoreType == 2 or scoreType == 5 then dif = 10 elseif scoreType == 3 then dif = 5 end

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

local wife3_mine_hit_weight = -7
local wife3_hold_drop_weight = -4.5
local wife3_miss_weight = -5.5

function getMaxNotes(player)
	local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
	local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
	if StepsOrTrail then
		if GAMESTATE:GetCurrentGame():CountNotesSeparately() then
			if not VersionDateCheck(20150500) then
				return RadarCategory_Notes(SongOrCourse,StepsOrTrail)
			else
				return StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_Notes")
			end
		else
			return StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_TapsAndHolds") or 0
		end
	end
	return 0
end

local curwifescore = 0
local maxwifescore = 0
local totalwifescore = getMaxNotes(player)*2

function wifeF(x)
	local a1 = 0.254829592
	local a2 = -0.284496736
	local a3 = 1.421413741
	local a4 = -1.453152027
	local a5 = 1.061405429
	local p = 0.3275911

	local sign = x < 0 and -1 or 1
	x = math.abs(x)

	local t = 1 / (1 + p * x)
	local y = 1 - (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t * math.exp(-x * x)
	return sign * y
end

function wife3(maxms,ts)
	local j_pow = 0.75
	local max_points = 2
	local ridic = 5 * ts
	local max_boo_weight = 180 * ts

	maxms = math.abs(maxms * 1000)

	if maxms <= ridic then return max_points end

	local zero = 65 * math.pow(ts, j_pow)
	local dev = 22.7 * math.pow(ts, j_pow)

	if maxms <= zero then
		return max_points * wifeF((zero - maxms) / dev)
	elseif maxms <= max_boo_weight then
		return (maxms - zero) * wife3_miss_weight / (max_boo_weight - zero)
	end

	return wife3_miss_weight
end

local stepSize = 1

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
	OnCommand=function(self)
		if isGamePlay() or isSurvival(player) then self:SetUpdateFunction(UpdateScore) end self:visible(isGamePlay())
		if scoreType == 4 then
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
			if StepsOrTrail then
				stepSize = StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_TapsAndHolds") or 0
				stepSize = math.max(stepSize + StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Holds') + StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Rolls'),1)
			end
		end
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
			elseif scoreType == 2 or scoreType == 5 then
				displayScore = 10000
			elseif scoreType == 3 then
				displayScore = DPMax(player)
			else
				displayScore = 1000000
				maxScore = 1000000
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
			if scoreType == 5 then
				if param.Player == player then
					if param.HoldNoteScore then
						if param.HoldNoteScore == "HoldNoteScore_LetGo" or param.HoldNoteScore == "HoldNoteScore_MissedHold" then
							curwifescore = curwifescore + wife3_hold_drop_weight
						end
					elseif param.TapNoteScore and not param.HoldNoteScore then
						if param.TapNoteScore == "TapNoteScore_HitMine" then
							curwifescore = curwifescore + wife3_mine_hit_weight
						elseif param.TapNoteScore == "TapNoteScore_Miss" then
							curwifescore = curwifescore + wife3_miss_weight
							maxwifescore = maxwifescore + 2
						elseif param.TapNoteScore == "TapNoteScore_W1" or param.TapNoteScore == "TapNoteScore_W2" or param.TapNoteScore == "TapNoteScore_W3" or param.TapNoteScore == "TapNoteScore_W4" or param.TapNoteScore == "TapNoteScore_W5" then
							curwifescore = curwifescore + wife3(param.TapNoteOffset, 1)
							maxwifescore = maxwifescore + 2
						end
					end
				end
			elseif scoreType == 4 then
				if (param.HoldNoteScore and SN[param.HoldNoteScore]) or SN[param.TapNoteScore] then else return end
			end
			local short = ToEnumShortString(param.HoldNoteScore and param.HoldNoteScore or param.TapNoteScore)
			local update = weight[short] and weight[short] ~= 0
			if scoreType == 4 then update = true end
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
			elseif scoreType == 4 then
				local score = 0
                local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
				local w1 = stats:GetTapNoteScores('TapNoteScore_W1')
				local w2 = stats:GetTapNoteScores('TapNoteScore_W2')
				local w3 = stats:GetTapNoteScores('TapNoteScore_W3')
				local hd = stats:GetHoldNoteScores('HoldNoteScore_Held')
				if scoreDirection == 1 then
					local score = (w1 + w2 + w3 + hd) * 100000 / stepSize
					local sub = (w3*0.5) * 100000 / stepSize
					score = (math.floor(score-sub) - (w2 + w3))*10
					output = animateScore(score,displayScore)
				else
					local w4 = stats:GetTapNoteScores('TapNoteScore_W4')
					local w5 = stats:GetTapNoteScores('TapNoteScore_W5')
					local ms = stats:GetTapNoteScores('TapNoteScore_Miss')
					local lg = stats:GetHoldNoteScores('HoldNoteScore_LetGo')
					local mh = stats:GetHoldNoteScores('HoldNoteScore_MissedHold')
					local curMaxScore = (w1+w2+w3+w4+w5+ms+hd+lg+mh) * 100000 / stepSize
					local subScore = (w3*0.5) * 100000 / stepSize
					score = (w1 + w2 + w3 + hd) * 100000 / stepSize
					output = animateScore(maxScore-(math.ceil(curMaxScore-score+subScore)+w2+w3)*10,displayScore)
				end
				self:settextf("%07d",output) -- SN SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(7-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
			elseif scoreType == 5 then
				if scoreDirection == 1 then
					output = animateScore(math.max(0,(curwifescore/totalwifescore)*10000),displayScore)/100
				else
					output = animateScore((totalwifescore-(maxwifescore-curwifescore))/totalwifescore*10000,displayScore)/100
				end
				self:settextf("%1.2f%%",output) -- WIFE3
			end
		end,
		OffCommand=function(self) if scoreType == 5 then setenv("WIFE3"..pname(player),curwifescore/totalwifescore) end end
	}
}