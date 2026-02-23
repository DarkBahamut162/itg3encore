local pn = ...
local player = nil
local scoreType = (getenv("SetScoreType"..pname(pn)) or 2) == 4 and getenv("SetScoreDirection"..pname(pn)) ~= 1
local scoreDirection = 2
local pnFlare = getenv("Flare"..pname(pn))
local old = getenv("FlareType"..pname(pn)) == 1
local float = getenv("FlareFloat"..pname(pn))
local level = float and 10 or pnFlare
local life = 10000
local lifeTotal = {10000,10000,10000,10000,10000,10000,10000,10000,10000,10000}
local lifeAccurate = {800000,850000,900000,930000,955000,960000,970000,980000,990000,995000}
local displayScore = 1000000
local maxScore = 1000000
if old then
	lifeAccurate[1] = 920000
	lifeAccurate[2] = 930000
	lifeAccurate[3] = 940000
	lifeAccurate[4] = 950000
end

local function GetLifeSub(lv)
	if old then
		return {
			TapNoteScore_W2 = flareOld[lv][1],
			TapNoteScore_W3 = flareOld[lv][2],
			TapNoteScore_W4 = flareOld[lv][3],
			TapNoteScore_W5 = flareOld[lv][4],
			TapNoteScore_Miss = flareOld[lv][4],
			TapNoteScore_HitMine = flareOld[lv][4],
			HoldNoteScore_LetGo = flareOld[lv][4],
		}
	end
    return {
        TapNoteScore_W2 = flareNew[lv][1],
        TapNoteScore_W3 = flareNew[lv][2],
        TapNoteScore_W4 = flareNew[lv][3],
        TapNoteScore_W5 = flareNew[lv][4],
        TapNoteScore_Miss = flareNew[lv][4],
        TapNoteScore_HitMine = flareNew[lv][4],
        HoldNoteScore_LetGo = flareNew[lv][4],
    }
end

local lifeSub = GetLifeSub(level)
local lifeSubTotal = {
	GetLifeSub(1),
	GetLifeSub(2),
	GetLifeSub(3),
	GetLifeSub(4),
	GetLifeSub(5),
	GetLifeSub(6),
	GetLifeSub(7),
	GetLifeSub(8),
	GetLifeSub(9),
	GetLifeSub(10),
}
local lifeCount = {
	TapNoteScore_W2 = 0,
	TapNoteScore_W3 = 0,
	TapNoteScore_W4 = 0,
	TapNoteScore_W5 = 0,
	TapNoteScore_Miss = 0,
	TapNoteScore_HitMine = 0,
	HoldNoteScore_LetGo = 0,
}
local floatDisplay = {
	{0,"10000|10000|10000|10000|10000|10000|10000|10000|10000|10000"}
}
local lastFloat = "10000|10000|10000|10000|10000|10000|10000|10000|10000|10000"
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
local animate = ThemePrefs.Get("AnimatePlayerScore")
local accurate = getenv("FlareAccurate"..pname(pn))
local stopping,stop = false,true
local time = GetTimeSinceStart()
local update = true
local stepSize = 1
local dif = 4
local c

local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
if StepsOrTrail then
	if IsCourseSecret() or not IsCourseFixed() then
		stepSize = RadarCategory_Trail(StepsOrTrail,pn,"RadarCategory_TapsAndHolds")
		stepSize = math.max(stepSize + RadarCategory_Trail(StepsOrTrail,pn,"RadarCategory_Holds") + RadarCategory_Trail(StepsOrTrail,pn,"RadarCategory_Rolls"),1)
	else
		stepSize = StepsOrTrail:GetRadarValues(pn):GetValue("RadarCategory_TapsAndHolds") or 0
		stepSize = math.max(stepSize + StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Holds') + StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Rolls'),1)
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

	if not stop and update and (displayScore > 0 or (isSurvival(pn) and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() >= GAMESTATE:GetCurrentSong():GetFirstSecond())) then c["Score"..pname(pn)]:queuecommand("RedrawScore") end
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

