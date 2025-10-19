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

local faplus = getenv("SetScoreFA"..pname(player))
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

if not isEtterna() then
	W0 = W0 + Wadd
	W5 = W5 + Wadd
end

local W0Counter = getenv("W0"..pname(player)) or 0
local WXCounter = getenv("WX"..pname(player)) or 0
local judgment

setenv("checkFantastics"..pname(player),true)
setenv("checkPerfects"..pname(player),true)
setenv("checkGreats"..pname(player),true)
setenv("check"..pname(player),true)
setenv("checkAuto"..pname(player),true)

if not isOutFox() then GAMESTATE:ApplyGameCommand('mod,savescore',player) end
if IsGame("po-mu") or IsGame("popn") then
	judgment = "_pop 1x"
else
	judgment = not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSteps(player):GetDifficulty() == 'Difficulty_Beginner' and "_beginner 2x" or "_judgments 2x"
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
	end,
	JudgmentMessageCommand=function(self, param)
		if param.Player ~= player then return end
		if not param.TapNoteScore then return end
		if param.HoldNoteScore then
			if isMGD(player) then
				if param.HoldNoteScore == "HoldNoteScore_Held" then
					glifemeter = screen:GetLifeMeter(player):GetLivesLeft()
					if glifemeter < 100 then screen:GetLifeMeter(player):ChangeLives(1) end
				elseif param.HoldNoteScore == "HoldNoteScore_LetGo" then
					screen:GetLifeMeter(player):ChangeLives(-1)
				end
			end
			return
		end
		if isEtterna() then JudgmentTransformCommand( self, {["Player"] = PLAYER_1, ["bReverse"] = GAMESTATE:GetPlayerState():GetCurrentPlayerOptions():UsingReverse()} ) end

		if GAMESTATE:GetCurrentGame():CountNotesSeparately() then param = GetTrueJudgment(param,player) end
		local tns = param.TapNoteScore
		if tns == "TapNoteScore_None" or tns == "" then return end
		local iNumStates = c.Judgment:GetNumStates()
		local iFrame = TNSFrames[tns]
		if not iFrame then return end
		if not GAMESTATE:GetCurrentGame():CountNotesSeparately() and faplus and iFrame then
			WXCounter = WXCounter + 1
			setenv("WX"..pname(player),WXCounter)
			if tns == "TapNoteScore_W1" and math.abs(param.TapNoteOffset) <= W0 then
				tns = "TapNoteScore_W0"
				iFrame = TNSFrames[tns]
				W0Counter = W0Counter + 1
				setenv("W0"..pname(player),W0Counter)
			end
			MESSAGEMAN:Broadcast("W0",{Player=player,W0=W0Counter,WX=WXCounter})
		end

		if ((GAMESTATE:GetPlayerState(player):GetPlayerController() == 'PlayerController_Autoplay') or
		(GAMESTATE:GetPlayerState(player):GetPlayerController() == 'PlayerController_Cpu')) and
		getenv("checkAuto"..pname(player)) then
			if not isOutFox() then GAMESTATE:ApplyGameCommand('mod,no savescore',player) end
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
				setenv("LastFantastic"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
			end
			if getenv("checkPerfects"..pname(player)) and iFrame > 1 then
				setenv("checkPerfects"..pname(player),false)
				setenv("LastPerfect"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
			end
			if getenv("checkGreats"..pname(player)) and iFrame > 2 then
				setenv("checkGreats"..pname(player),false)
				setenv("LastGreat"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
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
			c.Judgment:rotationz(IsGame("po-mu") and (getenv("Rotation"..pname(player)) == 2 and 90 or -90) or 0 + math.min(math.abs(param.TapNoteOffset), W5) * 10 / W5 * StepEvenOdd(param.Player))
		end
		JudgeCmds[param.TapNoteScore](c.Judgment)
		c.Judgment:setstate( iFrame )
		c.Judgment:visible( true )
	end,
	OffCommand=function(self)
		if getenv("checkFantastics"..pname(player)) then setenv("LastFantastic"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
		if getenv("checkPerfects"..pname(player)) then setenv("LastPerfect"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
		if getenv("checkGreats"..pname(player)) then setenv("LastGreat"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
	end
}