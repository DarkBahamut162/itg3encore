return Def.ActorFrame{
	LoadActor("arrow")..{
		InitCommand=function(self) self:zoom(0.8):y(6):diffuseshift():effectoffset(0.5):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(3.5):addy(-20):accelerate(0.3):diffusealpha(1):addy(25):decelerate(0.3):addy(-10):accelerate(0.3):addy(10) end;
	};
	LoadFont("_r bold shadow 30px")..{
		Text="Barely!";
		InitCommand=function(self) self:draworder(9999):zoom(0.5):shadowlength(2):y(-8):diffusealpha(0):addy(-20) end;
		OnCommand=function(self) self:sleep(4.25):accelerate(0.2):diffusealpha(1):addy(20) end;
	};
};