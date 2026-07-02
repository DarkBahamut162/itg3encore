local c
local player = ...
local screen
local glifemeter = 100

local JudgeCmds = {
	TapNoteScore_W1 = THEME:GetMetric( "Judgment", "JudgmentW1Command" ),
	TapNoteScore_W2 = THEME:GetMetric( "Judgment", "JudgmentW2Command" ),
	TapNoteScore_W3 = THEME:GetMetric( "Judgment", "JudgmentW3Command" ),
	TapNoteScore_W4 = THEME:GetMetric( "Judgment", "JudgmentW4Command" ),
	TapNoteScore_W5 = THEME:GetMetric( "Judgment", "JudgmentW5Command" ),
	TapNoteScore_Miss = THEME:GetMetric( "Judgment", "JudgmentMissCommand" )
}
if isOpenDDR() then
	JudgeCmds = {
		TapNoteScore_W1 = THEME:GetMetric( "Judgment", "JudgmentW1Command" ),
		TapNoteScore_W2 = THEME:GetMetric( "Judgment", "JudgmentW2Command" ),
		TapNoteScore_W3 = THEME:GetMetric( "Judgment", "JudgmentW3Command" ),
		TapNoteScore_W4 = THEME:GetMetric( "Judgment", "JudgmentW4Command" ),
		TapNoteScore_Miss = THEME:GetMetric( "Judgment", "JudgmentMissCommand" )
	}
end

local faplus = getenv("SetScoreFA"..pname(player)) or ThemePrefs.Get("EnableGrooveStats") or isITGmaniaOnline()
local TNSFrames = {
	["TapNoteScore_W0"] = 0,
	["TapNoteScore_W1"] = faplus and 1 or 0,
	["TapNoteScore_W2"] = faplus and 2 or 1,
	["TapNoteScore_W3"] = faplus and 3 or 2,
	["TapNoteScore_W4"] = faplus and 4 or 3,
	["TapNoteScore_W5"] = faplus and 5 or 4,
	["TapNoteScore_Miss"] = faplus and 6 or 5
}

local timing = GetTimingDifficulty()
local timingChange = { 1.50,1.33,1.16,1.00,0.84,0.66,0.50,0.33,0.20 }
local JudgeScale = isOutFoxV(20230624) and GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):JudgeScale() or 1
local W5 = (isOpenDDR() and 0.142 or PREFSMAN:GetPreference("TimingWindowSecondsW5"))*timingChange[timing]*JudgeScale
local W0 = 0.0135*timingChange[timing]*JudgeScale
local Wadd = (isOpenDDR() or isEtterna("0.72")) and 0.0000 or PREFSMAN:GetPreference("TimingWindowAdd")

W0 = W0 + Wadd
W5 = W5 + Wadd

local W0Counter = getenv("W0"..pname(player)) or 0
local W1Counter = getenv("W1"..pname(player)) or 0
local WXCounter = getenv("WX"..pname(player)) or 0
local judgment
local offsetdata = {}
local offsetdataall = {}
local enableOffsets = ThemePrefs.Get("ShowOffset")

setenv("checkFantastics"..pname(player),true)
setenv("checkPerfects"..pname(player),true)
setenv("checkGreats"..pname(player),true)
setenv("check"..pname(player),true)
setenv("checkAuto"..pname(player),true)

GAMESTATE:ApplyGameCommand('mod,savescore',player)
if IsGame("po-mu") or IsGame("popn") then
	judgment = "_pop 1x"
else
	judgment = getenv("Judgment"..pname(player)) or "_itg3"
	judgment = judgment .. ((not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSteps(player):GetDifficulty() == 'Difficulty_Beginner') and "_beginner 2x" or " 2x")
	if judgment:sub(1,5) == "_itg1" then judgment = judgment:gsub("_beginner",""):gsub("2x","1x") end
end
local life = 0
local pn
local stepSize = 1
local calculation

