return Def.ActorFrame{
	LoadFont("_v 26px bold shadow")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-144):y(SCREEN_TOP+32):zoom(0.8):horizalign(right):diffusealpha(0) end;
		BeginCommand=function(self)
			local highScoresType = THEME:GetMetric(Var "LoadingScreen","HighScoresType")
			local stepsType = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType1")
			local out = THEME:GetString("HighScoresType",ToEnumShortString(highScoresType))
			out = out .." ".. THEME:GetString("StepsType",ToEnumShortString(stepsType))
			self:settext(out)
		end;
		OnCommand=function(self) self:linear(0.5):diffusealpha(1) end;
		OffCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(0) end;
	};
};