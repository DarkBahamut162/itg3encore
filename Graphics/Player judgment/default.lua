local c
local player = Var "Player"

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

local judgment = not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSteps(player):GetDifficulty() == 'Difficulty_Beginner' and "_beginner" or "_judgments"

return Def.ActorFrame {
	LoadActor(judgment) .. {
		Name="Judgment",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(0):y(0):stopeffect():visible(false) end
	},
	InitCommand = function(self) c = self:GetChildren() end,
	JudgmentMessageCommand=function(self, param)
		if param.Player ~= player then return end
		if not param.TapNoteScore then return end
		if param.HoldNoteScore then return end
		if self:GetName() ~= "Judgment" then
			if param.FirstTrack ~= tonumber(ToEnumShortString(self:GetName())) then return end
		end
		local tns = param.TapNoteScore
		local iNumStates = c.Judgment:GetNumStates()
		local iFrame = TNSFrames[tns]
		if not iFrame then return end
		if iNumStates == 12 then
			iFrame = iFrame * 2
			if not param.Early then iFrame = iFrame + 1 end
		end
		self:playcommand("Reset")
		if tns == 'TapNoteScore_Miss' then
			c.Judgment:rotationz(30 * StepEvenOdd(param.Player))
		else
			c.Judgment:rotationz(math.min(math.abs(param.TapNoteOffset), PREFSMAN:GetPreference("TimingWindowSecondsW5")) * 10 / PREFSMAN:GetPreference("TimingWindowSecondsW5") * StepEvenOdd(param.Player))
		end
		JudgeCmds[param.TapNoteScore](c.Judgment)
		c.Judgment:setstate( iFrame )
		c.Judgment:visible( true )
	end
}