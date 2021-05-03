return Def.ActorFrame{
	LoadFont("_v 26px bold shadow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-144;y,SCREEN_TOP+32;zoom,0.8;horizalign,right;diffusealpha,0;);
		BeginCommand=function(self)
			local highScoresType = THEME:GetMetric(Var "LoadingScreen","HighScoresType")
			local stepsType = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType1")
			local out = THEME:GetString("HighScoresType",ToEnumShortString(highScoresType))
			out = out .." ".. THEME:GetString("StepsType",ToEnumShortString(stepsType))
			self:settext(out)
		end;
		OnCommand=cmd(linear,.5;diffusealpha,1);
		OffCommand=cmd(sleep,.5;linear,.5;diffusealpha,0);
	};
};