return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) c=self:GetChildren() self:addx(pn == PLAYER_1 and -100 or 100):queuecommand("RedrawScore"):sleep(0.5):decelerate(0.8):addx(pn == PLAYER_1 and 100 or -100) end,
		OnCommand=function(self) if (isGamePlay() or isSurvival(pn)) and accurate then self:SetUpdateFunction(UpdateScore) end self:visible(accurate) end,
		OffCommand=function(self) stopping = true if not IsGame("pump") then if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addx(pn == PLAYER_1 and -100 or 100) end end,
		Def.BitmapText {
			File = "_r bold numbers",
			Name="Target"..pname(pn),
			InitCommand=function(self)
				self:visible(not getenv("HideScore"..pname(pn))):x(math.floor(scale(pn == PLAYER_1 and 0.05 or 0.95,0,1,SCREEN_LEFT,SCREEN_RIGHT))):zoomx(0.3*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):y(SCREEN_TOP+(getenv("SetPacemakerFail"..pname(pn)) > 1 and 76 or 66)*WideScreenDiff())
				self:settextf("%07d",lifeAccurate[level]) -- SN SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(7-string.len(''..lifeAccurate[level]), 0),
					Diffuse = PlayerColorSemi(nil),
				})
			end,
			ChangeBorderMessageCommand=function(self,param)
				if param.Player == pn then
					self:settextf("%07d",lifeAccurate[param.Level] or 0) -- SN SCORE
					self:ClearAttributes()
					self:AddAttribute(0, {
						Length = math.max(7-string.len(''..(lifeAccurate[param.Level] or 0)), 0),
						Diffuse = PlayerColorSemi(nil),
					})
					if param.Level == getenv("Flare"..pname(pn)) then self:diffuseshift():effectperiod(0.5):effectcolor1(Color("Red")):effectcolor2(Color("White")) end
				end
			end
		},
		Def.BitmapText {
			File = (scoreType and "_r bold shadow" or "_r bold numbers"),
			Name="Score"..pname(pn),
			InitCommand=function(self)
				self:visible(not getenv("HideScore"..pname(pn))):diffuse(PlayerColor(pn)):x(math.floor(scale(pn == PLAYER_1 and 0.05 or 0.95,0,1,SCREEN_LEFT,SCREEN_RIGHT))):zoomx((not scoreType and 0.3 or 0.4)*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):y(SCREEN_TOP+(getenv("SetPacemakerFail"..pname(pn)) > 1 and 66 or 56)*WideScreenDiff())
			end,
			JudgmentMessageCommand=function(self,param)
				if stop then stop = false end
				if (param.HoldNoteScore and SN[param.HoldNoteScore]) or SN[param.TapNoteScore] then else return end
				if param.Player == pn then self:stoptweening():queuecommand("RedrawScore") end
			end,
			RedrawScoreCommand=function(self)
				local output = 0
				local score = 0
                local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local w1 = stats:GetTapNoteScores('TapNoteScore_W1')
				local w2 = stats:GetTapNoteScores('TapNoteScore_W2')
				local w3 = stats:GetTapNoteScores('TapNoteScore_W3')
				local hd = stats:GetHoldNoteScores('HoldNoteScore_Held')
				if scoreDirection == 1 then
					local score = (w1 + w2 + w3 + hd) * 100000 / stepSize
					local sub = (w3*0.5) * 100000 / stepSize
					score = (math.floor(score-sub)-(w2+w3))*10
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
				if not scoreType then
					self:settextf("%07d",output)
					self:ClearAttributes()
					self:AddAttribute(0, {
						Length = math.max(7-string.len(''..output), 0),
						Diffuse = PlayerColorSemi(pn),
					})
				else
					self:settext("FLARE "..flareName[level])
				end
			end,
			OffCommand=function(self) if scoreDirection == 2 then scoreDirection = 1 self:queuecommand("RedrawScore") end end
		}
	},
    OnCommand=function(self)
		self:draworder(1):sleep(0.5):queuecommand("TweenOn")
		player = SCREENMAN:GetTopScreen():GetChild('Player'..pname(pn))
        self:SetUpdateFunction(function(self)
			if player and level then player:SetLife(0.0001*life) end
        end)
		MESSAGEMAN:Broadcast("ChangeBorder",{
			Player = pn,
			Level = level,
			Color = flareColor[level],
			Name = 'FLARE '..flareName[level]
		})
    end,
	OffCommand=function(self)
		self:queuecommand("Hide")
		if float then
			local output = ""
			for i = 1, level do output=addToOutput(output,lifeTotal[i],"|") end
			setenv("FlareDisplay"..pname(pn),floatDisplay)
		end
	end,
	Def.BitmapText {
		File = "_z 36px black",
		OnCommand=function(self)
			local xPN = pn == PLAYER_1 and SCREEN_LEFT+(isFinal() and WideScaleFixed(20*WideScreenDiff(),35*WideScreenDiff()) or 20*WideScreenDiff()) or SCREEN_RIGHT-(isFinal() and WideScaleFixed(20*WideScreenDiff(),35*WideScreenDiff()) or 20*WideScreenDiff())
			self:visible(not getenv("HideLifeP1")):diffusealpha(IsGame("pump") and 0 or 1):zoom(0.5*WideScreenDiff()):x(xPN):y(SCREEN_CENTER_Y-120*WideScreenDiff()):addx(pn == PLAYER_1 and -100 or 100):sleep(0.5):decelerate(0.8):addx(pn == PLAYER_1 and 100 or -100)
		end,
		OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.4):addx(pn == PLAYER_1 and -100 or 100) end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == pn then
				if param.Level == 0 then
					self:diffusealpha(0)
				elseif param.Level == 10 then
					self:rainbow()
				else
					self:stopeffect():diffuse(color(param.Color))
				end
				self:settext(flareName[param.Level] or "")
			end
		end
	},
	ShowGameplayTopFrameMessageCommand=function(self) self:playcommand("TweenOn") end,
	HideGameplayTopFrameMessageCommand=function(self) self:queuecommand("Hide") end,
	HideCommand=function(self)
		if AnyPlayerFullComboed() then self:sleep(1) end
		self:queuecommand('TweenOff')
	end,
	JudgmentMessageCommand=function(self, params)
		if pn == params.Player then else return end
		--if accurate and ((params.HoldNoteScore and SN[params.HoldNoteScore]) or SN[params.TapNoteScore]) then else return end
		if not string.find(params.TapNoteScore,"Checkpoint") and not string.find(params.TapNoteScore,"None") and params.TapNoteScore ~= "TapNoteScore_" then
			if level and level < 1 then return end
			local scoreSN = 0
			if accurate then
				local score = 0
                local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local w1 = stats:GetTapNoteScores('TapNoteScore_W1')
				local w2 = stats:GetTapNoteScores('TapNoteScore_W2')
				local w3 = stats:GetTapNoteScores('TapNoteScore_W3')
				local hd = stats:GetHoldNoteScores('HoldNoteScore_Held')
				local w4 = stats:GetTapNoteScores('TapNoteScore_W4')
				local w5 = stats:GetTapNoteScores('TapNoteScore_W5')
				local ms = stats:GetTapNoteScores('TapNoteScore_Miss')
				local lg = stats:GetHoldNoteScores('HoldNoteScore_LetGo')
				local mh = stats:GetHoldNoteScores('HoldNoteScore_MissedHold')
				local curMaxScore = (w1+w2+w3+w4+w5+ms+hd+lg+mh) * 100000 / stepSize
				local subScore = (w3*0.5) * 100000 / stepSize
				score = (w1 + w2 + w3 + hd) * 100000 / stepSize
				scoreSN = 1000000-(math.ceil(curMaxScore-score+subScore)+w2+w3)*10
			end
			local noteScore = params.HoldNoteScore or params.TapNoteScore
			local sub = (lifeSub[noteScore] or 0) + ((level == nil and life >= 10000 and lifeSub[noteScore] > 0) and 1000 or 0)
			if accurate then sub = ((scoreSN - lifeAccurate[level]) / (1000000-lifeAccurate[level])) * 10000 end
			if player then
				if lifeCount[noteScore] then lifeCount[noteScore] = lifeCount[noteScore] + 1 end
				life = life-sub
				if accurate then life = sub end
				if float and life <= 0 and level > pnFlare then
					local sumSub = 0
					if level > 1 then
						while level > 1 do
							level = level-1
							SOUND:PlayOnce(THEME:GetPathS("ScreenOptions", "toggle off"), true)
							MESSAGEMAN:Broadcast("ChangeBorder",{
								Player = pn,
								Level = level,
								Color = flareColor[level],
								Name = 'FLARE '..flareName[level]
							})
							if level < 1 then break end
							if accurate then
								sumSub = ((scoreSN - lifeAccurate[level]) / (1000000-lifeAccurate[level])) * 10000
							else
								lifeSub = GetLifeSub(level)
								sumSub = lifeCount.TapNoteScore_W2*lifeSub.TapNoteScore_W2
									+lifeCount.TapNoteScore_W3*lifeSub.TapNoteScore_W3
									+lifeCount.TapNoteScore_W4*lifeSub.TapNoteScore_W4
									+lifeCount.TapNoteScore_W5*lifeSub.TapNoteScore_W5
									+lifeCount.TapNoteScore_Miss*lifeSub.TapNoteScore_Miss
									+lifeCount.TapNoteScore_HitMine*lifeSub.TapNoteScore_HitMine
									+lifeCount.HoldNoteScore_LetGo*lifeSub.HoldNoteScore_LetGo
							end
							if sumSub < 10000 then break end
						end
					end
					if level < 1 then
						life = -1
						STATSMAN:GetCurStageStats():GetPlayerStageStats(player):FailPlayer()
					else
						life = 10000 - sumSub
					end
				end
				if life <= 0 and level <= pnFlare then
					player:SetLife(0)
					if float then
						MESSAGEMAN:Broadcast("ChangeBorder",{
							Player = pn,
							Level = 0,
							Color = "#FFFFFF",
							Name = ''
						})
					end
				elseif life == 0 then
					player:SetLife(0.0001)
				else
					player:SetLife(0.0001 * life)
				end
				local output = ""
				for i = 1, level do
					local sumSub = 0
					if accurate then
						sumSub = 10000 - ((scoreSN - lifeAccurate[i]) / (1000000-lifeAccurate[i])) * 10000
					else
						sumSub = lifeCount.TapNoteScore_W2*lifeSubTotal[i].TapNoteScore_W2
							+lifeCount.TapNoteScore_W3*lifeSubTotal[i].TapNoteScore_W3
							+lifeCount.TapNoteScore_W4*lifeSubTotal[i].TapNoteScore_W4
							+lifeCount.TapNoteScore_W5*lifeSubTotal[i].TapNoteScore_W5
							+lifeCount.TapNoteScore_Miss*lifeSubTotal[i].TapNoteScore_Miss
							+lifeCount.TapNoteScore_HitMine*lifeSubTotal[i].TapNoteScore_HitMine
							+lifeCount.HoldNoteScore_LetGo*lifeSubTotal[i].HoldNoteScore_LetGo
					end
					lifeTotal[i]=10000-sumSub
					output=addToOutput(output,lifeTotal[i],"|")
				end

				if lastFloat ~= output then
					lastFloat = output
					floatDisplay[#floatDisplay+1]={isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetAliveSeconds(),output}
				end
			end
		end
	end
}