local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
if StepsOrTrail then
	local holdlifts = isOutFox(20210400) and GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Song'):HoldLifts() or false
	if IsCourseSecret() or not IsCourseFixed() then
		stepSize = RadarCategory_Trail(StepsOrTrail,player,"RadarCategory_TapsAndHolds")
		stepSize = math.max(stepSize + (RadarCategory_Trail(StepsOrTrail,player,"RadarCategory_Holds") + RadarCategory_Trail(StepsOrTrail,player,"RadarCategory_Rolls")*(holdlifts and 2 or 1)),1)
	else
		stepSize = StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_TapsAndHolds") or 0
		stepSize = math.max(stepSize + (StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Holds') + StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Rolls'))*(holdlifts and 2 or 1),1)
	end
end
if stepSize > 330 then calculation = 260/stepSize else calculation = 760.5/(stepSize+650) end

local lifeAdd = {
	{
		["Begin"] = 0.22,
		["HoldNoteScore_Held"] = calculation/100,
		["TapNoteScore_W0"] = calculation/100,
		["TapNoteScore_W1"] = calculation/100,
		["TapNoteScore_W2"] = calculation/100,
		["TapNoteScore_W3"] = calculation/50,
		["TapNoteScore_W4"] = -0.012,
		["TapNoteScore_W5"] = -0.024,
		["TapNoteScore_Miss"] = -0.036,
		["HoldNoteScore_LetGo"] = -0.036
	},{
		["Begin"] = 0.22,
		["HoldNoteScore_Held"] = calculation/100,
		["TapNoteScore_W0"] = calculation/100,
		["TapNoteScore_W1"] = calculation/100,
		["TapNoteScore_W2"] = calculation/100,
		["TapNoteScore_W3"] = calculation/50,
		["TapNoteScore_W4"] = -0.016,
		["TapNoteScore_W5"] = -0.032,
		["TapNoteScore_Miss"] = -0.048,
		["HoldNoteScore_LetGo"] = -0.048
	},{
		["Begin"] = 0.22,
		["HoldNoteScore_Held"] = calculation/100,
		["TapNoteScore_W0"] = calculation/100,
		["TapNoteScore_W1"] = calculation/100,
		["TapNoteScore_W2"] = calculation/100,
		["TapNoteScore_W3"] = calculation/50,
		["TapNoteScore_W4"] = -0.02,
		["TapNoteScore_W5"] = -0.04,
		["TapNoteScore_Miss"] = -0.06,
		["HoldNoteScore_LetGo"] = -0.06
	},{
		["Begin"] = 1,
		["HoldNoteScore_Held"] = 0.0016,
		["TapNoteScore_W0"] = 0.0016,
		["TapNoteScore_W1"] = 0.0016,
		["TapNoteScore_W2"] = 0.0016,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = -0.05,
		["TapNoteScore_W5"] = -0.07,
		["TapNoteScore_Miss"] = -0.09,
		["HoldNoteScore_LetGo"] = -0.09
	},{
		["Begin"] = 1,
		["HoldNoteScore_Held"] = 0.0016,
		["TapNoteScore_W0"] = 0.0016,
		["TapNoteScore_W1"] = 0.0016,
		["TapNoteScore_W2"] = 0.0016,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = -0.10,
		["TapNoteScore_W5"] = -0.14,
		["TapNoteScore_Miss"] = -0.18,
		["HoldNoteScore_LetGo"] = -0.18
	},{
		["Begin"] = 1,
		["HoldNoteScore_Held"] = 0.0016,
		["TapNoteScore_W0"] = 0.0016,
		["TapNoteScore_W1"] = 0.0016,
		["TapNoteScore_W2"] = 0.0016,
		["TapNoteScore_W3"] = 0.0004,
		["TapNoteScore_W4"] = -0.015,
		["TapNoteScore_W5"] = -0.020,
		["TapNoteScore_Miss"] = -0.025,
		["HoldNoteScore_LetGo"] = -0.025
	},{
		["Begin"] = 1,
		["HoldNoteScore_Held"] = 0.0016,
		["TapNoteScore_W0"] = 0.0016,
		["TapNoteScore_W1"] = 0.0016,
		["TapNoteScore_W2"] = 0.0016,
		["TapNoteScore_W3"] = 0.0004,
		["TapNoteScore_W4"] = -0.03,
		["TapNoteScore_W5"] = -0.04,
		["TapNoteScore_Miss"] = -0.05,
		["HoldNoteScore_LetGo"] = -0.05
	}
}

