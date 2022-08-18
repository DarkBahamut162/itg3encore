return Def.ActorFrame{
	LoadActor("logo")..{
		InitCommand=function(self) self:x(4):y(5):zoom(0.1) end;
		OnCommand=function(self) self:pulse():effectclock("beat"):effectperiod(0.83):effectmagnitude(1,1.25,0) end;
	};
	LoadActor("text")..{
		InitCommand=function(self) self:x(16):y(5):halign(0):zoom(0.125) end;
	};
};