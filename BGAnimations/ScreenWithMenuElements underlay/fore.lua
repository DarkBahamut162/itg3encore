local t = Def.ActorFrame{
	LoadActor("_top");
	LoadActor("flare")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_LEFT-128):y(40) end;
		OnCommand=function(self) self:queuecommand("Animate") end;
		AnimateCommand=function(self) self:sleep(0.6):rotationz(0):linear(1):x(SCREEN_RIGHT+128):rotationz(360) end;
	};
	LoadActor("flare")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_RIGHT+128):y(440) end;
		OnCommand=function(self) self:queuecommand("Animate") end;
		AnimateCommand=function(self) self:sleep(0.6):rotationz(0):linear(1):x(SCREEN_LEFT-128):rotationz(360) end;
	};
}

return t