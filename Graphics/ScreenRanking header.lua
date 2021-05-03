return Def.ActorFrame{
	LoadFont("_v 26px bold shadow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-225;y,SCREEN_TOP+32;zoom,0.8;horizalign,left;diffusealpha,0;);
		BeginCommand=function(self)
			local highScoresType = THEME:GetMetric(Var "LoadingScreen","HighScoresType")
			self:settext( THEME:GetString("HighScoresType",ToEnumShortString(highScoresType)) )
		end;
		OnCommand=cmd(linear,.5;diffusealpha,1);
		OffCommand=cmd(sleep,.5;linear,.5;diffusealpha,0);
	};
};