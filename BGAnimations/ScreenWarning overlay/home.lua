return Def.ActorFrame{
	InitCommand=function(self) self:fov(90):CenterX():y(SCREEN_CENTER_Y-20):addx(800):zoom(3.4):rotationx(90) end;
	OnCommand=function(self) self:linear(4):addx(-1600):decelerate(1.5):CenterX():y(SCREEN_CENTER_Y+180):z(-200):rotationx(30):queuecommand("PlayWag") end;
	PlayWagCommand=function(self) self:wag():effectmagnitude(0,7,0):effectperiod(3) end;
	OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5):addz(-100) end;
	LoadActor(THEME:GetPathG("_platform","home single"))..{ InitCommand=function(self) self:addx(-56) end; };
	LoadActor(THEME:GetPathG("_platform","home single"))..{ InitCommand=function(self) self:addx(56) end; };
};