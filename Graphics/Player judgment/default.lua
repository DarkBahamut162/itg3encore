local c;
local player = Var "Player";

local JudgeCmds = {
	TapNoteScore_W1 = THEME:GetMetric( "Judgment", "JudgmentW1Command" );
	TapNoteScore_W2 = THEME:GetMetric( "Judgment", "JudgmentW2Command" );
	TapNoteScore_W3 = THEME:GetMetric( "Judgment", "JudgmentW3Command" );
	TapNoteScore_W4 = THEME:GetMetric( "Judgment", "JudgmentW4Command" );
	TapNoteScore_W5 = THEME:GetMetric( "Judgment", "JudgmentW5Command" );
	TapNoteScore_Miss = THEME:GetMetric( "Judgment", "JudgmentMissCommand" );
};

local TNSFrames = {
	TapNoteScore_W1 = 0;
	TapNoteScore_W2 = 1;
	TapNoteScore_W3 = 2;
	TapNoteScore_W4 = 3;
	TapNoteScore_W5 = 4;
	TapNoteScore_Miss = 5;
};

local TNSRotationZ = {
	TapNoteScore_W1 = 0;
	TapNoteScore_W2 = 0;
	TapNoteScore_W3 = 3;
	TapNoteScore_W4 = 5;
	TapNoteScore_W5 = 10;
	TapNoteScore_Miss = 30;
};

return Def.ActorFrame {
	LoadActor("_judgments") .. {
		Name="Judgment";
		InitCommand=function(self) self:pause():visible(false) end;
		ResetCommand=function(self) self:finishtweening():x(0):y(0):stopeffect():visible(false) end;
	};
	InitCommand = function(self)
		c = self:GetChildren();
	end;

	JudgmentMessageCommand=function(self, param)
		if param.Player ~= player then return end;
		if not param.TapNoteScore then return end;
		if param.HoldNoteScore then return end;
		local tns = param.TapNoteScore

		local iNumStates = c.Judgment:GetNumStates();
		local iFrame = TNSFrames[tns];
		if not iFrame then return end
		if iNumStates == 12 then
			iFrame = iFrame * 2;
			if not param.Early then
				iFrame = iFrame + 1;
			end
		end
		self:playcommand("Reset");

		c.Judgment:visible( true );
		c.Judgment:setstate( iFrame );
		JudgeCmds[param.TapNoteScore](c.Judgment);
		-- handle rotation
		if tns == 'TapNoteScore_W1' or tns == 'TapNoteScore_W2' then
			c.Judgment:rotationz(0)
		else
			c.Judgment:rotationz( TNSRotationZ[tns] * StepEvenOdd(param.Player) );
		end
	end;
	HealthStateChangedMessageCommand=function(self, param)
		local State = GAMESTATE:GetPlayerState(player)
		if State:GetHealthState() == "HealthState_Dead" then
			self:visible(false);
		end
	end;
};