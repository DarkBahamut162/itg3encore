local c
local player = Var "Player"
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

local TNSFrames = {
	TapNoteScore_W1 = 0,
	TapNoteScore_W2 = 1,
	TapNoteScore_W3 = 2,
	TapNoteScore_W4 = 3,
	TapNoteScore_W5 = 4,
	TapNoteScore_Miss = 5
}

local timing = GetTimingDifficulty()
local timingChange = { 1.50,1.33,1.16,1.00,0.84,0.66,0.50,0.33,0.20 }
local judgment = not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSteps(player):GetDifficulty() == 'Difficulty_Beginner' and "_beginner" or "_judgments"
local JudgeScale = isOutFoxV() and GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):JudgeScale() or 1
local W5 = PREFSMAN:GetPreference("TimingWindowSecondsW5")*timingChange[timing]*JudgeScale

setenv("checkFantastics"..pname(player),true)
setenv("checkPerfects"..pname(player),true)
setenv("checkGreats"..pname(player),true)
setenv("check"..pname(player),true)

return Def.ActorFrame {
	Def.Sprite {
		Texture = judgment,
		Name="Judgment",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(0):y(IsGame("po-mu") and -45 or 0):stopeffect():visible(false) end
	},
	InitCommand = function(self) c = self:GetChildren() end,
	OnCommand=function(self) screen = SCREENMAN:GetTopScreen() end,
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
		local tns = param.TapNoteScore
		local iNumStates = c.Judgment:GetNumStates()
		local iFrame = TNSFrames[tns]

		if (GAMESTATE:GetPlayerState(player):GetPlayerController() == 'PlayerController_Autoplay') or
		(GAMESTATE:GetPlayerState(player):GetPlayerController() == 'PlayerController_Cpu') then
			setenv("checkFantastics"..pname(player),false)
			setenv("checkPerfects"..pname(player),false)
			setenv("checkGreats"..pname(player),false)
			setenv("check"..pname(player),false)
			setenv("EvalCombo"..pname(player),false)
		end
		if not iFrame then return end
		if getenv("check"..pname(player)) then
			if getenv("checkFantastics"..pname(player)) and iFrame > 0 then
				setenv("checkFantastics"..pname(player),false)
				setenv("LastFantastic"..pname(player),STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
			end
			if getenv("checkPerfects"..pname(player)) and iFrame > 1 then
				setenv("checkPerfects"..pname(player),false)
				setenv("LastPerfect"..pname(player),STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
			end
			if getenv("checkGreats"..pname(player)) and iFrame > 2 then
				setenv("checkGreats"..pname(player),false)
				setenv("LastGreat"..pname(player),STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
				setenv("check"..pname(player),false)
			end
		end
		if self:GetName() ~= "Judgment" then if param.FirstTrack ~= tonumber(ToEnumShortString(self:GetName())) then return end end
		if iNumStates == 12 then
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
		if getenv("checkFantastics"..pname(player)) then setenv("LastFantastic"..pname(player),STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
		if getenv("checkPerfects"..pname(player)) then setenv("LastPerfect"..pname(player),STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
		if getenv("checkGreats"..pname(player)) then setenv("LastGreat"..pname(player),STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
	end
}