local PercentageCheck = PercentageCheck(player)
local level = 0
if GAMESTATE:IsCourseMode() then
	level = getenv("IIDXDifficultyClass"..pname(player))
	if level > 0 then level = level + 5 end
else
	level = getenv("IIDXDifficultyGauge"..pname(player))
end

return Def.ActorFrame{
	Def.Sprite{
		Texture = judgment..(faplus and "7" or "6"),
		Name="Judgment",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(0):y(IsGame("po-mu") and -45 or 0):stopeffect():visible(false) end
	},
	InitCommand = function(self) c = self:GetChildren() end,
	OnCommand=function(self)
		if GAMESTATE:GetCurrentGame():CountNotesSeparately() then GetTrueJudgment(nil,player) end
		screen = SCREENMAN:GetTopScreen()
		self:zoom(judgment == "_pop 1x" and 7/9 or 1):visible(not (getenv("HideJudgment" .. pname(player)) or false))
		if PercentageCheck then
			pn = screen:GetChild('Player'..pname(player))
			life = lifeAdd[level]["Begin"]
			pn:SetLife(life)
		end
	end,
	JudgmentMessageCommand=function(self, param)
		if param.Player ~= player then return end
		if not param.TapNoteScore then return end
		if param.HoldNoteScore then
			if isMGD(player) then
				if param.HoldNoteScore == "HoldNoteScore_Held" then
					if PercentageCheck then life = life + lifeAdd[level]["HoldNoteScore_Held"] end
					glifemeter = screen:GetLifeMeter(player):GetLivesLeft()
					if glifemeter < 100 then screen:GetLifeMeter(player):ChangeLives(1) end
				elseif param.HoldNoteScore == "HoldNoteScore_LetGo" then
					screen:GetLifeMeter(player):ChangeLives(-1)
					local multi = ((level == 4 or level == 6) and life <= 0.3) and 0.5 or 1
					if PercentageCheck then life = life + lifeAdd[level]["HoldNoteScore_LetGo"] end
				end
				if PercentageCheck then pn:SetLife(life) end
			end
			return
		end
		if isEtterna("0.55") then JudgmentTransformCommand( self, {["Player"] = PLAYER_1, ["bReverse"] = GAMESTATE:GetPlayerState():GetCurrentPlayerOptions():UsingReverse()} ) end

		if GAMESTATE:GetCurrentGame():CountNotesSeparately() then param = GetTrueJudgment(param,player) end
		local tns = param.TapNoteScore
		if tns == "TapNoteScore_None" or tns == "" then return end
		if PercentageCheck then
			local add = lifeAdd[level][tns] or 0
			if (level == 4 or level == 6) and life <= 0.3 and add < 0 then add = add*0.5 end
			life = math.min(1,life+add)
			pn:SetLife(life)
		end
		for col,tapnote in pairs(param.Notes or {}) do
			local tnt = ToEnumShortString(tapnote:GetTapNoteType())
			if tnt == "Tap" or tnt == "HoldHead" or tnt == "LongNoteHead" or tnt == "Lift" then
				local tns = tapnote:GetTapNoteResult():GetTapNoteScore()
				local tno = string.format("%0.10f", tapnote:GetTapNoteResult():GetTapNoteOffset())
				if enableOffsets then
					local vStats = STATSMAN:GetCurStageStats():GetPlayerStageStats( player )
					local time = GAMESTATE:IsCourseMode() and vStats:GetAliveSeconds() or GAMESTATE:GetCurMusicSeconds()/GAMESTATE:GetSongOptionsObject("ModsLevel_Song"):MusicRate()
					local noff = tns == "TapNoteScore_Miss" and "Miss" or tonumber(tno)
					local WX = tns == "TapNoteScore_W1" and (math.abs(tonumber(tno)) <= W0 and "TapNoteScore_W0" or "TapNoteScore_W1" ) or tns

					offsetdataall[#offsetdataall+1] = { time, noff, faplus and WX or tns }
				end
			end
		end
		local iNumStates = c.Judgment:GetNumStates()
		local iFrame = TNSFrames[tns]
		if not iFrame then return end
		if not GAMESTATE:GetCurrentGame():CountNotesSeparately() and faplus and iFrame then
			WXCounter = WXCounter + 1
			setenv("WX"..pname(player),WXCounter)
			if tns == "TapNoteScore_W1" then
				if math.abs(param.TapNoteOffset) <= W0 then
					tns = "TapNoteScore_W0"
					iFrame = TNSFrames[tns]
					W0Counter = W0Counter + 1
					setenv("W0"..pname(player),W0Counter)
				else
					W1Counter = W1Counter + 1
					setenv("W1"..pname(player),W1Counter)
				end
			end
			MESSAGEMAN:Broadcast("W0",{Player=player,W0=W0Counter,W1=W1Counter,WX=WXCounter})
		end

		if enableOffsets then
			local vStats = STATSMAN:GetCurStageStats():GetPlayerStageStats( player )
			local time = GAMESTATE:IsCourseMode() and vStats:GetAliveSeconds() or GAMESTATE:GetCurMusicSeconds()/GAMESTATE:GetSongOptionsObject("ModsLevel_Song"):MusicRate()
			local noff = param.TapNoteScore == "TapNoteScore_Miss" and "Miss" or param.TapNoteOffset
			local WX = param.TapNoteScore == "TapNoteScore_W1" and (math.abs(param.TapNoteOffset) <= W0 and "TapNoteScore_W0" or "TapNoteScore_W1" ) or param.TapNoteScore

			iFrame = TNSFrames[faplus and WX or param.TapNoteScore]
			offsetdata[#offsetdata+1] = { time, noff, faplus and WX or param.TapNoteScore }
		end

		if GAMESTATE:GetPlayerState(player):GetPlayerController() ~= 'PlayerController_Human' and getenv("checkAuto"..pname(player)) then
			if not isOutFox(20200530) then GAMESTATE:ApplyGameCommand('mod,no savescore',player) end
			setenv("checkFantastics"..pname(player),false)
			setenv("checkPerfects"..pname(player),false)
			setenv("checkGreats"..pname(player),false)
			setenv("checkAuto"..pname(player),false)
			setenv("check"..pname(player),false)
			setenv("EvalCombo"..pname(player),false)
		end
		if getenv("check"..pname(player)) then
			if getenv("checkFantastics"..pname(player)) and iFrame > 0 then
				setenv("checkFantastics"..pname(player),false)
				setenv("LastFantastic"..pname(player),isEtterna("0.55") and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
			end
			if getenv("checkPerfects"..pname(player)) and iFrame > 1 then
				setenv("checkPerfects"..pname(player),false)
				setenv("LastPerfect"..pname(player),isEtterna("0.55") and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
			end
			if getenv("checkGreats"..pname(player)) and iFrame > 2 then
				setenv("checkGreats"..pname(player),false)
				setenv("LastGreat"..pname(player),isEtterna("0.55") and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
				setenv("check"..pname(player),false)
			end
		end
		if self:GetParent():GetName() ~= "Judgment" then if param.FirstTrack ~= tonumber(ToEnumShortString(self:GetParent():GetName())) then return end end
		if iNumStates == (faplus and 14 or 12) then
			iFrame = iFrame * 2
			if not param.Early then iFrame = iFrame + 1 end
		end
		self:playcommand("Reset")

		if tns == 'TapNoteScore_Miss' then
			c.Judgment:rotationz(IsGame("po-mu") and (getenv("Rotation"..pname(player)) == 2 and 90 or -90) or 0 + (30 * StepEvenOdd(param.Player)))
		else
			c.Judgment:rotationz(IsGame("po-mu") and (getenv("Rotation"..pname(player)) == 2 and 90 or -90) or 0 + math.min(param.TapNoteOffset, W5) * 10 / W5)
		end
		JudgeCmds[param.TapNoteScore](c.Judgment)
		c.Judgment:setstate( iFrame )
		c.Judgment:visible( true )
	end,
	OffCommand=function(self)
		setenv("OffsetTable"..pname(player),offsetdata)
		setenv("OffsetTableAll"..pname(player),offsetdataall)
		if getenv("checkFantastics"..pname(player)) then setenv("LastFantastic"..pname(player),isEtterna("0.55") and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
		if getenv("checkPerfects"..pname(player)) then setenv("LastPerfect"..pname(player),isEtterna("0.55") and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
		if getenv("checkGreats"..pname(player)) then setenv("LastGreat"..pname(player),isEtterna("0.55") and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
	end
}