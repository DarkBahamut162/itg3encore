return Def.ActorFrame{
	LoadActor("base")..{ InitCommand=function(self) self:y(35) end; };
	LoadActor("streak")..{
		InitCommand=function(self) self:y(185):addy(100) end;
		OnCommand=function(self) self:sleep(0.8):decelerate(0.6):addy(-100) end;
	};
	LoadActor("streak")..{
		InitCommand=function(self) self:y(204):addy(100) end;
		OnCommand=function(self) self:sleep(1):decelerate(0.6):addy(-100) end;
	};
};