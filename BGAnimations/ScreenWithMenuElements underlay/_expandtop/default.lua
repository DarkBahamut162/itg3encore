local t = Def.ActorFrame{
	LoadActor("_width")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+180):valign(0):halign(0):zoomtowidth(SCREEN_WIDTH-630) end;
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("_lside")..{
		InitCommand=function(self) self:x(SCREEN_LEFT):halign(0):valign(0) end;
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("_rside")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT):halign(1):valign(0) end;
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("_lmask")..{
		InitCommand=function(self) self:x(SCREEN_LEFT):halign(0):valign(0):zwrite(true):blend('BlendMode_NoEffect'):draworder(110) end;
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("up1")..{
		InitCommand=function(self) self:x(SCREEN_LEFT):halign(0):valign(0):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.9):diffusealpha(1)
			:cropleft(-0.3*(SCREEN_WIDTH/180)):cropright(1):faderight(0.1*(SCREEN_WIDTH/180)):fadeleft(0.1*(SCREEN_WIDTH/180))
			:linear(2.5*(180/SCREEN_WIDTH))
			:cropleft(1):cropright(-0.3*(SCREEN_WIDTH/180))
			:sleep(0.1+(2.5*((SCREEN_WIDTH-180)/SCREEN_WIDTH))):queuecommand("On") end;
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addy(-100) end;
	};
	LoadActor("up2")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+180):valign(0):halign(0):zoomtowidth(SCREEN_WIDTH-630):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.9+(2.5*(180*0.6/SCREEN_WIDTH))):diffusealpha(1)
			:cropleft(-0.3*(SCREEN_WIDTH/(SCREEN_WIDTH-630))):cropright(1):faderight(0.1*(SCREEN_WIDTH/(SCREEN_WIDTH-630))):fadeleft(0.1*(SCREEN_WIDTH/(SCREEN_WIDTH-630)))
			:linear(2.5*((SCREEN_WIDTH-630)/SCREEN_WIDTH))
			:cropleft(1):cropright(-0.3*(SCREEN_WIDTH/(SCREEN_WIDTH-630)))
			:sleep(0.1+(2.5*(180*0.4/SCREEN_WIDTH))+(2.5*(450/SCREEN_WIDTH))):queuecommand("On") end;
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addy(-100) end;
	};
	LoadActor("up3")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT):halign(1):valign(0):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.9+(2.5*((SCREEN_WIDTH-450)*0.6/SCREEN_WIDTH))):diffusealpha(1)
			:cropleft(-0.3*(SCREEN_WIDTH/450)):cropright(1):faderight(0.1*(SCREEN_WIDTH/450)):fadeleft(0.1*(SCREEN_WIDTH/450))
			:linear(2.5*(450/SCREEN_WIDTH))
			:cropleft(1):cropright(-0.3*(SCREEN_WIDTH/450))
			:sleep(0.1+(2.5*((SCREEN_WIDTH-450)*0.4/SCREEN_WIDTH))):queuecommand("On") end;
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addy(-100) end;
	};
};

return t;