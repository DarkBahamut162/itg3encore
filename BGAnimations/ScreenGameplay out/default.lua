local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffuse(color("#00000000")) end;
		OnCommand=function(self) self:queuecommand("Check"):linear(0.3):diffusealpha(1):sleep(1) end;
		CheckCommand=function(self) if AnyPlayerFullComboed() then SOUND:PlayOnce( THEME:GetPathS( '', "FullComboSplash" ) ) self:hibernate(3) end; end;
	};

	LoadActor("_round")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75):zoom(0.6):diffusealpha(0):addy(-30) end;
		OnCommand=function(self) self:queuecommand("Check"):sleep(0.3):linear(0.3):diffusealpha(1):addy(30) end;
		CheckCommand=function(self) if AnyPlayerFullComboed() then self:hibernate(3) end; end;
	};

	LoadActor("_cleared bottom")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+15):zoom(0.9):diffusealpha(0):addx(100) end;
		OnCommand=function(self) self:queuecommand("Check"):sleep(0.6):decelerate(0.3):diffusealpha(1):addx(-100):sleep(0.5) end;
		CheckCommand=function(self) if AnyPlayerFullComboed() then self:hibernate(3) end; end;
	};
	LoadActor("_cleared top")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+10):zoom(0.9):blend(Blend.Add):diffusealpha(0):addx(-100) end;
		OnCommand=function(self) self:queuecommand("Check"):sleep(0.6):decelerate(0.3):diffusealpha(1):addx(100):sleep(0.5) end;
		CheckCommand=function(self) if AnyPlayerFullComboed() then self:hibernate(3) end; end;
	};
};

return t;