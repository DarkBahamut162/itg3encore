return Def.ActorFrame{
	LoadActor("logo")..{
		InitCommand=function(self) self:x(4):y(2):zoom(0.1) end;
		OnCommand=function(self) self:spin():effectmagnitude(0,0,90) end;
	};
	LoadActor("outfox text")..{
		InitCommand=function(self) self:x(16):y(5):halign(0):zoom(0.1) end;
	};
};